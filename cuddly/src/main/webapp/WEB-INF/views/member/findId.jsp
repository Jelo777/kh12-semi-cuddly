<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<form action="findId" method="post">
	
		<div class="container w-300">
		
			<div class="row">
				<h1>아이디 찾기</h1>
			</div>
			
			<div class="row">
				<input type="text" class="form-input w-100" name="memberEmail" placeholder="이메일 입력">
			</div>
			
			<div class="row">
				<button type="submit" class="btn btn-positive w-100">아이디 찾기</button>
			</div>
		</div>
		
	</form>
			<c:if test="${param.error !=null}">
				<div class="row important">
					<h3> 이런 이메일로 회원가입 안하셨어요</h3>
				</div>
			</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>