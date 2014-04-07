package com.octo.red.happystore.performance;

import org.springframework.jmx.export.annotation.ManagedAttribute;
import org.springframework.jmx.export.annotation.ManagedOperation;
import org.springframework.jmx.export.annotation.ManagedResource;
import org.springframework.stereotype.Component;

/**
 * Created by Henri on 04/04/2014.
 */
@Component
@ManagedResource(objectName="bean:name=performance", description="Performance enabler")
public class PerformanceMBean {

    public static void init() {
        StatFilter.enableLock = Boolean.parseBoolean(System.getProperty("statFilterEnabled", "true"));
        CacheManager.enabled = Boolean.parseBoolean(System.getProperty("cacheEnabled", "true"));
    }

    @ManagedAttribute(description="If the Stat filter (contention issue) is enabled")
    public boolean isStatFilterEnabled() {
        return StatFilter.enableLock;
    }

    @ManagedAttribute(description="If the Stat filter (contention issue) is enabled")
    public void setStatFilterEnabled(boolean enable) {
        StatFilter.enableLock = enable;
    }

    @ManagedAttribute(description="If the cache is actually caching")
    public boolean isCacheEnabled() {
        return CacheManager.enabled;
    }

    @ManagedAttribute(description="If the cache is actually caching")
    public void setCacheEnabled(boolean enable) {
        CacheManager.enabled = enable;
    }
}
