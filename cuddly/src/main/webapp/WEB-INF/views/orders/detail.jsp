<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 정보</title>
</head>
<body>
    <h1>주문 상세 정보</h1>
  

       <div class="row">
            주문 상세 번호 : ${ordersDetailDto.ordersDetailNo}</div>
            
          <div class="row">   <img src="/cuddly/image/product/main?productNo=${ordersDetailDto.productNo}" width="200" height="200"></div>
         <div class="row">   주문 번호: ${ordersDetailDto.ordersNo}</div>
          <div class="row">  옵션 번호: ${ordersDetailDto.optionNo}</div>
           <div class="row"> 상품 번호: ${ordersDetailDto.productNo}</div>
          <div class="row">  주문 수량: ${ordersDetailDto.ordersDetailCount}</div>
           <div class="row"> 주문 가격: ${ordersDetailDto.ordersDetailPrice}</div>
       
   
</body>
</html>
