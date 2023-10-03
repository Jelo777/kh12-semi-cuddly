<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>

<style>

</style>


<div class="container w-600">
	<div class="row">
		<h2 class="mv-30">나의 리뷰</h2>
	</div>
	
	<c:forEach var="reviewDto" items="${list}">
		<div class="flex-container card mt-30">
			<div class="row w-25">
				<c:choose>
					<c:when test="${reviewDto.image}">
						<img src="/cuddly/image/review/image?reviewNo=${reviewDto.reviewNo}" width="150" height="150" class="image image-round ms-10">
					</c:when>
					<c:otherwise>
						<img src="https://dummyimage.com/150x150/000/fff" class="image image-round ms-10">
					</c:otherwise>
				</c:choose>
			</div>
			
		<div class="row w-75">
			<div class="row left title">
				<span class="ms-20">상품명 : ${reviewDto.productName}</span>  
				<span class="star-rating">
					<c:forEach var="i" begin="1" end="${reviewDto.reviewGrade}">
						<i class="fas fa-star yellow"></i>
					</c:forEach>
					<c:forEach var="i" begin="1" end="${5-reviewDto.reviewGrade}">
						<i class="far fa-star yellow"></i>
					</c:forEach>
				</span>
			</div>
			
	<hr class="w-90">
	
			<div class="row left">
				<span class="ms-20">리뷰 내용 : ${reviewDto.reviewContent}</span>
			</div>
	<!--<div class="row"><a href="/cuddly/product/detail?productNo=${reviewDto.productNo}"><img src="/cuddly/image/product/main?productNo=${reviewDto.productNo}" width="100" height="100"></a>
	</div>
	<div class="row">
	크리에이터:${reviewDto.creatorName}
	</div>
	<div class="row">
	상품 가격 : ${reviewDto.productPrice}
	</div>  -->
	<br>
	<br>
	<div class="row right">
		<a href="/cuddly/review/edit?reviewNo=${reviewDto.reviewNo}" class="link">
			<button class="btn btn-positive btn-small">수정하기</button>
		</a>
		<a href="/cuddly/review/delete?reviewNo=${reviewDto.reviewNo}" class="link">
			<button class="btn btn-negative btn-small me-10">삭제하기</button>
		</a>
	</div>
</div>
</div>

</c:forEach>
</div>


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

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>