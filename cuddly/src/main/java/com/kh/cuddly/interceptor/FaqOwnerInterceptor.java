package com.kh.cuddly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.error.AuthorityException;

@Component
public class FaqOwnerInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
		
		HttpSession session =request.getSession();
		
		String level =(String) session.getAttribute("level");
		boolean isAdmin =level.equals("관리자");
		
		if(isAdmin) {
			return true;
		}
		else {
			
			throw new AuthorityException("관리자만 faq에 접근 가능");
		}
	}
}
