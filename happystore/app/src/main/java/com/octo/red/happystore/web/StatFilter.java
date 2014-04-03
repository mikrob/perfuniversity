package com.octo.red.happystore.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by Henri on 03/04/2014.
 */
public class StatFilter implements Filter {

    private static final Logger log = LoggerFactory.getLogger(StatFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("************** Happy store started **************");
    }

    @Override
    public synchronized void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        long start = System.currentTimeMillis();
        String url = ((HttpServletRequest)request).getRequestURL().toString();
        String queryString = ((HttpServletRequest)request).getQueryString();
        chain.doFilter(request, response);
        long end = System.currentTimeMillis();
        log.info(url+"?"+queryString+":"+(end-start)+"ms");
    }

    @Override
    public void destroy() {
        System.out.println("************** Happy store stopped **************");
    }
}
