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
    
  <c:forEach var="detail" items="${ordersDetailDto}">
          <div class="row">   <img src="/cuddly/image/product/main?productNo=${detail.productNo}" width="200" height="200"></div>
          
          <div class="row">  상품 이름: ${detail.productName}</div>
          <div class="row">  크리에이터: ${detail.creatorName}</div>
          <div class="row">  옵션 이름: ${detail.productOptionName}</div>
          <div class="row">  주문 수량: ${detail.ordersDetailCount}</div>
           <div class="row"> 주문 가격: ${detail.ordersDetailPrice}</div>
           <div class="row"> 주문 날짜: ${detail.ordersDate}</div>
           <a href="/cuddly/review/write?productNo=${detail.productNo}">리뷰쓰기</a>
           <hr>
</c:forEach>

     
       
   
</body>
</html>
