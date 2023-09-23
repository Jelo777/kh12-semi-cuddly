<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 <script src="/js/address.js"></script>
 <script src="/js/addressMypageInsert.js"></script>
 <style>
	.card{
            /* border:1px solid; */
            box-shadow: 0 0 0 1px #2d3436;
	}
</style>
 
 <script>	
 
 
	$(function(){
 <!--배송지 등록할 때 체크박스 하면 Y 아니면 N 가지는 구문  -->
		$(".checkbox").change(function(){
			if($(this).prop("checked")){
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
		
		$.ajax({
			url:"/cuddly/rest/address/insert",
			method:"post",
			data :$(e.target).serialize(),
			success:function(response){
			$("[name=addressName]").val("");//초기화
			$("[name=addressContact]").val("");//초기화
			$("[name=addressPost]").val("");//초기화
			$("[name=addressAddr1]").val("");//초기화
			$("[name=addressAddr2]").val("");//초기화
			$("[name=addressDefault]").val("Y");//초기화 얘는 원래 Y였으니깐
			loadList();
			}
		});
		
	});



	loadList();
	
	function loadList(){
		
		var memberId="${sessionScope.name}";
		
		
		
		
		$.ajax({
			
			url:"/cuddly/rest/address/list",
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
							url:"/cuddly/rest/address/delete",
							method:"post",
							data:{addressNo : addressNo},
							success:function(response){
								loadList();
							},
							
						});
						
					});
					
					//수정
					//-편집 상태 템플릿 추가
					//-전환 시 작성된 값들을 입력창으로 이동
					//-변경 취소 버튼 구현
					//- 수정 시
					$(htmlTemplate).find(".btn-edit")
										.attr("data-address-no", address.addressNo)
										.click(function(){
					
					//this == 수정버튼
					var editTemplate =$("#address-edit-template").html();
					var editHtmlTemplate= $.parseHTML(editTemplate);
					
					//value설정
					var addressNo=$(this).attr("data-address-no");//필요한가..高..
					var addressName= $(this).parents(".view-container")
											.find(".addressName").text();
											
					
					var addressDefault=$(this).parents(".view-container")
												.find(".addressDefault").text();//얘는 값이(기본 배송지)
					console.log(addressDefault);
					
					var addressContact=$(this).parents(".view-container")
											.find(".addressContact").text();
												
					var addressPost=$(this).parents(".view-container")
											.find(".addressPost").text();
												
					var addressAddr1=$(this).parents(".view-container")
											.find(".addressAddr1").text();
					
					var addressAddr2=$(this).parents(".view-container")
											.find(".addressAddr2").text();
// 					var addressComent=$(this).parents(".view-container")
// 											.find(".addressComent").text(); //일단 배제

					$(editHtmlTemplate).find("[name=addressNo]").val(addressNo);
					$(editHtmlTemplate).find("[name=addressName]").val(addressName);
					
					if(addressDefault==("(기본 배송지)")){
					$(editHtmlTemplate).find("[name=addressCheck]").prop("checked");
					$(editHtmlTemplate).find("[name=addressDefault]").val("Y");
					}
					else{ 	
						$(editHtmlTemplate).find("[name=addressCheck]").prop("checked",false);
						$(editHtmlTemplate).find("[name=addressDefault]").val("N");
						
					}
					
					$(editHtmlTemplate).find("[name=addressContact]").val(addressContact);
					$(editHtmlTemplate).find("[name=addressPost]").val(addressPost);
					$(editHtmlTemplate).find("[name=addressAddr1]").val(addressAddr1);
					$(editHtmlTemplate).find("[name=addressAddr2]").val(addressAddr2);
// 					$(editHtmlTemplate).find("[name=addressComent]").val(addressComent);
					
						//취소버튼
						$(editHtmlTemplate).find(".btn-cancel")
											.click(function(){
							$(this).parents(".edit-container")
									.prev(".view-container").show();
							$(this).parents(".edit-container").remove();
						});
						//완료 버튼
						$(editHtmlTemplate).submit(function(e){
							
							e.preventDefault();
							
							
							
							$.ajax({
								url:"/cuddly/rest/address/edit",
								method:"post",
								data: $(e.target).serialize(),
								success:function(response){
									loadList();
								}
								
								
							});
						});
						
						
						//수정 화면 배치
						$(this).parents(".view-container")
								.hide()
								.after(editHtmlTemplate);
											
											
					});
					
					
					$(".address-list").append(htmlTemplate);
						}
					},

			
			});
		
		}
	
	
	});
	
	





</script>
<script id="address-template" type="text/template">

<div class="flex-container card mt-50 view-container">
<div class="w-75 mt-20">
	<div class="row left ms-30">
		<h1 class="addressName">이름</h1>
		<span class="addressDefault"></span>
	</div>
	<div class="row left ms-30">
		<h3 class="addressContact">전화번호</h3>
	</div>
	<div class="row left ms-30">
		<h3 class="addressPost">우편번호</h3>
		<h3 class="addressAddr1">기본주소</h3>
		<h3 class="addressAddr2">상세주소</h3>
	</div>  
	<div class="row left ms-30">
		<h3 class="addressComent">요구사항</h3>
	</div>
</div>
<div class="w-25 mt-20">
	<div class="row right me-30">
		<h5>
			<button type ="button" style="width:150px; font-size:16px;" class="btn btn-positive btn-edit">수정하기</button>
			<button type ="button" style="width:150px; font-size:16px;" class="btn btn-negative btn-delete">삭제하기</button>
		</h5>
	</div>
</div>

</div>
</script>

<script id="address-edit-template" type="text/template">
	<form class="address-edit-form edit-container" autocomplete="off">

	        <div class="container w-400">
	
	            <div class="row">
	                <h1>배송지 수정</h1>
	            </div>
				
				<div class="row">
					<input type="hidden" name="addressNo" value="?">
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
					<label>기본배송지로 설정</label><input class="checkbox" type="checkbox" name="addressCheck" checked>
					<input type="hidden" name="addressDefault" value="Y">
				</div>
				
		
	            <div class="row">
	                <button type="submit" class="btn btn-positive w-100">수정</button>
	                <button type="button" class="btn btn-negative w-100 btn-cancel">취소</button>
	            </div>
	        </div>

    	</form>


</script>


<div class="container w-600">
	<div class="row">
		<div class="row address-list"></div>
	</div>
	<div class="row">
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
					<label>기본배송지로 설정</label><input class="checkbox" type="checkbox" checked>
					<input type="hidden" name="addressDefault" value="Y">
				</div>
				
		
	            <div class="row">
	                <button type="submit" class="btn btn-positive w-100">등록하기</button>
	            </div>
	        </div>

    	</form>
	
	
	</div>









</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>







