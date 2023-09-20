<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 목록</title>
</head>
<body>
    <h1>장바구니 목록</h1>
    <table border="1">
        <tr>
            <th>장바구니 번호</th>
            <th>회원 아이디</th>
            <th>옵션 번호</th>
            <th>수량</th>
            <th>총 금액</th>
            <th>추가 날짜</th>
        </tr>
        <c:forEach items="${cartList}" var="cart">
            <tr>
                <td>${cart.cartNo}</td>
                <td>${cart.memberId}</td>
                <td>${cart.optionNo}</td>
                <td>${cart.cartCount}</td>
                <td>${cart.cartPrice}</td>
                <td>${cart.cartDate}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
