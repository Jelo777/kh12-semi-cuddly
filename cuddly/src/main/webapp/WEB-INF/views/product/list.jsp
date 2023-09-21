<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
</style>
<div class="container w-1000">
	<div class="row">
		<h1>상품목록</h1>
	</div>
	<c:forEach var="productListDto" items="${list}">
		<a class="link" href="detail?productNo=${productListDto.productNo}">
			<div class="inline-flex-container allow-wrap left">
				<table class="">
					<tr>
						<td><img src="https://picsum.photos/id/4/300/300" width="200"
							height="200"></td>
					</tr>
					<tr>
						<td>${productListDto.productNo}</td>
					</tr>
					<tr>
						<td>${productListDto.productName}</td>
					</tr>
					<tr>
						<td>${productListDto.productPrice}</td>
					</tr>
					<tr>
						<td>${productListDto.productDate}</td>
					</tr>
				</table>
			</div>
		</a>
	</c:forEach>
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






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>