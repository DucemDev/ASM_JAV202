package com.cafe.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class RateLimitingFilter implements Filter {


    private static final Map<String, RequestInfo> requestMap = new ConcurrentHashMap<>();

    private static final long TIME_WINDOW = 60 * 1000; // 1 phút

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String ip = req.getRemoteAddr();


        if (!isProtectedEndpoint(uri)) {
            chain.doFilter(request, response);
            return;
        }


        String key = ip + ":" + uri;

        long now = System.currentTimeMillis();

        requestMap.putIfAbsent(key, new RequestInfo(0, now));

        RequestInfo info = requestMap.get(key);

        int maxRequest = getLimitByEndpoint(uri);

        synchronized (info) {


            if (now - info.startTime > TIME_WINDOW) {
                info.count = 0;
                info.startTime = now;
            }

            info.count++;

            if (info.count > maxRequest) {

                resp.sendError(429);
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isProtectedEndpoint(String uri) {
        return uri.contains("/login")
                || uri.contains("/online-orders")
                || uri.contains("/confirm")
                || uri.contains("/verify-forgot-password")
                || uri.contains("/verifyotp");
    }

    private int getLimitByEndpoint(String uri) {

        if (uri.contains("/login")) {
            return 5;
        }

        if (uri.contains("/confirm")) {
            return 10;
        }

        if (uri.contains("/online-orders")) {
            return 30;
        }

        if (uri.contains("/verify-forgot-password")) {
            return 10;
        }

        if (uri.contains("/verifyotp")) {
            return 10;
        }

        return 20;
    }

    static class RequestInfo {
        int count;
        long startTime;

        public RequestInfo(int count, long startTime) {
            this.count = count;
            this.startTime = startTime;
        }
    }
}