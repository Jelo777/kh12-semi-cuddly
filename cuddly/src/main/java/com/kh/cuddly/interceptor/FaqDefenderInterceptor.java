package com.kh.cuddly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.dao.FaqDao;
import com.kh.cuddly.dto.FaqDto;
import com.kh.cuddly.error.NoTargetException;

@Component
public class FaqDefenderInterceptor implements HandlerInterceptor{
	
	@Autowired
	private FaqDao faqdao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		int faqNo=Integer.parseInt(request.getParameter("faqNo"));
		FaqDto faqDto =faqdao.selectOne(faqNo);
		
		if(faqDto==null) {
			throw new NoTargetException("존재하지 않는 공지사항 글");
		}
		
		return true;

		
		
		
	}
	
	
	
}
