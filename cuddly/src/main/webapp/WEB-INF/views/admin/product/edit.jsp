<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
</head>
<body>

<form action="edit" method="post" enctype="multipart/form-data">
	<div class="container w-600">
		<div class="row">
			<h1>${productDto.productName} 수정</h1>
		</div>
		
		<div class="row">
			<img src="/cuddly/admin/image?productNo=${productDto.productNo}" width="200" height="200"><br><br>
		</div>
		
		<div class="row">
			<h3>${productDto.productName}</h3><br>
			<h3>${creatorDto.creatorName}</h3><br>
			<h3>${productDto.productPrice}</h3><br>
		</div> 
		<div class="row left">
		<h2>옵션</h2><br>
		<select class="form-input w-50">
			<option>옵션1</option>
			<option>옵션2</option>
			<option>옵션3</option>
			<option>옵션4</option>
		</select>
		</div>
		
		
	</div>
</form>
	
</body>
</html>