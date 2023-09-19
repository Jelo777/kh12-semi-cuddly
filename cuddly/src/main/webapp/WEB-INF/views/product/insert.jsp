<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="insert" method="post">
	<div class="container w-600">
		<div class="row">
			<h1>상품등록</h1>
		</div>
		<div class="row left">
			상품명
			<input class="form-input w-100" name="productName">
		</div>
		<div class="row left">
			판매가
			<input class="form-input w-100" type="number" name="productPrice">
		</div>
		<div class="row left">
			옵션이름
			<input class="form-input w-100" name="productOptionName">
		</div>
		<div class="row left">
			재고수량
			<input class="form-input w-100" type="number" name="productOptionStock"><br><br>
		</div>
		<div class="row">
			<button class="btn btn-positive w-100">상품등록</button>
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>