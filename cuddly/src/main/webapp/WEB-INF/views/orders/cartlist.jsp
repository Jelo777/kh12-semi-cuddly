<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
</head>
<body>
    <h1>장바구니</h1>
    <table border="1">
        <tr>
            <th>상품 이름</th>
            <th>수량</th>
            <th>총 금액</th>
        </tr>
        <c:forEach var="cart" items="${cartList}">
            <tr>
            
                <td>${cart.productName}</td>
                <td>${cart.cartCount}</td>
                <td>${cart.cartPrice}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
