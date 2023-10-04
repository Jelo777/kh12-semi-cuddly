 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row">
		<h1 class="mv-30">크리에이터 목록</h1>
	</div>
	
	<div class="flex-container allow-wrap">
		<c:forEach var="creatorListDto" items="${list}">
			<a class="link" href="list?creator=${creatorListDto.creatorName}">
					<div class="row">
						<img class="image image-circle mh-24"
							src="/cuddly/image/creator?creatorNo=${creatorListDto.creatorNo}"
							onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
							width="200" height="200">
					</div>
					<div class="row">
						<h2 class=" mb-30">${creatorListDto.creatorName}</h2>
					</div>
			</a>
		</c:forEach>
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>