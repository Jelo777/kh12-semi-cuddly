<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 <script src="/js/address.js"></script>
 <script src="/js/addressInsert.js"></script>
 <style>
	.position-center{
	
		position: fixed;
		top:50%;
		left:50%;
		transform : translate(-50%,-50%);
		background: white;
  		box-shadow: 0 0 0 2px black;
		display:none;
	
	}
</style>
 
 <script>

 
 
	$(function(){
		
	    // 배송지 등록하기 버튼을 클릭했을 때
	    $("button.btn-positive.w-400").click(function () {
	        $(".position-center").show(); // 배송지 등록 폼 보이기
	    });

	    // 취소하기 버튼을 클릭했을 때
	    $("button.btn-negative.w-100").click(function () {
	        $(".position-center").hide(); // 배송지 등록 폼 감추기
	    });

		
 <!--배송지 등록할 때 체크박스 하면 Y 아니면 N 가지는 구문  -->
 
 		//문서 전체에 이벤트 설정
 		//- 장점 : 나중에 생겨도 걸림
 		//- 단점 : 페이지가 느려짐
 		$(document).on("change", $(".checkbox"), function(e){
 			if($(e.target).prop("checked")){
				$("[name=addressDefault]").prop("value","Y");
			}
			else{
				$("[name=addressDefault]").prop("value","N");
			}
 		});
 		
	$(".address-insert-form").submit(function(e){
		//this == e.target == 폼(form)
		
		
		//기본 이벤트 차단
		e.preventDefault();
		//체크박스 상태 가져오기
		 var isDefault = $(".checkbox").prop("checked");
		
		 $("[name=addressDefault]").val(isDefault ? "Y" : "N");
		
		$.ajax({
			url:window.contextPath+"/rest/address/insert",
			method:"post",
			data :$(e.target).serialize(),
			success:function(response){
			$("[name=addressName]").val("");//초기화
			$("[name=addressContact]").val("");//초기화
			$("[name=addressPost]").val("");//초기화
			$("[name=addressAddr1]").val("");//초기화
			$("[name=addressAddr2]").val("");//초기화
			$("[name=addressDefault]").val("Y");//초기화 얘는 원래 Y였으니깐
			$(".position-center").hide(); // 배송지 등록 폼 감추기
			loadList();
			}
		});
		
	});



	loadList();
	
	function loadList(){
		
		var memberId="${sessionScope.name}";
		
		
		
		
		$.ajax({
			
			url:window.contextPath+"/rest/address/list",
			method:"post",
// 			data:{memberId:memberId},//필요없는거같은디
			success:function(response){
				console.log(response);
				
				
				$(".address-list").empty();//자기 자신을 제외한 내부 코드 삭제
				
				for(var i=0; i<response.length; i++){
					var address=response[i];
			
					var template = $("#address-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					
					$(htmlTemplate).find(".addressName").text(address.addressName);
					var addressDefault = address.addressDefault;
					if(addressDefault==("Y")){
					$(htmlTemplate).find(".addressDefault").text("(기본 배송지)");
					}
					$(htmlTemplate).find(".addressPost").text(address.addressPost);
					$(htmlTemplate).find(".addressAddr1").text(address.addressAddr1);
					$(htmlTemplate).find(".addressAddr2").text(address.addressAddr2);
					$(htmlTemplate).find(".addressContact").text(address.addressContact);
					$(htmlTemplate).find(".addressComent").text(address.addressComent || "");
					
					
					
					//삭제
					
					
					$(htmlTemplate).find(".btn-delete").attr("data-address-no",address.addressNo);
					$(htmlTemplate).find(".btn-delete").click(function(e){
						
						var addressNo = $(e.target).attr("data-address-no");
						$.ajax({
							url:window.contextPath+"/rest/address/delete",
							method:"post",
							data:{addressNo : addressNo},
							success:function(response){
								loadList();
							},
							
						});
						
					});
					

					
					
					$(".address-list").append(htmlTemplate);
						}
					},

			
			});
		
		}
	
	
	});
	

</script>

<h2 class="mv-30">배송지 목록</h2>
	
<script id="address-template" type="text/template">

<div class="flex-container card mb-30 view-container">
<div class="w-80">
	<div class="row left">
		<span class="addressName ms-10 productName">이름</span>
		<span class="addressDefault"></span>
	</div>
	<div class="row left">
		<span class="addressContact ms-10">전화번호</span>
	</div>
	<div class="row left">
		<div class="row left">
			<span class="addressPost ms-10" style="font-size:14px">우편번호</span>
		</div>
		<div class="row left">
			<span class="addressAddr1 ms-10 mv-10">기본주소</span>
			<span class="addressAddr2">상세주소</span>
		</div>
	</div>  
	<div class="row left">
		<span class="addressComent ms-10" style="font-size:14px">요구사항</span>
	</div>
</div>
<div class="w-20">
	<div class="row right mt-30">
		<h5>
			<button type ="button" class="btn btn-positive btn-small btn-delete me-10">삭제하기</button>
		</h5>
	</div>
</div>

</div>
</script>




<div class="container w-600">
	<div class="row">
		<div class="row address-list"></div>
	</div>
	<div class="row">
		<button type="button" class="btn btn-positive w-400">배송지 등록하기</button>
	</div>
	
	<div class="row position-center w-700" >
		 <form class="address-insert-form" autocomplete="off">
	        <div class="container w-400">
	        
	            <div class="row">
	                <h1>배송지 등록</h1>
	            </div>
	
	            <div class="row">
	                <input type="text" class="form-input w-100" name="addressName" 
	                        placeholder="수령인">
	                <div class="fail-feedback">이름 형식이 올바르지 않습니다</div>
	            </div>
	
	            <div class="row">
	                <input type="text" class="form-input w-100" name="addressContact" 
	                        placeholder="전화번호">
	                <div class="fail-feedback">전화번호 형식이 올바르지 않습니다</div>
	            </div>
	
	            <div class="row left">
	                <input type="text" class="form-input post-search" name="addressPost" 
	                       			 placeholder="우편번호" size="6" maxlength="6" readonly>
	                <button type="button" class="btn post-search">
	                    <i class="fa-solid fa-magnifying-glass"></i>
	                </button>
	                <input type="text" class="form-input w-100 mt-10 post-search" 
	                         		name="addressAddr1" placeholder="기본주소" readonly>
	                
	                <input type="text" class="form-input w-100 mt-10" 
	                        		name="addressAddr2" placeholder="상세주소">
	                <div class="fail-feedback">모든 주소를 작성하세요</div>
	            </div>
	            
				<div>
					<label>기본배송지로 설정</label><input class="checkbox" type="checkbox"  checked>
					<input type="hidden" name="addressDefault" value="Y">
				</div>
				
	            <div class="row">
	                <button type="submit" class="btn btn-positive w-100 write">등록하기</button>
	                <button type="button" class="btn btn-negative w-100">취소하기</button>
	            </div>
	            
	        </div>
    	</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>
