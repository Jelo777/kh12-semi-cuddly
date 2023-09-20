<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 정보</title>
</head>
<body>
    <h1>주문 상세 정보</h1>
    <table border="1">
        <tr>
            <th>주문 상세 번호</th>
            <th>주문 번호</th>
            <th>옵션 번호</th>
            <th>상품 번호</th>
            <th>주문 수량</th>
            <th>주문 가격</th>
        </tr>
        <tr>
            <td>${ordersDetailDto.ordersDetailNo}</td>
            <td>${ordersDetailDto.ordersNo}</td>
            <td>${ordersDetailDto.optionNo}</td>
            <td>${ordersDetailDto.productNo}</td>
            <td>${ordersDetailDto.ordersDetailCount}</td>
            <td>${ordersDetailDto.ordersDetailPrice}</td>
        </tr>
    </table>
</body>
</html>
