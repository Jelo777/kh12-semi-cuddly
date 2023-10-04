<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
</style>
<div class="container w-1000">
	<c:if test="${creatorDto!=null}">
	<div class="row">
		<img class="image image-circle"
			src="/cuddly/image/creator?creatorNo=${creatorDto.creatorNo}"
			onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
			width="200" height="200" />
		<h1>${creatorDto.creatorName}</h1>
	</div>
	</c:if>
	
	<div class="row right">
		<a class="link" href="list?${vo.getQueryStringPriceAsc()}">낮은가격순</a>
		<a class="link" href="list?${vo.getQueryStringPriceDesc()}">높은가격순</a>
		<a class="link" href="list?${vo.getQueryStringNew()}">새로나온순</a>
		<a class="link" href="list?${vo.getQueryStringPopular()}">인기많은순</a>
	</div>
	
	<c:forEach var="productListDto" items="${list}">
		<a class="link" href="detail?productNo=${productListDto.productNo}">
			<div class="inline-flex-container allow-wrap left">
				<table>
					<tr>
						<td><img src="/cuddly/image/product/main?productNo=${productListDto.productNo}"
						onerror="this.src='https://dummyimage.com/200x200/000/fff;'" 
						width="200"	height="200"></td>
					</tr>
					<tr>
						<td>${productListDto.productNo}</td>
					</tr>
					<tr>
						<td>
							${productListDto.productName}
						</td>
					</tr>
					<tr>
						<td><fmt:formatNumber value="${productListDto.productPrice}" pattern="#,###"/>원</td>
					</tr>
					<tr>
						<td>${productListDto.productDate}</td>
					</tr>
				</table>
			</div>
		</a>
	</c:forEach>
</div>

<c:if test="${creatorDto==null}">
<div class="row">
	<form action="list">
		<c:if test="${param.item!=null}">
			<input type="hidden" name="item" value="${param.item}">
		</c:if>
		<input class="form-input" name="keyword">
		<button class="btn">검색</button>
	</form>
</div>
</c:if>
<div class="row">
	<a href="list"><label class="btn">전체목록</label></a>
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


${requestScope.vo}



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>