package com.octo.red.happystore.performance;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;
import org.springframework.util.ConcurrentReferenceHashMap;

/**
 * @author Henri Tremblay
 */
@Service
public class CacheManager {

    public static transient boolean enabled = true;

    private Map<String, Map<Object, byte[]>> cacheList = new ConcurrentHashMap<String, Map<Object, byte[]>>();

    private AtomicLong hit = new AtomicLong(0);
    private AtomicLong success = new AtomicLong(0);

    @SuppressWarnings("unchecked")
    public <T> T getFromCache(String cacheKey, Object key) {
        hit.incrementAndGet();
        Map<Object, byte[]> cache = cacheList.get(cacheKey);
        if(cache == null) {
            return null;
        }
        byte[] buffer = cache.get(key);
        if(buffer != null) {
            success.incrementAndGet();
            return unmarshall(buffer);
        }
        return null;
    }

    public void addToCache(String cacheKey, Object key, Object value) {
        Map<Object, byte[]> cache = cacheList.get(cacheKey);
        if(cache == null) {
            cache = new ConcurrentHashMap<Object, byte[]>();
            cacheList.put(cacheKey, cache);
        }
        // Put the object off-heap to be easy on the GC
        byte[] buffer = marshall(value);
        cache.put(key, buffer);
    }

    public long getHit() {
        return hit.get();
    }

    public long getSuccess() {
        return success.get();
    }

    public synchronized double getHitRatio() {
        return (double) success.get() / (double) hit.get();
    }

    public synchronized void clearStatistics() {
        hit.set(0);
        success.set(0);
    }

    private static byte[] marshall(Object o) {
        ByteArrayOutputStream out = new ByteArrayOutputStream(4096);
        try {
            ObjectOutputStream oout = new ObjectOutputStream(out);
            oout.writeObject(o);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                out.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return out.toByteArray();
    }

    @SuppressWarnings("unchecked")
    private static <T> T unmarshall(byte[] buffer) {
        ObjectInputStream in;
        try {
            in = new ObjectInputStream(new ByteArrayInputStream(buffer));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        try {
            return (T) in.readObject();
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                in.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
