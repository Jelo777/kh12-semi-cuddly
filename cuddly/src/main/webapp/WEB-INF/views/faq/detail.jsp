<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
    <div class="row">
        <h2>${faqDto.faqNo}번게시글</h2>
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
                    <th width="25%">작성자</th>
                    <td>${faqDto.faqId}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>${faqDto.faqTitle}</td>
                </tr>
                <tr height="150">
                    <th>내용</th>
                    <td>${faqDto.faqContent}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${faqDto.faqDate}</td>
                </tr>
            </tbody>
        </table>
    </div>
    


    <div class="row right">
    

        <a href="list" class="btn">
            <i class="fa-solid fa-list"></i>
            목록
        </a>
              
	
     

  

        
    </div>
</div>

