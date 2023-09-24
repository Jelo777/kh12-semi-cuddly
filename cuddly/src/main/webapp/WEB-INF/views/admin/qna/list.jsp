<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<script>

function update(e){
	var value = $(e).serialize();
	
	$.ajax({
		url:"/cuddly/admin/rest/qna/answer/update",
		method:"post",
		data : value,
		success:function(response){
			if(response){
				location.reload();			
			}else{
				alert('업데이트 실패');
			}
		}
	});
	
}

</script>

<div class="container w-600">
	<div class="row">
		<h1>상품문의</h1>
	</div>
	
	<c:forEach var="qnaDto" items="${list}">
	<img src = "/cuddly/image/product/main?productNo=${qnaDto.productNo}" width="100" height="100">
	<div class="row">
		상품문의번호 : ${qnaDto.qnaNo}
	</div>
	<div class="row">
		작성자 : ${qnaDto.memberId}
	</div>
	<div class="row">
		문의내용 : ${qnaDto.qnaContent}
	</div>
	<div class="row">
		작성일 : ${qnaDto.qnaDate}
	</div>
	<div class="row">
		답변 : ${qnaDto.qnaAnswer}
	</div>
	 
	<%-- 답변이 표시될 영역 --%>
	<div class="row left answer"></div>
	
	<div class="row">
		<form onsubmit="update(this);">
			<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
			<div class="row">
				<textarea class="form-input w-100" name="qnaAnswer" rows="4"></textarea>
			</div>
			<div class="row">
				<button class="btn btn-positive">등록</button>
			</div>
		</form>
	</div>
	<hr>
	</c:forEach>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>