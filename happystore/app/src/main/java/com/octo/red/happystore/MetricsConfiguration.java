package com.octo.red.happystore;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.graphite.Graphite;
import com.codahale.metrics.graphite.GraphiteReporter;
import com.codahale.metrics.health.HealthCheckRegistry;
import com.codahale.metrics.jvm.*;
import com.ryantenney.metrics.spring.config.annotation.EnableMetrics;
import com.ryantenney.metrics.spring.config.annotation.MetricsConfigurerAdapter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.env.PropertyResolver;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import java.lang.management.ManagementFactory;
import java.net.InetSocketAddress;
import java.util.concurrent.TimeUnit;


@Configuration
@EnableMetrics(proxyTargetClass = true)
public class MetricsConfiguration extends MetricsConfigurerAdapter implements EnvironmentAware {

    private static final String PROP_GRAPHITE_ENABLED = "metrics.graphite.enabled";
    private static final String PROP_PORT = "metrics.graphite.port";
    private static final String PROP_HOST = "metrics.graphite.host";
    private static final String PROP_METRIC_REG_JVM_MEMORY = "metrics.jvm.memory";
    private static final String PROP_METRIC_REG_JVM_GARBAGE = "metrics.jvm.garbage";
    private static final String PROP_METRIC_REG_JVM_THREADS = "metrics.jvm.threads";
    private static final String PROP_METRIC_REG_JVM_FILES = "metrics.jvm.files";
    private static final String PROP_METRIC_REG_JVM_BUFFERS = "metrics.jvm.buffers";

    private final Logger log = LoggerFactory.getLogger(MetricsConfiguration.class);

    private static final MetricRegistry METRIC_REGISTRY = new MetricRegistry();

    private static final HealthCheckRegistry HEALTH_CHECK_REGISTRY = new HealthCheckRegistry();

    private PropertyResolver propertyResolver;

    @Override
    public void setEnvironment(Environment environment) {
        this.propertyResolver =  environment;
    }

    @Override
    @Bean
    public MetricRegistry getMetricRegistry() {
        return METRIC_REGISTRY;
    }

    @Override
    @Bean
    public HealthCheckRegistry getHealthCheckRegistry() {
        return HEALTH_CHECK_REGISTRY;
    }

    @PostConstruct
    public void init() {
        log.debug("Registring JVM gauges");
        METRIC_REGISTRY.register(PROP_METRIC_REG_JVM_MEMORY, new MemoryUsageGaugeSet());
        METRIC_REGISTRY.register(PROP_METRIC_REG_JVM_GARBAGE, new GarbageCollectorMetricSet());
        METRIC_REGISTRY.register(PROP_METRIC_REG_JVM_THREADS, new ThreadStatesGaugeSet());
        METRIC_REGISTRY.register(PROP_METRIC_REG_JVM_FILES, new FileDescriptorRatioGauge());
        METRIC_REGISTRY.register(PROP_METRIC_REG_JVM_BUFFERS, new BufferPoolMetricSet(ManagementFactory.getPlatformMBeanServer()));
    }

    @Configuration
    public static class GraphiteRegistry implements EnvironmentAware {

        private final Logger log = LoggerFactory.getLogger(GraphiteRegistry.class);

        @Inject
        private MetricRegistry metricRegistry;

        private PropertyResolver propertyResolver;

        @Override
        public void setEnvironment(Environment environment) {
            this.propertyResolver = environment;
        }

        @PostConstruct
        private void init() {
            Boolean graphiteEnabled = propertyResolver.getProperty(PROP_GRAPHITE_ENABLED, Boolean.class, false);
            if (graphiteEnabled) {
                log.info("Initializing Metrics Graphite reporting");
                String graphiteHost = propertyResolver.getRequiredProperty(PROP_HOST);
                Integer graphitePort = propertyResolver.getRequiredProperty(PROP_PORT, Integer.class);
                Graphite graphite = new Graphite(new InetSocketAddress(graphiteHost, graphitePort));
                GraphiteReporter graphiteReporter = GraphiteReporter.forRegistry(metricRegistry)
                        .convertRatesTo(TimeUnit.SECONDS)
                        .convertDurationsTo(TimeUnit.MILLISECONDS)
                        .build(graphite);
                graphiteReporter.start(1, TimeUnit.MINUTES);
            }
        }
    }
}
