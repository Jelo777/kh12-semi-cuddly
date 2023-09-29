<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>나의 리뷰</h1>
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
	<br><br>
	상품명:${reviewDto.productName}
	<br><br>
	크리에이터:${reviewDto.creatorName}
	<br><br>
	상품 가격 : ${reviewDto.productPrice}
	
	<div class="row">
	<a href="/cuddly/review/edit?reviewNo=${reviewDto.reviewNo}">수정하기</a>
	<a href="/cuddly/review/delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
	</div>
	<hr>
</div>
</c:forEach>


<div class="row page-navigator mv-30">
    <!-- 이전 버튼 -->
    <c:if test="${!vo.first}">
        <a href="memberList?${vo.getPrevQueryString()}"> <i
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
                <a href="memberList?${vo.getQueryString(i)}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 버튼 -->
    <c:if test="${!vo.last}">
        <a href="memberList?${vo.getNextQueryString()}"> <i
            class="fa-solid fa-angle-right"></i>
        </a>
    </c:if>
</div>

</body>
</html>