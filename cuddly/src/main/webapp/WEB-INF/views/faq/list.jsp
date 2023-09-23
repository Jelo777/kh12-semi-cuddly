
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row">
		<h2>FAQ 상세 page</h2>
	</div>

<div class="row">
	<table class="table table-border">
		<thead>
			<tr>
				<th>no</th>
				<th>title</th>
				<th>id</th>
				<th>date</th>
				<th>category</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach var="faqDto" items="${list}">
				<tr>
					<td>${faqDto.faqNo}</td>

					<td align="left">
						<!-- 제목을 누르면 상세페이지로 이동 --> <a class="link" href="detail?faqNo=${faqDto.faqNo}">
							${faqDto.faqTitle} </a>
					</td>
					<td>관리자</td>
					<td>${faqDto.faqDate}</td>
					<td>${faqDto.faqCategory}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


	<!-- 페이지 네비게이터 출력 -->
	<h3>

		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="list?${vo.prevQueryString}">&lt;</a>
		</c:if>

		<!-- 숫자 버튼 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<c:choose>
				<c:when test="${vo.page == i}">
			${i}	
		</c:when>
				<c:otherwise>
					<a href="list?${vo.getQueryString(i)}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="list?${vo.nextQueryString}">&gt;</a>
		</c:if>


	</h3>


	<!-- 검색창 -->
	<form action="category" method="post">
		<select name="category" required>
			<option value="faq_title">제목</option>
			<option value="faq_id">아이디</option>
			<option value="faq_category">카테고리</option>
		</select> <input type="search" name="category" placeholder="검색어 입력" required>
		<button>검색</button>
	</form>

</div>
<a href="write">작성하기</a>
</div>
