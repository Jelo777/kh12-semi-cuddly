<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>

</style>

<script>

</script>


<h1 class="mb-30">전체 리뷰</h1>


<c:forEach var="reviewDto" items="${list}">

	<div class="inline-flex-container allow-wrap left">
		<div class="container w-300 card m-10">
		
			<div class="row">
				<c:choose>
					<c:when test="${reviewDto.image}">
						<img src="${pageContext.request.contextPath}/image/review/image?reviewNo=${reviewDto.reviewNo}" 
									width="250" height="250" class="image image-round">
					</c:when>
					<c:otherwise>
						<img src="https://dummyimage.com/250x250/000/fff" class="image image-round">
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="p-10">
			<div class="row flex-container auto-width">
				<div class="left felx-container">
	 				<span class="star-rating">
                        <c:forEach var="i" begin="1" end="${reviewDto.reviewGrade}">
                            <i class="fas fa-star yellow"></i>
                        </c:forEach>
                        <c:forEach var="i" begin="1" end="${5-reviewDto.reviewGrade}">
                        	<i class="far fa-star yellow"></i>
                        </c:forEach>
                    </span>
				</div>
				<div class="right">
					<span>${reviewDto.memberId}</span> 
				</div>
			</div>
			
			<div class="row">
				<textarea style="width:270px; border:none; resize:none;" row="4" readonly>${reviewDto.reviewContent}</textarea>
			</div>
	
			<div class="row flex-container">
				<div class="w-40">
					<a href="${pageContext.request.contextPath}/product/detail?productNo=${reviewDto.productNo}">
						<img src="${pageContext.request.contextPath}/image/product/main?productNo=${reviewDto.productNo}" 
										width="100" height="100"  class="img image image-round">
					</a>
				</div>
				<div class="w-100">
					<div class="row left">
						<span class="ms-10">${reviewDto.productName}</span>
					</div>
					<div class="row left">
						<span style="color:darkgray" class="ms-10">${reviewDto.creatorName}</span>
					</div>
					<div class="row right">
						<span><fmt:formatNumber value="${reviewDto.productPrice}" pattern="#,###원" /></span>
					</div>
				</div>
			</div>
			</div>
			<c:choose>
			<c:when test="${reviewDto.memberId == sessionScope.name && sessionScope.name != null}">
				<div class="row">
					<a href="${pageContext.request.contextPath}/review/edit?reviewNo=${reviewDto.reviewNo}" class="btn btn-positive btn-small">수정하기</a>
					<a href="${pageContext.request.contextPath}/review/delete?reviewNo=${reviewDto.reviewNo}" class="btn btn-negative btn-small">삭제하기</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<br><br>
				</div>
			</c:otherwise>
			</c:choose>
	</div>
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