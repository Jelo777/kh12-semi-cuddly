<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<title>주문 목록</title>
<style>

</style>


<body>
<script>

$(function(){


	
})


</script>

<div class="container w-600">
	<div class="row">
		<h2 class="mv-30">나의 주문 목록</h2>
	</div>

	<c:forEach var="detail" items="${list}">
		<div class="card mt-30">
			
			<div class="float-container">
				<div class="float-left">
					<span class="ms-20">주문일 : ${detail.ordersDate}</span>
				</div>
				
				<div class="float-right me-20">
							<c:choose>
								<c:when test="${detail.two}">
									<a href="/cuddly/orders/detail?ordersNo=${detail.ordersNo}" class="link" style="font-weight: bold; color:#BEADFA">
										외 ${detail.orderCount}건 더보기</a>
								</c:when>
							<c:otherwise>
								<c:if test="${!detail.reviewEx}">
									<a href="/cuddly/review/write?productNo=${detail.productNo}" class="link" style="font-weight: bold; color:#BEADFA">
									리뷰쓰기</a>
								</c:if>
							</c:otherwise>
						</c:choose>							
					</div>	
			</div>
			
			<hr class="w-95">
			
			<div class="row flex-container">
				<div class="w-25">
					<a href="/cuddly/product/detail?productNo=${detail.productNo}">
						<img src="/cuddly/image/product/main?productNo=${detail.productNo}" 
									width="150" height="150" class="image image-round ms-10">
					</a>
				</div>
				
				<div class=" w-75 mh-10">
<%-- 					주문 번호 : ${detail.ordersNo} --%>
					<div class="row left">
						<span class="productName ms-10">${detail.productName}</span>
					</div>
					<div class="row float-container">
						<div class="float-left ms-10">
						 	<span class="creatorName">${detail.creatorName}</span>
						</div>
						<div class="float-right">
							<span class="optionName me-10">옵션 : ${detail.productOptionName} / 수량: ${detail.ordersDetailCount}</span>
							</div>
					</div>
					<hr class="w-95 mb-20">
					<div class="row right">
						<span class="creatorName me-10">주문 가격:  <fmt:formatNumber value="${detail.ordersDetailPrice}" pattern="#,###원" /></span>
					</div>	
					<div class="row right">
						<span class="productPrice me-10">총 주문가격:  <fmt:formatNumber value="${detail.ordersPrice}" pattern="#,###원" /></span>
					</div>
				</div>
				<hr>
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
</div>

</body>
</html>
<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>