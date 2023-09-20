<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품등록</title>
</head>
<body>
	<h1>상품등록</h1>
	<form action="insert" method="post" autocomplete="off" enctype="multipart/form-data">
		<select name="categoryName">
			<option>품목선택</option>
			<option>품목1</option>
			<option>품목2</option>
			<option>품목3</option>
			<option>품목4</option>
			<option>품목5</option>
		</select> <br><br>
		<input type="text" name="categoryName" placeholder="크리에이터 입력"> <br><br>
		
		<input type="text" name="productName" placeholder="상품명 입력"> <br><br>
		<input type="number" name="productPrice" placeholder="가격 입력"> <br><br>
		
		<input type="file" name="attachMain" accept="image/*" placeholder="대표이미지"> <br><br>
		<input type="file" name="attachDetail" accept="image/*" placeholder="상세이미지"> <br><br>
		<button>상품등록</button>
	</form>
</body>
</html>