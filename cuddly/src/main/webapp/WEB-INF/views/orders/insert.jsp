<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보 입력</title>
</head>
<body>
    <h1>주문 정보 입력</h1>
    
    
    
    <br><br>
    <h4>주문자정보</h4>
     <br>
     
     <div class="row">
    	<label>이름: </label>
    	${memberDto.memberName}
     </div>
     <div class="row">
    	<label>이메일: </label>
    	${memberDto.memberEmail}
     </div>
     <div class="row">
    	<label>전화번호: </label>
    	${memberDto.memberContact}
     </div>
     
     <br><br>
     
    <h1>배송지 정보</h1><br><br>
     	
        <div class="row">
        <label>수령인 : </label>
        ${addressDto.addressName}
        </div>
         <br><br>
 	
 		 <div class="row">
        <label>전화번호 : </label>
        ${addressDto.addressContact}
        </div>
         <br><br>
         
          <div class="row">
        <label>우편번호 : </label>
         ${addressDto.addressPost}
        
        </div>
         <br><br>
         
          <div class="row">
        <label>기본주소 : </label>
        ${addressDto.addressAddr1}
        </div>
         <br><br>
         
          <div class="row">
        <label>상세주소 : </label>
         ${addressDto.addressAddr2}
        </div>
         <br><br>
         
          <div class="row">
        <label>요청사항 : </label>
         ${addressDto.addressComent}
        </div>
         <br><br>
         
        
    
    	<h1>주문할 상품 정보</h1>

<c:forEach var="product" items="${ordersProductDto}">

	<div class="row">
   <img src="image?productNo=${product.productNo}" width="200" height="200">
  </div>

  <div class="row">
    <label>상품 이름:</label>${product.productName}
  </div>
  
  <div class="row">
    <label>크리에이터:</label>${product.creatorName}
  </div>
  
  <div class="row">
    <label>상품 가격:</label>${product.productPrice}
  </div>
  
  <div class="row">
    <label>옵션:</label>${product.productOptionName}
  </div>
  
  <div class="row">
    <label>수량:</label>${product.productOptionStock}
  </div>
  <br><br>
</c:forEach>

	
<div class="row">
    <label>총가격:</label>${total}
  </div>
    	
    	
    	
    	
        
       
        <button>주문하기</button>
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</body>
</html>