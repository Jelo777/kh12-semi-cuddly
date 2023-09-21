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
					<td>${faqDto.faqNo}</td>
					<td>${faqDto.faqCategory}</td>
					<td>${faqDto.faqTitle}</td>
					<td>${faqDto.faqDate}</td>
				</tr>
		</table>
	</div>

	<div class="row">
		<table class="table table-border">
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
			
			<a href="write">작성하기</a>
			<br>
			<a href="list">목록으로</a>
			<br>
			<a href="edit?faqNo=${faqDto.faqNo}">수정하기</a>
			
			
		</table>
	</div>
	</div>