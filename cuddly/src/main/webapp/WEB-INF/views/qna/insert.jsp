<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<form action="write" method="post">
	상품 번호<input type="text" name="productNo"><br><br>
	회원 아이디<input type="text" name="memberId"><br><br>
	문의 내용<input type="text" name="qnaContent"><br><br>
	문의 답변<input type="text" name="qnaAnswer"><br><br>
	<button>작성</button>
	</form>

</body>
</html>