<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 
 <style>

</style>

<script>
	//상품문의 관련된 스크립트
	$(function() {
		$(".qna-write-form").hide();//문의작성란 숨겨놓기

		$(".qna-write").click(function() {
			
			var form = $(this).closest(".container").find(".qna-write-form");
			var realForm = form.find(".wrtForm")
			
			if(form.is(":hidden")){
			
			form.show();
			
			form.find("#wrt").click(function(){
				
			console.log("확인")
			
			 $.ajax({
                 url: "/cuddly/rest/qna/change",
                 method: "post",
                 data: realForm.serialize(),
                 success: function (response) {
                     if (response) {
                         location.reload();
                     } else {
                         alert('업데이트 실패');
                     }
                 }
             });
			
			})
			}
			
			
			
			else{
				
				form.hide();
			}
			
		});

	});
</script>
 

 	<div class="row">
 		<h2 class="mv-30">나의 문의</h2>
 	</div>
 	
 	<c:forEach var="qnaDto" items="${list}">
 		<div class="container w-600 card mt-30">
 		
 			<div class="left  mb-20">
				<span class="ms-20">작성일 : ${qnaDto.qnaDate}</span>
			</div>
			
 		<div class="flex-container">
 		
			<div class="col-3">
				<a href="/cuddly/product/detail?productNo=${qnaDto.productNo}">
					<img src="/cuddly/image/product/main?productNo=${qnaDto.productNo}" 
							width="150" height="150" class="image image-round mv-20">
				</a>
			</div>
			
	<div class="w-75">
		<div class="row left title">
			<span class="ms-10">문의 내용 : ${qnaDto.qnaContent}</span>
		</div>
		<hr class="w-95 mb-20">
		<div class="row left">
			<c:choose>
    			<c:when test="${qnaDto.qnaAnswer != null}">
       				<span class="ms-10">답변 내용 : ${qnaDto.qnaAnswer}</span>    
    			</c:when>
   				 <c:otherwise>
       				<span class="ms-10">답변 미완료</span>
    			</c:otherwise>
			</c:choose>
		</div>
		
		<br>
		<br>
		<br>
		<br>
		<div class="row right link">
			<button class="qna-write btn btn-positive btn-small">수정하기</button>
			<a href="/cuddly/qna/delete?qnaNo=${qnaDto.qnaNo}"
					class="btn btn-negative btn-small me-10">삭제하기</a>
		</div>
	
	</div>
</div>

<div class="row qna-write-form">
		<form class="wrtForm">
			<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
			<input type="hidden" name="memberId" value="${sessionScope.name}">
			<div class="row">
				<input class="form-input w-100" name="qnaContent"
					placeholder="상품문의내용입력" value="${qnaDto.qnaContent}">
			</div>
			<div class="row">
				<button class="btn btn-positive w-100" id="wrt" type="button">작성</button>
			</div>
		</form>
	</div>


		</div>
</c:forEach>



<div class="row page-navigator mv-30">
    <!-- 이전 버튼 -->
    <c:if test="${!vo.first}">
        <a href="memberList?${vo.getPrevQueryString()}"> <i
            class="fa-solid fa-angle-left"></i>
        </a>
    </c:if>

    <!-- 숫자 버튼 -->
    <c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
        <c:choose>
            <c:when test="${vo.page == i}">
                <a class="on">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="memberList?${vo.getQueryString(i)}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 버튼 -->
    <c:if test="${!vo.last}">
        <a href="memberList?${vo.getNextQueryString()}"> <i
            class="fa-solid fa-angle-right"></i>
        </a>
    </c:if>
</div>

</body>
</html>