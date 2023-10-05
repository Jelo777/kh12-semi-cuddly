<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>

</style>

	<div class="container w-700">
	
		<div class="float-container card mt-50">

				<div class="row left float-container">
					<h2 class="ms-20 float-left">${memberDto.memberName}님</h2>
					<h1 class="btn btn-positive btn-small float-left ms-10">${memberDto.memberLevel}</h1>
				</div>
				
				<div class="row left">
					<h5 class="ms-20">환영합니다, 즐거운 하루 되세요.</h5>
				</div>

				<div class="row float-right" >
					<h1 class="me-20">누적금액:<fmt:formatNumber value="${memberDto.memberTotalprice}" pattern="#,###원" /></h1>
					
				</div>		
		</div>

	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>