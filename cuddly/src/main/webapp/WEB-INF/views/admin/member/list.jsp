<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
	
	<div class="row">
		<h2>회원관리</h2>
	</div>
	
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
					<th>아이디</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>등급</th>
					<th>누적금액</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberListDto" items="${list}">
					<tr>
						<td>${memberListDto.memberId}</td>
						<td>${memberListDto.memberContent}</td>
						<td>${memberListDto.memberEmail}</td>
						<td>${memberListDto.memberLevel}</td>
						<td>${memberListDto.memberTotalprice}</td>
						<td>${memberListDto.memberJoin}</td>
					</tr>
				</c:forEach>
			</tbody>
			
		
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>