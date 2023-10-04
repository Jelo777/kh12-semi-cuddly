package com.kh.cuddly.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.cuddly.interceptor.AdminInterceptor;
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
	
	public void addInterceptors(InterceptorRegistry registry) {
		//관리자 아닐 때 차단
		registry.addInterceptor(adminInterceptor)
		.addPathPatterns(
				"/cuddly/admin/**",
				"/cuddly/faq/edit",//관리자만 공지사항 작성 수정 가능
				"/cuddly/faq/write"
				);
		//비로그인일 때 차단
		registry.addInterceptor(memberInterceptor)
		.addPathPatterns(
				"/cuddly/member/**"
				
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
		
		registry.addInterceptor(reviewInterceptor)
				.addPathPatterns(
						"/cuddly/review/write"
						);
	}

}
