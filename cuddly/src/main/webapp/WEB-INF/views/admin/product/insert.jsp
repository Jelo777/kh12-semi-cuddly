<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
	<div class="container w-600">
		<form action="insert" method="post" autocomplete="off" enctype="multipart/form-data">
		<div class="row">
			<h1>상품등록</h1>
		</div>
		<div class="row">
			<select class="form-input w-100" name="productItem">
				<option>품목선택</option>
				<option value="의류">의류</option>
				<option value="스티커/지류">스티커/지류</option>
				<option value="폰악세서리">폰악세서리</option>
				<option value="리빙">리빙</option>
				<option value="문구/오피스">문구/오피스</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<div class="row">
			<input class="form-input w-100" name="creatorName" placeholder="크리에이터 입력">
		</div>
		<div class="row">
			<input class="form-input w-100" name="productName" placeholder="상품명 입력">
		</div>
		<div class="row">
			<input class="form-input w-100" type="number" name="productPrice" placeholder="가격 입력">
		</div>
		<div class="row left">
			메인이미지
			<input class="form-input w-100" type="file" name="attachMain" accept="image/*" placeholder="대표이미지"> <br><br>
		</div>
		<div class="row left">
			상세이미지
			<input class="form-input w-100" type="file" name="attachDetail" accept="image/*" placeholder="상세이미지"> <br><br>
		</div>
		<div class="row">
			<button class="btn btn-positive w-100">상품등록</button>
		</div>
	</form>
	</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
