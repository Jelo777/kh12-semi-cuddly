<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-400">
	<h1>상세주문목록</h1>

	<c:forEach var="ordersDetailDto" items="${ordersDetailList}">
	
		<div class="float-container card">
			<span>주문상세번호 : ${ordersDetailDto.ordersDetailNo}</span>
		</div>
		<div class="row">
			<img src="/cuddly/image/product/main?productNo=${ordersDto.productNo}"  width="100" height="100">
		</div>
		<div class="row">
			<span>상품명 : ${ordersDetailDto.productName}</span>
		</div>
		<div class="row">
			<span> 크리에이터 : ${ordersDetailDto.creatorName}</span>
		</div>
		<div class="row left">
			<span>수량 : ${ordersDetailDto.ordersDetailCount}</span>
			<span>옵션 : ${ordersDetailDto.productOptionName}</span>
		</div>
		<div class="row left">
			<span>구매금액 : ${ordersDetailDto.ordersDetailPrice}</span>
		</div>		
	
	<a href="edit?memberId=${ordersDetailDto.memberId}"><button>돌아가기</button></a>
	</c:forEach>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>