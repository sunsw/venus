package com.sunsw.mercury.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 * 拦截器
 * Created by sunsw on 2016/4/12.
 */
@Component
public class CommonInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
		httpServletRequest.setAttribute("requestId", UUID.randomUUID().toString());
		return true;
	}
}
