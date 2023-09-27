<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<title>공지사항 등록</title>
</head>
<body>

<form action="write" method="post" autocomplete="off">
	<div class="container w-600">
        <div class="row">
	<h1>FAQ등록</h1>
	<select name="faqCategory" value="${faqDto.faqCategory}">
		<option>공지사항</option>
		<option>회원정보</option>
		<option>주문결제</option>
		<option>기타</option>
	
		<input type="text" name="faqTitle" value="${faqDto.faqTitle}" placeholder="글제목 입력"> <br><br>
		<textarea type="text" name="faqContent" value="${faqDto.faqContent}"></textarea> <br><br>
		<button>등록</button>
	</select>
</form>

</body>
</html>
