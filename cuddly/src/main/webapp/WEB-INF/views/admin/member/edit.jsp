<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container w-400">
	<div class="row">
		<h2>${memberDto.memberId}님의 회원정보</h2>
	</div>

	<div class="row">
		<table class="table table-slit">
			<tr>
				<th>아이디</th>
				<td>${memberDto.memberId}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>이름</th>
				<td>${memberDto.memberName}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>연락처</th>
				<td>${memberDto.memberContact}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>이메일</th>
				<td>${memberDto.memberEmail}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>생년월일</th>
				<td>${memberDto.memberBirth}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>등급</th>
					<form action="edit" method="post">
					<td>
							<input type="hidden" name="memberId" value="${memberDto.memberId}">
							
							<c:choose>
								<c:when test="${memberDto.memberLevel =='브론즈'}">
									<select name="memberLevel">
										<option value="브론즈" selected>브론즈</option>
										<option value="실버">실버</option>
										<option value="골드">골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='실버'}">
									<select name="memberLevel">
										<option value="브론즈">브론즈</option>
										<option value="실버" selected>실버</option>
										<option value="골드">골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='골드'}">
									<select name="memberLevel">
										<option value="브론즈">브론즈</option>
										<option value="실버">실버</option>
										<option value="골드" selected>골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='관리자'}">
									<select name="memberLevel">
										<option value="브론즈">브론즈</option>
										<option value="실버">실버</option>
										<option value="골드" >골드</option>
										<option value="관리자" selected>관리자</option>
									</select>
								</c:when>						
							</c:choose>
					</td>
							<td><button>수정</button><td>
					</form>
				</tr>
			
			<tr>
				<th>누적구매금액</th>
				<td>${memberDto.memberTotalprice}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>가입일</th>
				<td>${memberDto.memberJoin}</td>
				<td></td>
			</tr>
			
			<tr>
				<th>비밀번호변경일</th>
				<td>${memberDto.memberUdate}</td>
				<td></td>
			</tr>
			
		</table>
	</div>	
	<div class="row right">
		<a href="list"><button class="btn btn-positive">목록</button></a>
	</div>
</div>		


	<h1>구매내역</h1>

	<div class="container w-500">
		<div class="row flex-container align-center card">
			<c:forEach var="ordersDto" items="${ordersList}">
				<div class="row">
					<span>${ordersDto.ordersDate}</span>
						<div class="row">
							<span>${ordersDto.orders}</span>
						</div>
				</div>
				
			</c:forEach>
		</div>
	</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>