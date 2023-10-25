<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-400">
	<h1>상세주문목록</h1>

	<c:forEach var="ordersDetailDto" items="${ordersDetailList}">
	<div class="float-container card">
	
		<div class="row left">
			<span>주문상세번호 : ${ordersDetailDto.ordersDetailNo}</span>
		</div>
		
		<div class="flat-left w-25 col-3">
			<img src="${pageContext.request.contextPath}/image/product/main?productNo=${ordersDetailDto.productNo}"  width="100" height="100">
		</div>
		
		<div class="row left">
			<span>상품명 : ${ordersDetailDto.productName}</span>
		</div>
		
		<div class="row left">
			<span> 크리에이터 : ${ordersDetailDto.creatorName}</span>
		</div>
		
		<div class="row left">
			<span>수량 : ${ordersDetailDto.ordersDetailCount}</span>
			<span>옵션 : ${ordersDetailDto.productOptionName}</span>
		</div>
		
		<div class="row left">
			<span>구매금액 : ${ordersDetailDto.ordersDetailPrice}</span>
		</div>		
		
	</div>
	</c:forEach>
	
	<a href="javascript:history.back();"><button>돌아가기</button></a>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>