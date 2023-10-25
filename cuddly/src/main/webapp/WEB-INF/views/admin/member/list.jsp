<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<script>

$(function(){
	$(".search-btn").click(function(e){
		
		var isType = $("[name=type]").val();
		var isKeyword = $("#kw").val();
		
		if(isType == '선택'){
			alert("검색 타입을 선택하세요.");
			e.preventDefault();
		}
		else if (isKeyword.length == 0){
			alert("검색어를 입력하세요.");
			e.preventDefault();
		}
		else{
			$.ajax({
				url : window.contextPath+"/admin/member/list",
				method : "post",
				data : $("form").serialize(),
				success : function(response){
				}
			});		
		}	
		
	});
		
});


</script>

<div class="container w-900">
	
	<div class="row">
		<h2 class="mv-30">회원관리</h2>
	</div>
	
	<div class="row right">
		<form action="list" method="post" autocomplete="off">
			<c:choose>
				<c:when test="${vo.type == 'member_id'}">
					<select class="form-input find-input" style="width:200px" name="type">
						<option>선택</option>
						<option value="member_id" selected>아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
					
				<c:when test="${vo.type == 'member_name'}">
					<select class="form-input underline-input" style="width:150px; padding-left:50px;" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name" selected>이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
				
				<c:when test="${vo.type == 'member_contact'}">
					<select class="form-input underline-input" style="width:150px; padding-left:50px;" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact" selected>연락처</option>
						<option value="member_level">등급</option>
					</select>
				</c:when>
					
				<c:when test="${vo.type == 'member_level'}">
					<select class="form-input underline-input" style="width:150px; padding-left:50px;" name="type">
						<option>선택</option>
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">연락처</option>
						<option value="member_level" selected>등급</option>
					</select>
				</c:when>
				
				<c:otherwise>
					<select class="form-input underline-input" style="width:150px; padding-left:50px;" name="type">
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
				<input id="kw" class="form-input underline-input" type="text" name="keyword" value="${vo.keyword}" style="width:300px;"> 
			</c:when>
			<c:otherwise>
				<input id="kw" class="form-input underline-input" type="text" name="keyword" 
							placeholder="검색어 입력" style="width:300px; padding-left:10px"> 
			</c:otherwise>
		</c:choose>	
			
				<button class="btn btn-positive search-btn">검색</button>
		</form>
	</div>
	
	<div class="row">
		<table class="table table-slit">
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
			
				<c:choose>
				
					<c:when test="${list.size() == 0}">
						<tr>
							<td colspan="8">검색결과가 없습니다.</td>
						</tr>
					</c:when>
					
					<c:otherwise>
						<c:forEach var="memberListDto" items="${list}">
							<tr>
								<td>${memberListDto.memberId}</td>
								<td>${memberListDto.memberName}</td>
								<td>${memberListDto.memberContact}</td>
								<td>${memberListDto.memberEmail}</td>
								<td>${memberListDto.memberLevel}</td>
								<td>
									<fmt:formatNumber value="${memberListDto.memberTotalprice}" pattern="#,###원" ></fmt:formatNumber>
								</td>
								<td>${memberListDto.memberJoin}</td>
								<td>
									<a class="link" href="edit?memberId=${memberListDto.memberId}">
										<button class="btn btn-positive btn-small">보기</button>	
									</a>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
					
				</c:choose>
			
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