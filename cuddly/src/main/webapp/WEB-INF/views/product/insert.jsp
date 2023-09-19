<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
</head>
<body>
<form action="insert" method="post">
	<h1>상품등록</h1>
	상품명<input name="productName"><br><br>
	판매가<input type="number" name="productPrice"><br><br>
	옵션이름<input name="productOptionName"><br><br>
	재고수량<input type="number" name="productOptionStock"><br><br>
	<button>상품등록</button>
</form>
</body>
</html>