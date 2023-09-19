<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
</head>
<body>

<form action="write" method="post" autocomplete="off">
	<h1>FAQ등록</h1>
	<select name="faqCategory" value="${faqDto.faqCategory}">
		<option>공지사항</option>
		<option>회원정보</option>
		<option>주문결제</option>
		<option>기타</option>
		<input type="text" name="faqId" placeholder="임의 회원아이디"> <br><br>
		<input type="text" name="faqTitle" value="${faqDto.faqTitle}" placeholder="글제목 입력"> <br><br>
		<textarea type="text" name="faqContent" value="${faqDto.faqContent}"></textarea> <br><br>
		<button>등록</button>
	</select>
</form>

</body>
</html>