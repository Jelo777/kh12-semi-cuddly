<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 목록</title>
</head>
<body>
    <h1>장바구니 목록</h1>

	<form action="insert" method="get">
        <c:forEach items="${cartList}" var="cart">
            <a href="/cuddly/product/detail?productNo=${cart.productNo}"><img src="/cuddly/image/product/main?productNo=${cart.productNo}" width="200" height="200"></a>
            	상품명 : ${cart.productName}
            	크리에이터 : ${cart.creatorName}
            	옵션 : ${cart.productOptionName}
               수량: ${cart.cartCount}
               가격 : ${cart.cartPrice}
               추가 날짜 : ${cart.cartDate}
               <input type="hidden" name="cartNo" value="${cart.cartNo}">
               <hr>
        </c:forEach>
       <button type="submit">주문하기</button>
        </form>
    
</body>
</html>
