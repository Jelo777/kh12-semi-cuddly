<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-600">
	<div class="row">
		<h1>상품문의</h1>
	</div>
	
	<c:forEach var="qnaDto" items="${list}">
	<img src = "/cuddly/admin/qna/list?productNo=${qnaDto.productNo}" width="100" height="100">
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
		<form action="list" method="post">
			<input class="form-input" type="text" name="qnaAnswer" placeholder="답변 미완료"> 
			<button class="btn btn-positive">등록</button>
		</form>
	</div>
	<hr>
	</c:forEach>
	
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>