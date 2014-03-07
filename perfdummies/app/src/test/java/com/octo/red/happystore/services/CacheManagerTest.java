package com.octo.red.happystore.services;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * @author Henri Tremblay
 */
public class CacheManagerTest {

    private static final String KEY = "key";

    private CacheManager cm = new CacheManager();

    @Test
    public void testCache() throws Exception {
        assertNull(cm.getFromCache(KEY, "nil"));
        cm.addToCache(KEY, "a", "b");
        assertNull(cm.getFromCache(KEY, "nil"));
        assertEquals("b", cm.getFromCache(KEY, "a"));
    }
}
