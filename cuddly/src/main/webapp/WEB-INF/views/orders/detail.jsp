<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>

</style>

    <title>주문 상세 정보</title>
</head>
<body>

<div class="container w-600">
	<div class="row">
    	<h2 class="mv-30">주문 상세 정보</h2>
    </div>
    
   <c:forEach var="detail" items="${ordersDetailDto}">
   		<div class="card mt-30">
			<div class="row left">
				<span class="ms-20">주문 날짜: ${detail.ordersDate}</span>
			</div>
			<div class="row right">
								<c:if test="${!detail.reviewEx}">
									<a href="/cuddly/review/write?productNo=${detail.productNo}" class="link" style="font-weight: bold; color:#BEADFA">
									리뷰쓰기</a>
								</c:if>
					</div>	
			
   			<div class="row flex-container">
   				
				<div class="w-25">
					<a href="/cuddly/product/detail?productNo=${detail.productNo}">
						<img src="/cuddly/image/product/main?productNo=${detail.productNo}"
									width="150" height="150" class="image image-round ms-10">
					</a>
				</div>
				
				<div class="w-75 mh-10">
<%-- 					주문 번호 : ${detail.ordersNo} --%>
					<div class="row left title">
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
					<br>
					<div class="row right">
						<span class="productPrice me-10">주문 가격: <fmt:formatNumber value="${detail.ordersDetailPrice}" pattern="#,###원" /></span>
					</div>
   				</div>
   				
   			</div>
						
		</div>
	</c:forEach>
</div>
			<div class="row">
				<span class="productPrice">총 주문 가격: <fmt:formatNumber value="${total}" pattern="#,###원" /></span>
			</div>

     
       
   
</body>
</html>
<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>