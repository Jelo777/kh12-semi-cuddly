<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<style>
</style>
<div class="container w-900">
	<div class="row">
		<h1>상품목록</h1>
	</div>
	
	<div class= "row right">
		<a href="insert">
			<button class="btn btn-positive" style="margin-right: 38px">상품등록</button>
		</a>
	</div>
	<c:forEach var="productListDto" items="${list}">
		<a class="link" href="/cuddly/product/detail?productNo=${productListDto.productNo}">
			<div class="inline-flex-container allow-wrap left">
				<table class="">
					<tr>
						<td><img src="/cuddly/admin/product/main?productNo=${productListDto.productNo}" width="200" height="200"></td>
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
						<td>
							${productListDto.productDate}
							<a href="edit?productNo=${productListDto.productNo}">
								<button style="float:right">수정</button>
							</a>
						</td>
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

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>