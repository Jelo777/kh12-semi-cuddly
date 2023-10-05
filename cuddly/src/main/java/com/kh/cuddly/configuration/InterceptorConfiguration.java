package com.kh.cuddly.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.cuddly.interceptor.AdminInterceptor;
import com.kh.cuddly.interceptor.CartInterceptor;
import com.kh.cuddly.interceptor.MemberInterceptor;
import com.kh.cuddly.interceptor.ProductDefenderInterceptor;
import com.kh.cuddly.interceptor.ReviewInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private ProductDefenderInterceptor productDefenderInterceptor;
	
	@Autowired
	private ReviewInterceptor reviewInterceptor;
	
	@Autowired
	private CartInterceptor cartInterceptor;
	
	public void addInterceptors(InterceptorRegistry registry) {
		//관리자 아닐 때 차단
		registry.addInterceptor(adminInterceptor)
		.addPathPatterns(
				"/cuddly/admin/**",
				"/cuddly/faq/edit",//관리자만 공지사항 작성 수정 삭제 가능
				"/cuddly/faq/write",
				"/cuddly/faq/delete"
				);
		//비로그인일 때 차단
		registry.addInterceptor(memberInterceptor)
		.addPathPatterns(
				"/cuddly/member/**",
				"/cuddly/orders/list",
				"/cuddly/review/memberList",
				"/cuddly/qna/memberList"
				)
		.excludePathPatterns(
				"/cuddly/member/join",
				"/cuddly/member/joinFinish",
				"/cuddly/member/login",
				"/cuddly/member/find*",
				"/cuddly/member/exitFinish",
				"/cuddly/member/mypage",//어짜피 로그인 창으로 가짐
				"/cuddly/member/mypage/wishlist"//어짜피 로그인 창으로 가짐
				
				);
		
		
		//없는 상품 차단
		registry.addInterceptor(productDefenderInterceptor)
				.addPathPatterns(
						"/cuddly/product/detail",
						"/cuddly/review/write"
						);
		//자기가 구매하지 않은 상품 리뷰 차단
		registry.addInterceptor(reviewInterceptor)
				.addPathPatterns(
						"/cuddly/review/write"
//						"/cuddly/review/edit"
						);
		
		//자기 장바구니에 없는 물건 구매 차단
		registry.addInterceptor(cartInterceptor)
				.addPathPatterns(
						"/cuddly/orders/insert"
						);
		
		
		
		
		
		
		
	}

}
