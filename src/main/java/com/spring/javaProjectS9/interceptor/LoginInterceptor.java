package com.spring.javaProjectS9.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession session = request.getSession();
		boolean loginCheck = session.getAttribute("sMid")!=null ? true : false;
		if(loginCheck) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/needLogin");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
		
	}
}
