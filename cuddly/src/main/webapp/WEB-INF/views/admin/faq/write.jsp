
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<form action="write" method="post" autocomplete="off">
    <div class="container w-800">
        <div class="row">
            <h1>FAQ등록</h1>
            <div class="row left">
                <label>카테고리</label>
                <select name="faqCategory">
                    <option value="공지사항" ${faqDto.faqCategory eq '공지사항' ? 'selected' : ''}>공지사항</option>
                    <option value="회원정보" ${faqDto.faqCategory eq '회원정보' ? 'selected' : ''}>회원정보</option>
                    <option value="주문결제" ${faqDto.faqCategory eq '주문결제' ? 'selected' : ''}>주문결제</option>
                    <option value="기타" ${faqDto.faqCategory eq '기타' ? 'selected' : ''}>기타</option>
                </select>
            </div>
            
      
          <input type="hidden" name="faqId">
            
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
           	
       	  	<a href="list" class="btn">
            	<i class="fa-solid fa-list"></i>
            	목록
            	</a>
    </div>
</form>


<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>

