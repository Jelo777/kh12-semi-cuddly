<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>

<style>
	.card{
            /* border:1px solid; */
            box-shadow: 0 0 0 1px #2d3436;
	}
</style>

	<div class="container w-700">
	
		<div class="flex-container card mt-50">
			<div class="w-33 mt-30">
				<div class="row left ms-30">
					<h1>${memberDto.memberName}님(${memberDto.memberLevel})</h1>
				</div>
				<div class="row left mb-30 ms-30">
					<h5>환영합니다, 즐거운 하루 되세요.</h5>
				</div>
			</div>
				<div class="w-33 mt-50" >
					<h1>누적금액:${memberDto.memberTotalprice}원</h1>
				</div>
		
		
		
		</div>

	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>