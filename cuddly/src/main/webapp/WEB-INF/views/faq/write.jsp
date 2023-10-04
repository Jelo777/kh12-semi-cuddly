<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="write" method="post" autocomplete="off">
	<div class="container w-800">
		<div class="row">
			<h1>FAQ등록</h1>
		</div>
		<div class="float-container">
			<div class="float-left w-25">
				<select class="form-input find-input w-100" name="faqCategory"
					value="${faqDto.faqCategory}">
					<option>공지사항</option>
					<option>회원정보</option>
					<option>주문결제</option>
					<option>기타</option>
				</select>
			</div>
			<div class="float-right w-75">
				<input class="form-input underline-input w-100 center" type="text" name="faqTitle"
					value="${faqDto.faqTitle}" required placeholder="제목">
			</div>
		</div>
		<div class="row left">
			<textarea class="form-input w-100" name="faqContent"
				style="min-height: 250px" required></textarea>
		</div>

		<div class="row">
			<button type="submit" class="btn btn-positive w-100">작성</button>
		</div>
	</div>
</form>
