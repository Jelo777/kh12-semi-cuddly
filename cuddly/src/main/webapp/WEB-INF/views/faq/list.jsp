
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<br><br>
<h2>관리자 상세 page</h2>
<br><br><br>


<table border="1" width="1000">
<div class="row">
		<table class="table table-border">
	<thead>
		 <tr>
                <th>no </th>
                <th>title </th>
                <th>id </th>
                <th>date </th>
                <th>category </th>
             </tr>
             
	</thead>
	</table>
	
	</div>
	<div class="row">
		<table class="table table-border">
	<tbody align="center">
		<c:forEach var="faqDto" items="${list}">
		<tr>
			<td>${faqDto.faqNo}</td>
			
			<td align="left">
				<!-- 제목을 누르면 상세페이지로 이동 -->
				<a href="detail?faqNo=${faqDto.faqNo}">
					${faqDto.faqTitle}
				</a>
			</td>
			<td>${faqDto.faqId}</td>
			<td>${faqDto.faqDate}</td>
			<td>${faqDto.faqCategory}</td>
		</tr>

		</c:forEach>
	</tbody>
</table>
</div>

<a href="write">작성하기</a>
