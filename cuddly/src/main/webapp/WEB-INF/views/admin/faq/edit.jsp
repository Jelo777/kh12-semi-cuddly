<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<h2>게시글 수정</h2>

<form action="edit" method="post">
	<input type="hidden" name="faqNo" value="${faqDto.faqNo}">
	
	제목 <input type="text" name="faqTitle" value="${faqDto.faqTitle}" required><br><br>
	내용 <textarea name="faqContent" 
			required>${faqDto.faqContent}</textarea><br><br>
	<button>수정하기</button>
</form>

