<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>

<div class="container w-400">
	<div class="row">
		<h2 class="mv-50">회원탈퇴가 완료되었습니다.</h2>
	</div>
	
	<div class="row">
		<a href="${pageContext.request.contextPath}/"><button class="btn btn-positive w-100">홈으로</button></a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>