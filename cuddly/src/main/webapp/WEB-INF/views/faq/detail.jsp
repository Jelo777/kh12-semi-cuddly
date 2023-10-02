<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
    <div class="row">
        <h2>${param.category}</h2>
       
    </div>
    <div class="row">
        <table class="table table-border">
            <thead>
                <tr>
                    <th>글 번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${faqDto.faqNo}</td>
                    <td>${faqDto.faqCategory}</td>
                    <td>${faqDto.faqTitle}</td>
                    <td>${faqDto.faqDate}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="row">
        <table class="table table-border">
            <tbody>
                <tr>

        
                <tr height="150">
                
                    <td>${faqDto.faqContent}</td>
                </tr>
               
            </tbody>
        </table>
    </div>
    


    <div class="row right">
    

        
       <c:if test="${sessionScope.level == '관리자'}">
		<a href="edit?faqNo=${faqDto.faqNo}" class="btn btn-positive">		
   			 <i class="fa-solid fa-edit"></i>
   			 수정
		</a>
		</c:if>
		
		<c:if test="${sessionScope.level == '관리자'}">
		    <a href="delete?faqNo=${faqDto.faqNo}" class="btn">
  	 		 <i class="fa-solid fa-delete"></i>
   			 삭제
		</a>
		</c:if>

        <a href="list" class="btn">
            <i class="fa-solid fa-list"></i>
            목록
        </a>
              
	
     

  

        
    </div>
</div>

