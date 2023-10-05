<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>


<script>

$(function(){

	$(".edit-answer").click(function(e){

		
		 var qnaForm = $(this).closest("form");
         var answerInput = qnaForm.find(".qna-answer");
         
         

         if ($(answerInput).prop("readonly")) {
             $(answerInput).prop("readonly", false).focus();
         } 
         
         
         else {
             $.ajax({
                 url: "/cuddly/rest/admin/qna/answer/update",
                 method: "post",
                 data: qnaForm.serialize(),
                 success: function (response) {
                     if (response) {
                         location.reload();
                     } else {
                         alert('업데이트 실패');
                     }
                 }
             });
         }	
	})	
})


function update(e){
	var value = $(e).serialize();
	
	$.ajax({
		url:"/cuddly/rest/admin/qna/answer/update",
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
		<h2 class="mv-30">상품문의</h2>
	</div>

	<c:forEach var="qnaDto" items="${list}">
	
	<form id="testForm" onsubmit="update(this);">
		<div class="flex-container card mb-20">
	
			<div class="w-25">
				<a href="/cuddly/product/detail?productNo=${qnaDto.productNo}">
					<img src = "/cuddly/image/product/main?productNo=${qnaDto.productNo}" 
								width="120" height="120" class="image image-round mh-10 mt-30">
				</a>
			</div>
			
			<div class="w-75">
				<div class="float-container">
					<div class="float-left">
						<span class="left">No. ${qnaDto.qnaNo}</span>
					</div>
					<div class="float-right">
						<span class="right me-10">작성일 : ${qnaDto.qnaDate}</span>
					</div>
				</div>
			
			<div class="row left">
				<span>작성자 : ${qnaDto.memberId}</span>
			</div>
			
				<hr>
				
			<div class="row left">
				<span>문의내용</span>
				<div class="mt-10 textbox">
					${qnaDto.qnaContent}
				</div>
			</div>
			
			<hr>
			
				
			<c:choose>
				<c:when test="${qnaDto.qnaAnswer == null}">
					<div class="row left">
						<input id="answer" name="qnaAnswer" autocomplete="off" placeholder="답변 미등록" 
									style="border:none; width:440px">
					</div>
				</c:when>
				<c:otherwise>
					<div class="row left">
						<span>답변 
							<input class="qna-answer" id="answer" name="qnaAnswer" autocomplete="off" 
											readonly="readonly" value="${qnaDto.qnaAnswer}" style="border:none; width:400px">
						</span>
					</div>
				</c:otherwise>
			</c:choose>
			
			
			<div class="float-container">
				<div class="row float-right">
					<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
					<button class="btn btn-positive btn-small me-10">등록</button>
				</div>
		
			<div class="row float-right">
				<button class="btn btn-negative btn-small edit-answer me-10" type="button">수정</button>
			</div>
		</div>
		</div>
	 </div>
</form>
</c:forEach>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>