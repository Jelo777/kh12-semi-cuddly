<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>


	
	<div class="row">
		<h2>FAQ관리</h2>
	</div>
	
	<br><br>

	
	<c:if test="${sessionScope.name != null}">
<h3><a href="write">글쓰기</a></h3>
</c:if>

<div class="row left category-links">
    <select name="category" onchange="location = this.value;">
        <option value="">카테고리 선택</option>
        <option value="list?category=공지사항">공지사항</option>
        <option value="list?category=기타">기타</option>
        <option value="list?category=주문결제">주문결제</option>
        <option value="list?category=회원정보">회원정보</option>
    </select>
</div>



		
	<form action="list" method="post" autocomplete="off">
		<div class="row">
		
		
	
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
				<th>no</th>
				<th>title</th>
				<th>writer</th>
				<th>date</th>
				<th>category</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="faqDto" items="${list}">
					<tr>
			<td>${faqDto.faqNo}</td>
			
			<td align="left">
				<!-- 제목을 누르면 상세페이지로 이동 -->
				<a class="link" href="detail?faqNo=${faqDto.faqNo}">
					${faqDto.faqTitle}
				</a>
			</td>
		
			<td>관리자</td>
			<td>${faqDto.faqDate}</td>
			<td>${faqDto.faqCategory}</td>
						
							
					</tr>
				</c:forEach>
			</tbody>
	
		</table>
	</div>
	
</div>

<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
		<a href="list?${vo.prevQueryString}"> <i
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
		<a href="list?${vo.nextQueryString}"> <i
			class="fa-solid fa-angle-right"></i>
		</a>
	</c:if>
</div>


<form action="list" method="get">
    <div class="row search-container">
        <select name="type" required>
            <option value="board_title">제목</option>
            <option value="board_writer">작성자</option>
        </select>
        <input type="search" name="keyword" required placeholder="검색어 입력" value="${param.keyword}">
        <button type="submit">검색</button>
    </div>
</form>






<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>