package com.octo.red.happystore.performance;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by Henri on 03/04/2014.
 */
public class StatFilter implements Filter {

    private static final Logger log = LoggerFactory.getLogger(StatFilter.class);

    public static transient boolean enableLock = true;

    private static final Lock lock = new ReentrantLock();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("************** Happy store started **************");
        PerformanceMBean.init();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if(enableLock) {
            lock.lock();
        }
        try {
            long start = System.currentTimeMillis();
            String url = ((HttpServletRequest) request).getRequestURL().toString();
            String queryString = ((HttpServletRequest) request).getQueryString();
            chain.doFilter(request, response);
            long end = System.currentTimeMillis();
            log.info(url + "?" + queryString + ":" + (end - start) + "ms");
        }
        finally {
            if(enableLock) {
                lock.unlock();
            }
        }
    }

    @Override
    public void destroy() {
        System.out.println("************** Happy store stopped **************");
    }
}
