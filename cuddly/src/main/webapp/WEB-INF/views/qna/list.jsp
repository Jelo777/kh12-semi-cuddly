<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 
 <h1>전체 문의글</h1>
 <c:forEach var="qnaDto" items="${list}">
<div>
	<a href="${pageContext.request.contextPath}/product/detail?productNo=${qnaDto.productNo}"><button type="button"><img src="${pageContext.request.contextPath}/image/product/main?productNo=${qnaDto.productNo}" width="200" height="200"></button></a><br><br>
	작성자 : ${qnaDto.memberId}	<br><br>
	문의 내용 : ${qnaDto.qnaContent} <br><br>
	
	<c:choose>
    <c:when test="${qnaDto.qnaAnswer != null}">
       
       답변 내용 : ${qnaDto.qnaAnswer}
       
    </c:when>
    <c:otherwise>
       답변 미완료
    </c:otherwise>
</c:choose>
	
	
	
	
	
	<hr>
	
	

</div>
</c:forEach>

</body>
</html>