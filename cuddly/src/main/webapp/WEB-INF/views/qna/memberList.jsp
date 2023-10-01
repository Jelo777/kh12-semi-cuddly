<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 
 <style>
.card {
	/* border: 1px solid #2d3436; */
	box-shadow: 0px 0px 0px 1px black;
	border-radius: 0.2em;
}

.link{
 margin-top: 150px;}


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
 
 
 <div class="row"><h1>나의 문의</h1></div>
 <c:forEach var="qnaDto" items="${list}">
<div class="container w-600">
			<div class="flex-container card">
				<div class="row w-50">
	<a href="/cuddly/product/detail?productNo=${qnaDto.productNo}">
	<button type="button">
	<img src="/cuddly/image/product/main?productNo=${qnaDto.productNo}" width="200" height="200">
	</button></a>
	</div>
	<div class="w-75">
	<div class="row left title">
	문의 내용 : ${qnaDto.qnaContent} </div>
	<hr>
	<div class="row left">
	<c:choose>
    <c:when test="${qnaDto.qnaAnswer != null}">
       
       답변 내용 : ${qnaDto.qnaAnswer}
       
    </c:when>
    <c:otherwise>
       답변 미완료
    </c:otherwise>
</c:choose>
</div>
<div class="row right link">
	<button class="qna-write">수정하기</button>
	<a href="/cuddly/qna/delete?qnaNo=${qnaDto.qnaNo}">삭제하기</a>
	</div>
	
	</div>
</div>
<div class="row right">
작성일자 : ${qnaDto.qnaDate}
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