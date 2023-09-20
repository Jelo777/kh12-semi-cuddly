<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 목록</title>
</head>
<body>
    <h1>주문 목록</h1>
    
    <table border="1">
        <tr>
            <th>주문번호</th>
            <th>회원아이디</th>
            <th>배송지번호</th>
            <th>결제금액</th>
            <th>결제수단</th>
            <th>주문일자</th>
        </tr>
        <c:forEach var="order" items="${orderList}">
            <tr>
                <td>${order.ordersNo}</td>
                <td>${order.memberId}</td>
                <td>${order.addressNo}</td>
                <td>${order.ordersPrice}</td>
                <td>${order.ordersPayment}</td>
                <td>${order.ordersDate}</td>
            </tr>
        </c:forEach>
    </table>

    <a href="<c:url value='/cuddly/orders/insert'/>">새로운 주문 등록하기</a>
</body>
</html>
