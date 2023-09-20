<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<form action="change" method="post">
	
	<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
	문의 내용 <input type="text" name="qnaContent" value="${qnaDto.qnaContent}"><br><br>
	
	<button>작성</button>
	</form>

</body>
</html>