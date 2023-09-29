<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<title>주문 목록</title>
<style>
.card {
	/* border: 1px solid #2d3436; */
	box-shadow: 0px 0px 0px 1px black;
	border-radius: 0.2em;
}

.row {
	padding: 0.5em 1em;
}
</style>



<body>
<script>

$(function(){

	
	
	
})


</script>










	<h1>나의 주문 목록</h1>

	<c:forEach var="detail" items="${list}">
		<div class="container w-600">
			<div class="flex-container card mv-10">
				<div class="row w-25 me-20">
					<a href="/cuddly/product/detail?productNo=${detail.productNo}"><img src="/cuddly/image/product/main?productNo=${detail.productNo}"
						width="150" height="200"></a>
				</div>
				<div class="w-75">
					주문 번호 : ${detail.ordersNo}
					<div class="row left title">상품 이름: ${detail.productName}</div>
					<div class="row flex-container auto-width">
						<div class="left felx-container">크리에이터:
							${detail.creatorName}</div>
						<div class="right">옵션 이름: ${detail.productOptionName} / 주문
							수량: ${detail.ordersDetailCount}</div>
					</div>
					<div class="row left">주문 가격: ${detail.ordersDetailPrice}</div>
					<div class="row right">주문 날짜: ${detail.ordersDate}</div>
					<div class="row left">총 주문 가격: ${detail.ordersPrice}원</div>
					<div class="row right">
					
					
					<c:choose>
					<c:when test="${detail.two}">
						<a href="/cuddly/orders/detail?ordersNo=${detail.ordersNo}">
							외 ${detail.orderCount}건 더보기</a>
					
							</c:when>
							
					<c:otherwise>
					
					<c:if test="${!detail.reviewEx}">
					<a href="/cuddly/review/write?productNo=${detail.productNo}">리뷰쓰기</a>
					</c:if>
					</c:otherwise>
							</c:choose>
					</div>
				</div>
				<hr>
			</div>
		</div>
	</c:forEach>


</body>
</html>
