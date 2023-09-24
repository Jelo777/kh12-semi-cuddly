<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row">
		<h1>크리에이터 목록</h1>
	</div>
	<div class="flex-container allow-wrap">
		<c:forEach var="creatorListDto" items="${list}">
			<a class="link" href="list?creatorName=${creatorListDto.creatorName}">
				<div claa="col-4">
					<div class="row">
						<img class="image image-circle"
							src="/cuddly/image/creator?creatorNo=${creatorListDto.creatorNo}"
							onerror="this.src='https://dummyimage.com/200x200/000/fff;'"
							width="200" height="200" />
					</div>
					<div class="row">
						<h2>${creatorListDto.creatorName}</h2>
					</div>
				</div>
			</a>
		</c:forEach>
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>