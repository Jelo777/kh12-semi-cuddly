<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보 입력</title>
</head>
<body>
    <h1>주문 정보 입력</h1>
    
    <form action="#" method="post">
    
    
    <br><br>
    <h4>주문자정보</h4>
     
        
        <label for="memberId">회원아이디 : </label>
        <input type="text" name="memberId" required> <br>
        
        <label for="addressNo">배송지번호 : </label>
        <input type="text" name="addressNo" required> <br>
 	
 		<label for="ordersPrice">결제금액 : </label>
        <input type="text" name="ordersPrice" required> <br>
        
        <label for="ordersPayment">결제수단 : </label>
        <input type="text" name="ordersPayment" required> <br>
        
    
        
       
        <input type="submit" value="주문해보기">
    </form>
</body>
</html>
