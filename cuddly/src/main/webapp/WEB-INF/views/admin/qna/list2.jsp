<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>


<script>

function editAnswer(){
	var check = document.getElementById('answer').readOnly;
	
	if(check == true){
		document.getElementById('answer').readOnly = false;
		document.getElementById("answer").focus();
	}
	else{

		var value = $("#testForm").serialize();
		
		$.ajax({
			url:window.contextPath+"/rest/admin/qna/answer/update",
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
}

function update(e){
	var value = $(e).serialize();
	
	$.ajax({
		url:window.contextPath+"/rest/admin/qna/answer/update",
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

	<div class="row">
		<h1>상품문의</h1>
	</div>

<br><br>

<div class="container w-600">

	<c:forEach var="qnaDto" items="${list}">
	
	<form id="testForm" onsubmit="update(this);">
		<div class="float-container card">
	
			<div class="float-left w-25">
				<a href="${pageContext.request.contextPath}/product/detail?productNo=${qnaDto.productNo}">
					<img src = "${pageContext.request.contextPath}/image/product/main?productNo=${qnaDto.productNo}" width="120" height="120" 
								class="image image-round">
				</a>
			</div>
			
			<div class="row flex-container auto-width">
				<span class="left">상품문의번호 : ${qnaDto.qnaNo}</span>
				<span class="right me-10">작성일 : ${qnaDto.qnaDate}</span>
			</div>
			
			<div class="row left">
				<span>작성자 : ${qnaDto.memberId}</span>
			</div>
				
			<div class="row left">
				<span>문의내용 : ${qnaDto.qnaContent}</span>
			</div>
				
			<hr>
				
			<c:choose>
		
				<c:when test="${qnaDto.qnaAnswer == null}">
					<div class="row left">
						<input id="answer" name="qnaAnswer" autocomplete="off" placeholder="미등록" 
									style="border:none; width:440px">
					</div>
				</c:when>
					
				<c:otherwise>
					<div class="row left">
						답변 : <input id="answer" name="qnaAnswer" autocomplete="off" 
										readonly="readonly" value="${qnaDto.qnaAnswer}" style="border:none; width:400px">
					</div>
				</c:otherwise>
				
			</c:choose>
			
	 	</div>
		
		<div class="row float-left">
		
				<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
				
				<div class="row right">
					<button class="btn btn-positive">등록</button>
				</div>
				
		</div>
		
		</form>
		<div class="row right">
			<button class="btn btn-positive" onclick="editAnswer();">수정</button>
		</div>
	
	</c:forEach>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>