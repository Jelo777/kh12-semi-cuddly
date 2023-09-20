<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의</title>
</head>
<body>

	<form action="change" method="post">
	
	<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
	문의 내용 <input type="text" name="qnaContent" value="${qnaDto.qnaContent}"><br><br>
	문의 답변 <input type="text" name="qnaAnswer" value="${qnaDto.qnaAnswer}"><br><br>
	
	<button>작성</button>
	</form>

</body>
</html>