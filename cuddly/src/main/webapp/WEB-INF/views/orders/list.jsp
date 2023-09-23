<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 목록</title>
</head>
<body>
    <h1>나의 주문 목록</h1>
    
    <c:forEach var="detail" items="${list}">
	 
          <div class="row">   <img src="/cuddly/image/product/main?productNo=${detail.productNo}" width="200" height="200">
          
          	상품 번호 : ${detail.ordersNo}
           상품 이름: ${detail.productName}
           크리에이터: ${detail.creatorName}
          옵션 이름: ${detail.productOptionName}
            주문 수량: ${detail.ordersDetailCount}
            주문 가격: ${detail.ordersDetailPrice}
           주문 날짜: ${detail.ordersDate}</div>
           <a href="/cuddly/orders/detail?ordersNo=${detail.ordersNo}">주문 상세 보기</a>
           <hr>
</c:forEach>
    
           

</body>
</html>
