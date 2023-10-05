package com.kh.cuddly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.error.NoTargetException;

@Component
public class ProductDefenderInterceptor implements HandlerInterceptor {
	
	@Autowired
	private ProductDao productDao;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
		
		
		
		int productNo=Integer.parseInt(request.getParameter("productNo"));
		ProductDto productDto =productDao.selectOne(productNo);
		if(productDto ==null) {
			throw new NoTargetException("존재하지 않는 상품");
		}
		return true;
		
	}
}
