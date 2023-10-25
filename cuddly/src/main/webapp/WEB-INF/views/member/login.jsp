<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">
	<div class="container form-border mt-30">
	<div class= "center w-400">
	
		<div class="row">
			<img src="/images/cuddlys.png" class="mt-40">
		</div>
		<div class="row">
			<input type="text"  name="memberId" 
							class="form-input underline-input w-100 mt-20 member-input" placeholder="아이디 입력">
		</div>
		<div class="row">
			<input type="password" name="memberPw" 
							class="form-input underline-input w-100 mb-30 member-input" placeholder="비밀번호 입력">
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive w-100 mb-10">로그인</button>
		</div>
		<div class="row flex-container">
			<div class="w-100 left"> 
				<a class="link" href="${pageContext.request.contextPath}/member/join">회원가입</a>
			</div>
			<div class="w-100 right">
				<a class="link" href="${pageContext.request.contextPath}/member/findId">아이디찾기</a>
			</div>
			<div class="w-100 right">
				<a class="link" href="${pageContext.request.contextPath}/member/findPw">비밀번호찾기</a>
			</div>
		</div>
	</div>
	</div>
</form>
	<c:if test="${param.error !=null}">
		<h3 class="mt-30"style="color:red">아이디 또는 비밀번호가 일치하지 않습니다</h3>
	</c:if>	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
