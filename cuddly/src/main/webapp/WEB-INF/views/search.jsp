<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<c:choose>
		<c:when test="${productList==null && creatorList==null}">
			<div class="row">
				<h2>검색결과가 없습니다</h2>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row">
				<h1>[${keyword}] 검색결과</h1>
			</div>
			<div class="row left">
				<h2>크리에이터</h2>
			</div>
			<c:forEach var="creatorListDto" items="${creatorList}">
			<a class="link" href="${pageContext.request.contextPath}/product/list?creator=${creatorListDto.creatorName}">
				<div claa="col-4">
					<div class="row">
						<img class="image image-circle"
							src="${pageContext.request.contextPath}/image/creator?creatorNo=${creatorListDto.creatorNo}"
							onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
							width="200" height="200" />
					</div>
					<div class="row">
						<h2>${creatorListDto.creatorName}</h2>
					</div>
				</div>
			</a>
		</c:forEach>
			<div class="row left">
				<h2>상품</h2>
			</div>
			<c:forEach var="productListDto" items="${productList}" end="3">
				<a class="link"
					href="${pageContext.request.contextPath}/product/detail?productNo=${productListDto.productNo}">
					<div class="inline-flex-container allow-wrap left">
						<table class="">
							<tr>
								<td><img
									src="${pageContext.request.contextPath}/image/product/main?productNo=${productListDto.productNo}"
									onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
									width="200" height="200"></td>
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
			<div class="row">
				<a href="${pageContext.request.contextPath}/product/list?${vo.getQueryStringNew()}">
				<label class="btn">검색상품 더보기</label>
				</a>
			</div>
		</c:otherwise>
	</c:choose>
</div>











<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>