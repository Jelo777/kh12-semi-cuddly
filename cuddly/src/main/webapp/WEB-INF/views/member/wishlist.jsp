<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row">
		<h1>관심상품</h1>
	</div>
	<c:forEach var="wishlistListDto" items="${wishlistList}">
		<a class="link" href="/cuddly/product/detail?productNo=${wishlistListDto.productNo}">
			<div class="inline-flex-container allow-wrap left">
				<table>
					<tr>
						<td>
						<img src="/cuddly/admin/image?productNo=${wishlistListDto.productNo}"
							width="200" height="200"></td>
					</tr>
					<tr>
						<td>${wishlistListDto.productNo}</td>
					</tr>
					<tr>
						<td>${wishlistListDto.productName}</td>
					</tr>
					<tr>
						<td>${wishlistListDto.productPrice}</td>
					</tr>
					<tr>
						<td>${wishlistListDto.productDate}</td>
					</tr>
				</table>
			</div>
		</a>
	</c:forEach>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>