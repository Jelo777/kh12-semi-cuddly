<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>전체 리뷰</h1>
<c:forEach var="reviewDto" items="${list}">
<div>
	작성자 : ${reviewDto.memberId} / 별점 : ${reviewDto.reviewGrade} <br><br>
	<c:choose>
	<c:when test="${reviewDto.image}">
		<img src="/cuddly/image/review/image?reviewNo=${reviewDto.reviewNo}" width="200" height="200">
	</c:when>
	<c:otherwise>
		<img src="https://dummyimage.com/50x50/000/fff">
	</c:otherwise>
	</c:choose>
	<br><br>리뷰 내용 : ${reviewDto.reviewContent}
	<br><br>
	<a href="/cuddly/product/detail?productNo=${reviewDto.productNo}"><img src="/cuddly/image/product/main?productNo=${reviewDto.productNo}" width="100" height="100"></a>
	
	<div class="row">
	
	<a href="/cuddly/review/delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
	
	</div>
	
	
	<hr>
</div>
</c:forEach>

</body>
</html>