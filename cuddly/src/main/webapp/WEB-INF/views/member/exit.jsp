<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<form action="exit" method="post" autocomplete="off">
	<div class="container w-300">
		<div class="row">
			<h1>탈퇴</h1>
		</div>
		<div class="row">
			<h2>정말 삭제할거냐?</h2>
		</div>
		
		
		<div class="row">
			<input class="form-input w-100" type="text" name="memberPw" placeholder="비밀번호 입력">
			
		</div>
		<c:if  test="${param.error !=null }">
			<div class="row important">
			<h1>비밀번호 다시 입력하세요</h1>
			</div>
		</c:if>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>