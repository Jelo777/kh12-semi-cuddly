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

<script>


$(function() {
	
	
	
	
	$(".btn.btn-order").click(function(e){
	
		
	var no = ${NoAddr};
	
	if(no){
		
		e.preventDefault();
		alert("기본 배송지를 설정해주세요")
		
	}
	
	
	if ($("input[type='checkbox']:checked").length === 0) {
	    e.preventDefault();
	    alert("결제방식을 선택해주세요");
	}
		
	})
	

})

</script>


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
     	
     	<div><a href="/cuddly/orders/addrInsert"><button>배송지 목록</button></a></div>
     	
     	
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
         
        
  <form action="insert" method="post">
    
    	<h1>주문할 상품 정보</h1>

	<c:forEach var="product" items="${ordersProductDto}" varStatus="loop">
    <input type="hidden" name="details[${loop.index}].optionNo" value="${product.productOptionNo}">
	<input type="hidden" name="cartNo" value="${product.cartNo}">
    <div class="row">
       <img src="/cuddly/image/product/main?productNo=${product.productNo}" width="200" height="200">
       <input type="hidden" name="details[${loop.index}].productNo" value="${product.productNo}">
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
        <label>수량:</label>${product.cartCount}
        <input type="hidden" name="details[${loop.index}].ordersDetailCount" value="${product.cartCount}">
    </div>
    <br><br>
</c:forEach>


	
<div class="row">
    <label>총가격:</label>${total}
  </div>
  
  <div class="row"><h1>결제 정보</h1></div>
  
  <input type="hidden" name="addressNo" value="${addressDto.addressNo}">
  <input type="hidden" name="ordersPrice" value="${total}">결제 금액:${total}
  
  
  
  <div class="row">
  <input type="checkbox" name="ordersPayment" value="네이버페이" class="payType">네이버 페이
  <input type="checkbox" name="ordersPayment" value="카카오페이" class="payType">카카오 페이
  <input type="checkbox" name="ordersPayment" value="무통장입금" class="payType">무통장 페이
  </div>
  
  
        <button class="btn btn-order">주문하기</button>
    	</form>
    	
    	
    	
        
       
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</body>
</html>