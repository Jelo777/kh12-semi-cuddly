package com.kh.cuddly.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.cuddly.interceptor.AdminInterceptor;
import com.kh.cuddly.interceptor.CartInterceptor;
import com.kh.cuddly.interceptor.FaqDefenderInterceptor;
import com.kh.cuddly.interceptor.FaqOwnerInterceptor;
import com.kh.cuddly.interceptor.MemberInterceptor;
import com.kh.cuddly.interceptor.ProductDefenderInterceptor;
import com.kh.cuddly.interceptor.ReviewWriteInterceptor;
import com.kh.cuddly.interceptor.ReviewOwnerInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private ProductDefenderInterceptor productDefenderInterceptor;
	
	@Autowired
	private ReviewWriteInterceptor reviewWriteInterceptor;
	
	@Autowired
	private CartInterceptor cartInterceptor;
	
	@Autowired
	private ReviewOwnerInterceptor reviewOwnerInterceptor;
	
	@Autowired
	private FaqOwnerInterceptor faqOwnerInterceptor;
	
	@Autowired
	private FaqDefenderInterceptor faqDefenderInterceptor;
	
	
	
	public void addInterceptors(InterceptorRegistry registry) {
		//관리자 아닐 때 관리자 페이지 차단
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns(
				"/cuddly/admin/**"

				);
		//관리자 아닐 때 faq 기능 차단
		registry.addInterceptor(faqOwnerInterceptor)
				.addPathPatterns(
				"/cuddly/faq/edit",//관리자만 공지사항 작성 수정 삭제 가능
				"/cuddly/faq/write",
				"/cuddly/faq/delete"	
				);
		//없는 공지사항 상세,faq 기능들 차단
		registry.addInterceptor(faqDefenderInterceptor)
				.addPathPatterns(
				"/cuddly/faq/detail",
				"/cuddly/faq/edit",
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
		registry.addInterceptor(reviewWriteInterceptor)
				.addPathPatterns(
						"/cuddly/review/write"
						);
		
		//자기가 쓰지 않은 리뷰 수정 삭제 차단
		registry.addInterceptor(reviewOwnerInterceptor)
				.addPathPatterns(
						"/cuddly/review/edit",
						"/cuddly/review/delete"
						);
		//자기 장바구니에 없는 물건 구매 차단
		registry.addInterceptor(cartInterceptor)
				.addPathPatterns(
						"/cuddly/orders/insert"
						);
		
		
		
		
		
		
		
		
	}

}
