package com.kh.cuddly.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.error.AuthorityException;
import com.kh.cuddly.error.NoTargetException;

@Component
public class ReviewOwnerInterceptor implements HandlerInterceptor {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		HttpSession session=request.getSession();
		String memberId =(String)session.getAttribute("name");
		
		int reviewNo =Integer.parseInt(request.getParameter("reviewNo"));
		ReviewDto reviewDto =reviewDao.selectOne(reviewNo);
		if(reviewDto==null) {
			throw new NoTargetException("존재하지 않는 리뷰글입니다");
		}
		
		else if(reviewDto.getMemberId().equals(memberId)) {
			return true;
		}
		else {
			throw new AuthorityException("자신의 리뷰가 아닙니다");
		}
	}
	
	
}
