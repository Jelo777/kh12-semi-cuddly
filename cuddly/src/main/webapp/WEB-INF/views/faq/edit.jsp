<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<form action="edit" method="post">
<input type="hidden" name="faqNo" value="${faqDto.faqNo}">


<div class="container w-800">
	<div class="row">
		<h2>Faq 게시글 수정</h2>
	</div>
	
	
	<div class="row left">
		<input class="form-input underline-input w-100" type="text" name="faqTitle" value="${faqDto.faqTitle}" required>
	</div>
	
	<div class="row left">
		<textarea class="form-input w-100" name="faqContent" 
			style="min-height:250px" required>${faqDto.faqContent}</textarea>
	</div>
	
	<div class="row right">

		<a href="list" class="btn btn-positive">
			<i class="fa-solid fa-list"></i>
			목록
		</a>
		<button type="submit" class="btn btn-positive">
			<i class="fa-solid fa-edit"></i>
			수정
		</button>
	</div>
</div>

</form>



<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>



