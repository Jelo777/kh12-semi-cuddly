<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-800">
	
	<div class="row">
		<h2>FAQ관리</h2>
	</div>
	
	
	

	
	<form action="list" method="post" autocomplete="off">
		<div class="row">
		
				
					
				


	
	<h3><a href="list?faq_category=공지사항">공지사항</a></h3>
	<h3><a href="list?faq_category=주문결제">주문결제</a></h3>
	<h3><a href="list?faq_category=회원정보">회원정보</a></h3>
	<h3><a href="list?faq_category=기타">기타</a></h3>	
	
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
				<th>no</th>
				<th>title</th>
				<th>id</th>
				<th>date</th>
				<th>category</th>
				</tr>
			</thead>
			<tbody>
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


<a href="write">작성하기</a>
</form>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>