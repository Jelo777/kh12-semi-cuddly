<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
 <script src="/js/address.js"></script>
 <script src="/js/addressMypageInsert.js"></script>
 <!--배송지 등록할 때 체크박스 하면 Y 아니면 N 가지는 구문  -->
 <script>
	$(function(){
// 		$(".checkbox").change(function(){
// 			if($(this).prop("checked")){
// 				$("[name=addressDefault]").prop("value","Y");
// 			}
// 			else{
// 				$("[name=addressDefault]").prop("value","N");
// 			}
// 		});
// 	$(".address-insert-form").submit(function(e){
		
// 		e.preventDefault();
		
// 		$.ajax({
// 			url:"/cuddly/rest/address/insert",
// 			method:"post",
// 			data :$(e.target).serialize(),
// 			$("[name=addressName]").val("");//초기화
// 			loadList();
// 		});
		
// 	});
	loadList();
	
	function loadList(){
		
		var memberId="${sessionScope.name}";
		
		
		
		
		$.ajax({
			
			url:"/cuddly/rest/address/list",
			method:"post",
			data:{memberId:memberId},
			success:function(response){
				
				
				$(".address-list").empty(),//자기 자신을 제외한 내부 코드 삭제
				
				for(var i=0; i<response.length;i++){
					var address=response[i];
					
					var template = $("#address-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					
					$(htmlTemplate).find(".addressName").text(address.addressName);
					if(addressDefault.val()=="Y"){
					$(htmlTemplate).find(".addressDefault").text("(기본 배송지)");
					}
					$(htmlTemplate).find(".addressPost").text(address.addressPost);
					$(htmlTemplate).find(".addressAddr1").text(address.addressAddr1);
					$(htmlTemplate).find(".addressAddr2").text(address.addressAddr2);
					$(htmlTemplate).find(".addressContact").text(address.addressContact);
					$(htmlTemplate).find(".addressComent").text(address.addressComent || "");
					
					///////////////////////////////////////////////////////////////////////
					
					//이 사이는 수정 삭제 만들고 추가됨
					
					///////////////////////////////////////////////////////////////////////
					
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
		<h1 class="addressName">이름<span class="addressDefault">기본 배송지유무</span>
		</h1>
	</div>
	<div class="row left ms-30">
		<h5 class="addressPost">우편번호</h5>
		<h5 class="addressAddr1">기본주소</h5>
		<h5 class="addressAddr2>상세주소</h5>
	</div>  
	<div class="row left ms-30">
		<h5 class="addressContact">전화번호</h5>
	</div>
	<div class="row left ms-30">
		<h5 class="addressComent">요구사항</h5>
	</div>
</div>
<div class="w-25 mt-20">
	<div class="row right me-30">
		<h5>
			<button type ="button"  style="width:150px; font-size:16px;"class="btn btn-positive">수정하기</button>
		</h5>
	</div>
</div>

</div>
</script>

<div class="container w-600">
	<div class="row">
		<div class="row address-list"></div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>