<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>

<div class="container w-900">
	<div class="row">
		<h2 class="mv-30">관심상품</h2>
	</div>
	
	<c:forEach var="wishlistListDto" items="${wishlistList}">
		<a class="link" href="/cuddly/product/detail?productNo=${wishlistListDto.productNo}">
			<div class="inline-flex-container allow-wrap left">
				<table class="mh-10 mb-20">
					<tr>
						<td>
						<img src="/cuddly/admin/image?productNo=${wishlistListDto.productNo}"
							width="200" height="200" class="image image-round"></td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${wishlistListDto.productNo}</td> --%>
<!-- 					</tr> -->
					<tr>
						<td class="productName">${wishlistListDto.productName}</td>
					</tr>
					<tr>
						<td class="creatorName">${wishlistListDto.creatorName}</td>
					</tr>
					<tr>
						<td class="productPrice">${wishlistListDto.productPrice}</td>
					</tr>
<!-- 					<tr> -->
<%-- 						<td>${wishlistListDto.productDate}</td> --%>
<!-- 					</tr> -->
				</table>
			</div>
		</a>
	</c:forEach>
</div>


<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>