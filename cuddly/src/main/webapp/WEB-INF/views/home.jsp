<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- swiper cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
	$(function() {
		var swiper = new Swiper('.swiper', {
			// Optional parameters
			//direction: 'vertical',//슬라이드 방향 - 기본은 수평
			loop : true,//슬라이드 순환 설정 - 기본은 x

			// If we need pagination
			pagination : {
				el : '.swiper-pagination',//적용할 요소
				type : "bullets",//페이지네이션 유형(progressbar/fraction/bullets)
			//clickable:true,//페이지네이션 클릭 가능여부
			},

			// 이동 화살표
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
				hideOnClick : true,//클릭 시 숨김 처리 여부
			},

			// 스크롤바
			// scrollbar: {
			//     el: '.swiper-scrollbar',
			// },

			//자동재생
			autoplay : {
				delay : 2000,//재생간격(ms)
				pauseOnMouseEnter : true,//마우스 진입 시 멈춤 여부
			},

			//이펙트(전환효과) 설정
			effect : "slide",//(slide/fade/cube/coverflow/flip/creative/cards)
		});
	});
</script>


<div class="container w-900">
	<div class="row">
		<!-- Slider main container -->
		<div class="swiper">
			<!-- Additional required wrapper -->
			<div class="swiper-wrapper">
				<!-- Slides -->
				<div class="swiper-slide">
					<img src="https://picsum.photos/id/100/600/300" width="100%"
						height="100%">
				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/id/120/600/300" width="100%"
						height="100%">
				</div>
				<div class="swiper-slide">
					<img src="https://picsum.photos/id/103/600/300" width="100%"
						height="100%">
				</div>
			</div>
			<!-- If we need pagination -->
			<div class="swiper-pagination"></div>

			<!-- If we need navigation buttons -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>

			<!-- If we need scrollbar -->
			<!-- <div class="swiper-scrollbar"></div> -->
		</div>
	</div>




	<div class="row">
		<h2 class=" mt-50">신상품</h2>
	</div>
	<c:forEach var="productListDto" items="${sortByNew}" end="3">
		<a class="link" href="cuddly/product/detail?productNo=${productListDto.productNo}">
			<div class="inline-flex-container allow-wrap left mh-10">
				<table class="">
					<tr>
						<td><img
							src="/cuddly/image/product/main?productNo=${productListDto.productNo}"
							onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
							width="200" height="200"
							class="image image-round"></td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${productListDto.productNo}</td> --%>
<!-- 					</tr> -->
					<tr>
						<td class="productName">${productListDto.productName}</td>
					</tr>
					<tr>
						<td class="productPrice">${productListDto.productPrice}원</td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${productListDto.productDate}</td> --%>
<!-- 					</tr> -->
				</table>
			</div>
		</a>
	</c:forEach>
	<div class="row">
		<a class="link"
			href="cuddly/product/list?${vo.getQueryStringNew()}">
			<h3 class="btn btn-more">신상품 더보기</h3>
		</a>
	</div>

	<div class="row">
		<h2 class=" mt-50">베스트상품</h2>
	</div>
	<c:forEach var="productListDto" items="${sortByBest}" end="3">
		<a class="link" href="cuddly/product/detail?productNo=${productListDto.productNo}">
			<div class="inline-flex-container allow-wrap left mh-10">
				<table class="">
					<tr>
						<td><img
							src="/cuddly/image/product/main?productNo=${productListDto.productNo}"
							onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
							width="200" height="200"
							class="image image-round"></td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${productListDto.productNo}</td> --%>
<!-- 					</tr> -->
					<tr>
						<td class="productName">${productListDto.productName}</td>
					</tr>
					<tr>
						<td class="productPrice">${productListDto.productPrice}원</td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${productListDto.productDate}</td> --%>
<!-- 					</tr> -->
				</table>
			</div>
		</a>
	</c:forEach>
	<div class="row">
		<a class="link"
			href="cuddly/product/list?${vo.getQueryStringPopular()}">
			<h3 class="btn btn-more">베스트상품 더보기</h3>
		</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>