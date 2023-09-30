<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<form action="write" method="post">
	<input type="hidden" name="productNo" value="${productNo}"> 
	<input type="hidden" name="memberId" value="${sessionScope.name}">
	<div class="row">문의 내용<input type="text" name="qnaContent"></div>
	<div class="row"><button>작성</button></div>
	</form>

</body>
</html>