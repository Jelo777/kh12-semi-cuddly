<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">
	<div class="container w-400">
	
		<div class="row">
			<h2>로그인</h2>
		</div>
		<div class="row">
			<input type="text"  name="memberId" class="form-input w-100" placeholder="아이디 입력">
		</div>
		<div class="row">
			<input type="password" name="memberPw" class="form-input w-100" placeholder="비밀번호 입력">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100">로그인</button>
		</div>
		<div class="row left">
			<a class="link" href="/cuddly/member/join">회원가입</a>
		</div>
	</div>
</form>
	<c:if test="${param.error !=null}">
		<h3>아이디 또는 비밀번호가 일치하지 않습니다</h3>
	</c:if>	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
