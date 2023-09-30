<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 
 <div class="row"><h1>나의 문의</h1></div>
 <c:forEach var="qnaDto" items="${list}">
<div class="row">
	<a href="/cuddly/product/detail?productNo=${qnaDto.productNo}">
	<button type="button"><img src="/cuddly/image/product/main?productNo=${qnaDto.productNo}" width="200" height="200"></button></a></div>
	
	<div class="row">작성자 : ${qnaDto.memberId}</div>
	<div class="row">문의 내용 : ${qnaDto.qnaContent}</div>
	<div class="row">
	<c:choose>
    <c:when test="${qnaDto.qnaAnswer != null}">
       
       답변 내용 : ${qnaDto.qnaAnswer}
       
    </c:when>
    <c:otherwise>
       답변 미완료
    </c:otherwise>
</c:choose>
</div>
<div class="row right">
작성일자 : ${qnaDto.qnaDate}
</div>
	<div class="row">
	<a href="/cuddly/qna/change?qnaNo=${qnaDto.qnaNo}">수정하기</a>
	<a href="/cuddly/qna/delete?qnaNo=${qnaDto.qnaNo}">삭제하기</a>
	</div>

	<hr>

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