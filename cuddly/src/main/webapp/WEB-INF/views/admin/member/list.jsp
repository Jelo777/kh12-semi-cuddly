<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-800">
	
	<div class="row">
		<h2>회원관리</h2>
	</div>
	
	<form action="list" method="post" autocomplete="off">
		<div class="row">
			<c:choose>
				<c:when test="${vo.type == 'member_id'}">
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id" selected>아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
					
				<c:when test="${vo.type == 'member_name'}">
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name" selected>이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
				
				<c:when test="${vo.type == 'member_contact'}">
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact" selected>연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
					
				<c:when test="${vo.type == 'member_level'}">
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level" selected>등급</option>
					</select>
				</c:when>
					
				<c:when test="${vo.type == 'member_level'}">
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level" selected>등급</option>
					</select>
				</c:when>
				
				<c:otherwise>
					<select class="form-input" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:otherwise>				
			</c:choose>
			
		<c:choose>
			<c:when test="${vo.keyword != null}">
				<input class="form-input" type="text" name="keyword" value="${vo.keyword}"> 
			</c:when>
			<c:otherwise>
				<input class="form-input" type="text" name="keyword" placeholder="검색어 입력"> 
			</c:otherwise>
		</c:choose>	
		
			<button class="btn btn-positive">검색</button>
		</div>
	</form>
	
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>등급</th>
					<th>누적구매금액</th>
					<th>가입일</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberListDto" items="${list}">
					<tr>
						<td>${memberListDto.memberId}</td>
						<td>${memberListDto.memberName}</td>
						<td>${memberListDto.memberContact}</td>
						<td>${memberListDto.memberEmail}</td>
						<td>${memberListDto.memberLevel}</td>
						<td>${memberListDto.memberTotalprice}</td>
						<td>${memberListDto.memberJoin}</td>
						<td>
							<a class="link" href="edit?memberId=${memberListDto.memberId}"><button>보기</button></a>
						</td>
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

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>