<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<script>
$(function(){
	$(".popUpOpen").click(function(e){
		e.preventDefault();
		//클릭하면 모달이 보이도록 설정
		$("#modal").show();
	});
	
	//확인버튼 클릭시 모달버튼 숨김
	$(".popUpClose").click(function(){
		$("#modal").hide();
	});
	
	//모달 확인 버튼 클릭 시 폼을 제출
	$(".popUpConfirm").click(function(){
		//폼을 선택하고 제출
		$("form").submit();
	});
});
</script>
<div class="container w-400">
	<div class="row">
		<h2 class="mv-30">${memberDto.memberId}님의 회원정보</h2>
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
									<select name="memberLevel" class="form-input find-input" style="width:100px; height:30px; padding-left:15px">
										<option value="브론즈" selected>브론즈</option>
										<option value="실버">실버</option>
										<option value="골드">골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='실버'}">
									<select name="memberLevel" class="form-input find-input" style="width:100px; height:30px; padding-left:15px">
										<option value="브론즈">브론즈</option>
										<option value="실버" selected>실버</option>
										<option value="골드">골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='골드'}">
									<select name="memberLevel" class="form-input find-input" style="width:100px; height:30px; padding-left:15px">
										<option value="브론즈">브론즈</option>
										<option value="실버">실버</option>
										<option value="골드" selected>골드</option>
										<option value="관리자">관리자</option>
									</select>
								</c:when>
								
								<c:when test="${memberDto.memberLevel =='관리자'}">
									<select name="memberLevel" class="form-input find-input" style="width:100px; height:30px; padding-left:15px">
										<option value="브론즈">브론즈</option>
										<option value="실버">실버</option>
										<option value="골드" >골드</option>
										<option value="관리자" selected>관리자</option>
									</select>
								</c:when>						
							</c:choose>
					</td>
							<td>
								<button class="popUpOpen btn btn-positive btn-small" style="width:60px">수정</button>
							<td>
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



	<div class="container w-500">
		<div class="row">
			<h2 class="mt-30">구매내역</h2>
		</div>
			
			<c:choose>
				<c:when test="${not empty ordersList}">
					<c:forEach var="ordersAdminDto" items="${ordersList}" varStatus="loop">
					<c:if test="${loop.index == 0 || ordersAdminDto.ordersNo != ordersList[loop.index - 1].ordersNo}">
		
					<div class="float-container card mv-10">
						<div class="float-left mb-10">
							<span class="ms-10">주문일 : ${ordersAdminDto.ordersDate}</span>
							<span>(주문번호 : ${ordersAdminDto.ordersNo})</span>
						</div>
						<div class="float-right">
							<c:if test="${ordersAdminDto.ordersCount > 1}">
								<div class="row right">
									<span class="me-10">외 ${ordersAdminDto.ordersCount - 1}건</span>
								<a href="ordersDetailList?ordersNo=${ordersAdminDto.ordersNo}"><span>주문상세보기</span></a>
							</div>
						</c:if>
					</div>
				
				<hr class="w-95">
				
					<div class="flex-container">
						<div class="w-25">
							<img src="${pageContext.request.contextPath}/image/product/main?productNo=${ordersAdminDto.productNo}"  
									width="100" height="100" class="image image-round">
						</div>	
				
						<div class="w-75">
							<div class="row left">
								<span class="productName">${ordersAdminDto.productName}</span>
							</div>
				
							<div class="float-container">
								<div class="float-left">
									<span class="creatorName">${ordersAdminDto.creatorName}</span>
								</div>
				
								<div class="float-right">
									<span class="optionName">옵션 : ${ordersAdminDto.productOptionName}</span>
									<span class="optionName me-10">수량 : ${ordersAdminDto.ordersDetailCount}</span>
								</div>
							</div>
				
							<div class="row right">
								<span class="productPrice me-10">
									<fmt:formatNumber value="${ordersAdminDto.ordersDetailPrice}" pattern="#,###원"></fmt:formatNumber>
								</span>
							</div>		
						</div>
					</div>
				</div>
					
			</c:if>
		</c:forEach>
	</c:when>
	
	<c:otherwise>
		<div class="row">
			<span>구매한 목록이 없습니다.</span>
		</div>
	</c:otherwise>
	
</c:choose>
		
				</div>
		</div>
				

	
<div id="modal" class="backdrop">
	<div class="modal-container w-300">
		<div class="popUp-title">
			<i class="fa-solid fa-x popUpClose" style="float:right"></i>
			<h2 style="float:left">수정완료</h2>
		</div>
		
		<hr>
		
		<div class="popUp-content center">
		 	<br><br><br>
			<h4>등급 수정이 완료되었습니다.</h4> 
			<br><br><br>
		</div>
		
		<div class="row">
			<button class="btn btn-positive w-100 popUpClose popUpConfirm">확인</button>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>