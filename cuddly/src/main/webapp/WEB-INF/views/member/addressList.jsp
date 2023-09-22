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
					$(htmlTemplate).find(".addressDefault").text("(기본 배송지)" ||"");
					}
					$(htmlTemplate).find(".addressPost").text(address.addressPost);
					$(htmlTemplate).find(".addressAddr1").text(address.addressAddr1);
					$(htmlTemplate).find(".addressAddr2").text(address.addressAddr2);
					$(htmlTemplate).find(".addressContact").text(address.addressContact);
					$(htmlTemplate).find(".addressComent").text(address.addressComent || "");
					
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
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					$(".address-list").append(htmlTemplate);
						}
					},

			
			});
		
		}
	
	
	});
	
	





</script>
<script id="address-template" type="text/template">
<div class="flex-container card mt-50">
<div class="w-75 mt-20">
	<div class="row left ms-30">
		<h1 class="addressName">이름</h1>
		<span class="addressDefault"></span>
	</div>
	<div class="row left ms-30">
		<h3 class="addressPost">우편번호</h3>
		<h3 class="addressAddr1">기본주소</h3>
		<h3 class="addressAddr2>상세주소</h3>
	</div>  
	<div class="row left ms-30">
		<h3 class="addressContact">전화번호</h3>
	</div>
	<div class="row left ms-30">
		<h3 class="addressComent">요구사항</h3>
	</div>
</div>
<div class="w-25 mt-20">
	<div class="row right me-30">
		<h5>
			<button type ="button" style="width:150px; font-size:16px;" class="btn btn-positive">수정하기</button>
			<button type ="button" style="width:150px; font-size:16px;" class="btn btn-negative btn-delete">삭제하기</button>
		</h5>
	</div>
</div>

</div>
</script>

<div class="container w-600">
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








	<div class="row">
		<div class="row address-list"></div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>