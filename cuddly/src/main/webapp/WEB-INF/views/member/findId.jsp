<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(".btn-send").find(".fa-spinner").hide();
		$(".cert-wrapper").hide();
		
		//인증번호 보내기 버튼 누르면
		//서버로 비동기 통신을 보내 메일 발송 요쳥
		$(".btn-send").click(function(){
			var email = $("[name=memberEmail]").val();
			if(email.length == 0) return;
			$(".btn-send").prop("disabled",true);
			$(".btn-send").find(".fa-spinner").show();
			$(".btn-send").find("span").text("이메일 보내는중이요");
			
			$.ajax({
				url:"/cuddly/rest/cert/send",
				method:"post",
				data:{certEmail:email},
				success: function(){
					$(".btn-send").prop("disabled".false);
					$(".btn-send").find(".fa-sppiner").hide();
					$(".btn-send").find("span").text("인증번호 보내기");
					
					window.alert("이메일로 보내드렸어요");
					
					$(".cert-wrapper").show();
				},
			});

		});
		
		//확인버튼 누르면 이메일과 인증번호를 서버로 전달해서 검사
		$(".btn-cert").click(function(){
			var email = $("[name=memberEmail]").val();
			var number = $(".cert-input").val();
			
			if(email.length==0 || number.length ==0 ) return;
			
			$.ajax({
				url:"/cuddly/rest/cert/check",
				method : "post",
				data:{
					certEmail:email,
					certNumber:number,
					
				},
				success:function(response){
					if(response.result){
						$(".cert-input").removeClass("success fail")
											.addClass("success");
						$(".btn-cert").prop("disabled",true);
					}
					else{
						$(".cert-input").removeClass("success fail")
											.addClass("fail");
					}
				},
			});
		});
	});
</script>
	<input type="email" name="memberEmail">
	<button class="btn-send">
		<i class="fa-solid fa-spinner fa-spin"></i>
		<span>인증번호 보내기</span>
	</button>
	
	<div class="cert-wrapper">
		<input type="text" class="cert-input">
		<button class="btn-cert">확인</button>
		<div class="success-feedback">아이디는 [${memberDto.memberId}]입니다</div>
		<div class="fail-feedback">인증번호 틀림요</div>
	</div>
	



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>