<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600">
	<div class="row">
		<h2>${creatorDto.creatorName}</h2>
	</div>
	<form action="edit" method="post" enctype="multipart/form-data">
	<div class="row">
		<input name="creatorNo" value="${creatorDto.creatorNo}">
		<input class="form-input col-75" type="file" name="attach" accept="image/*">
		<button class="btn col-25">이미지 등록</button>
	</div>
	
	</form>
	
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>