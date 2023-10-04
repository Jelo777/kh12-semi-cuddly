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
	
	<div class="row left">
	<select name="faqCategory" value="${faqDto.faqCategory}">
		<option>공지사항</option>
		<option>회원정보</option>
		<option>주문결제</option>
		<option>기타</option>
	</select>
	 </div>
	 
            <div class="row left">
                <label>제목</label>
                <input class="form-input w-100" type="text" name="faqTitle" value="${faqDto.faqTitle}" required>
            </div>
            
            <div class="row left">
                <label>내용</label>
                <textarea class="form-input w-100" name="faqContent" style="min-height:250px" required>${faqDto.faqContent}</textarea>
            </div>
        </div>
        
             <div class="row right">
            <button type="submit" class="btn btn-positive">
            	<i class="fa-solid fa-pen"></i>
            	작성
           	</button>
           	
       	  	<a href="list" class="btn btn-positive">
            	<i class="fa-solid fa-list"></i>
            	목록
            	</a>
   			 </div>
	
</form>

</body>
</html>
