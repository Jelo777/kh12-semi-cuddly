<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<div class="container w-900">
	<div class="row">
		<a class="link" href="list"><h2>FAQ</h2></a>
		<h3>${param.category}</h3>
	</div>
	<br>


	<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
	<c:if test="${sessionScope.level == '관리자'}">
		<div class="row right">
			<a href="write" class="btn btn-positive"> <i
				class="fa-solid fa-write"></i> 작성하기
			</a>
		</div>
	</c:if>



	<div class="row left">
		<a class="link" href="list?category=공지사항">공지사항</a> <a class="link"
			href="list?category=주문결제">주문결제</a> <a class="link"
			href="list?category=회원정보">회원정보</a> <a class="link"
			href="list?category=기타">기타</a>
	</div>



	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
					<th>no</th>
					<th>title</th>
					<th>writer</th>
					<th>date</th>
					<th>category</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="faqDto" items="${list}">
					<tr>
						<td>${faqDto.faqNo}</td>

						<td align="left">
							<!-- 제목을 누르면 상세페이지로 이동 --> <a class="link"
							href="detail?faqNo=${faqDto.faqNo}"> ${faqDto.faqTitle} </a>
						</td>

						<td>관리자</td>
						<td>${faqDto.faqDate}</td>
						<td>${faqDto.faqCategory}</td>


					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

	<div class="row right">
		<a class="link" href="list"> FAQ 전체보기</a>
	</div>

	<div class="row page-navigator mv-30">
		<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<a href="list?${vo.prevQueryString}"> <i
				class="fa-solid fa-angle-left"></i>
			</a>
		</c:if>


		<!-- 숫자 버튼 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<c:choose>
				<c:when test="${vo.page == i}">
					<a class="on">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.getQueryString(i)}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<a href="list?${vo.nextQueryString}"> <i
				class="fa-solid fa-angle-right"></i>
			</a>
		</c:if>
	</div>

	<form action="list" method="get">
		<div class="row search-container">
			<input type="search" name="keyword" required placeholder="검색어 입력"
				value="${param.keyword}">
			<button type="submit">검색</button>
		</div>
	</form>

</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>