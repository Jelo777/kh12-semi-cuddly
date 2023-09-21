<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-1000">
	
	<div class="row">
		<img src="localhost:8080/cuddly/admin/image?productNo=${productDto.productNo}" width="200" height="200">
	</div>
	<div class="row">
		<h2>${productDto.productName}</h2>
		상품번호 : ${productDto.productNo}
	</div>
	<div class="row">
		<h2>가격 : ${productDto.productPrice}</h2>
	</div>
	<div class="row">
		등록일 : ${productDto.productDate}
	</div>
	<div class="row">
		평점 : ${reviewAvg}
	</div>
</div>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>