<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.card {
    border: 1px solid black; 
    border-radius: 0.2em;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); 
}

.img {
    padding: 0.5em;
}


</style>

<script>

	

</script>


<h1>전체 리뷰</h1>


<c:forEach var="reviewDto" items="${list}">

<div class="inline-flex-container allow-wrap left">
<div class="container w-300 card">
<div class="row">
	<c:choose>
	<c:when test="${reviewDto.image}">
		<img src="/cuddly/image/review/image?reviewNo=${reviewDto.reviewNo}" width="250" height="200">
	</c:when>
	<c:otherwise>
		<img src="https://dummyimage.com/50x50/000/fff">
	</c:otherwise>
	</c:choose>
	</div>
	<div class="row flex-container auto-width">
						<div class="left felx-container">
	 <span class="star-rating">
                        <c:forEach var="i" begin="1" end="${reviewDto.reviewGrade}">
                            <i class="fas fa-star yellow"></i>
                        </c:forEach>
                        <c:forEach var="i" begin="1" end="${5-reviewDto.reviewGrade}">
                        <i class="far fa-star yellow"></i>
                        </c:forEach>
                    </span></div>
	 <div class="right">
	 작성자 : ${reviewDto.memberId} 
	 </div>
	 </div>
	<div class="row left">리뷰 내용 : ${reviewDto.reviewContent}</div>
	
	<div class="row flex-container auto-width">
						<div class="left felx-container">
	<a href="/cuddly/product/detail?productNo=${reviewDto.productNo}"><img class="img" src="/cuddly/image/product/main?productNo=${reviewDto.productNo}" width="100" height="100"></a>
	</div>
	<div class="row left">
	상품명:${reviewDto.productName}	
	<br><br>
	크리에이터:${reviewDto.creatorName}
	<br><br>
	가격 : ${reviewDto.productPrice}
	</div>
	</div>
	<c:if test="${reviewDto.memberId == sessionScope.name}">
	<div class="row">
	<a href="/cuddly/review/edit?reviewNo=${reviewDto.reviewNo}">수정하기</a>
	<a href="/cuddly/review/delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
	</div>
	</c:if>
</div>
</div>
</c:forEach>

	<div class="row page-navigator mv-30">
    <!-- 이전 버튼 -->
    <c:if test="${!vo.first}">
        <a href="list?${vo.getPrevQueryString()}"> <i
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
        <a href="list?${vo.getNextQueryString()}"> <i
            class="fa-solid fa-angle-right"></i>
        </a>
    </c:if>
</div>

</body>
</html>