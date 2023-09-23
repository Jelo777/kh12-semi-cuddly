<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row">
		<h1>크리에이터 목록</h1>
	</div>
	<c:forEach var="creatorListDto" items="${list}">
		<c:choose>
			<c:when test="${creatorListDto.attachNo != null}">
				<div class="row">
					<img
						src="/cuddly/image/creator?creatorNo=${creatorListDto.creatorNo}"
						width="200" height="200">
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<h3>이미지가 존재하지 않습니다</h3>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="row">
			<a href="list?creatorName=${creatorListDto.creatorName}"> <label
				class="btn">${creatorListDto.creatorName}</label></a>
		</div>
	</c:forEach>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>