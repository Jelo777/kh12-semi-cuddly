package com.kh.cuddly.interceptor;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.error.AuthorityException;

@Component
public class CartInterceptor implements HandlerInterceptor{
	
	@Autowired
	private CartDao cartDao;

	@Override
	public boolean preHandle(HttpServletRequest request, 
							HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		String memberId=(String) session.getAttribute("name");
		
		String[] cartNumbers = request.getParameterValues("cartNo");
		
		List<CartDto> cartItems = cartDao.CartListByMemberId(memberId);
		
	    for (String clientCartNumber : cartNumbers) {
	        boolean isValidCartNumber = false;
	        for (CartDto cartItem : cartItems) {
	            if (clientCartNumber.equals(String.valueOf(cartItem.getCartNo()))) {
	                isValidCartNumber = true;
	                break;
	            }
	        }
	        if (!isValidCartNumber) {
	            throw new AuthorityException("장바구니에 없는 상품입니다");
	        }
	    }
	    

	    return true;
	}

}
