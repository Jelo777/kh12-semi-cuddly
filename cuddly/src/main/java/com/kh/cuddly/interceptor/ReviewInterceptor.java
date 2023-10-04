package com.kh.cuddly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.error.AuthorityException;

@Component
public class ReviewInterceptor implements HandlerInterceptor{
	
	@Autowired
	private OrdersDao ordersDao;
	
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
		HttpSession session =request.getSession();
		String memberId=(String)session.getAttribute("name");
		
		
		int productNo=Integer.parseInt(request.getParameter("productNo"));
		
		OrderDetailJoinDto orderDetailDto=ordersDao.selectOneByProductNo(memberId, productNo);
		
		if(orderDetailDto !=null) {
			return true;
		}
		else {
			throw new AuthorityException("구매한 상품이 아닙니다");
		}
	}
	
	

}
