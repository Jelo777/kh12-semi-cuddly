<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>

	<div class="container w-300">
		<div class="row">
			<h2 class="mv-50">변경 완료!</h2>
		</div>
	<div class="row">
		<a href="${pageContext.request.contextPath}/"><button class="btn btn-positive w-100">메인페이지</button></a>
	</div>
	<div class="row">
		<a href="${pageContext.request.contextPath}/member/mypage"><button class="btn btn-positive w-100">마이페이지</button></a>
	</div>
	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>