<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
 
 <script>
 
 
 //피드백 JS
 $(function(){
	 var status = {
			 productItem : false,
			 creatorName : false,
			 productName : false,
			 productPrice : false,
			 attachMain : false,
			 attachDetail : false,
			 ok:function(){
				return  this.productItem && this.creatorName 
							&& this.productName && this.productPrice 
							&& this.attachMain && this.attachDetail;
			 }
	 };
	 
	 //품목선택
	 $("[name=productItem]").blur(function(){
		 var productItem = $(this).val();
		 console.log($(this).val());
		 var isValid = productItem != "none";
		 
		 $(this).removeClass("success fail");
		 if(isValid){
			 $(this).addClass("success");
		 }
		 else{
			 $(this).addClass("fail");
		 }
		 
		 //status.productItem 업데이트
		 status.productItem = isValid;
	 });
 
	 //크리에이터 입력
	$("[name=creatorName]").blur(function(){
		var creatorName = $(this).val();
		var isValid = creatorName.length > 0;

		$(this).removeClass("success fail");
		if(isValid){
			$(this).addClass("success");
		}
		else{
			$(this).addClass("fail");
		}

    	// status.creatorName 업데이트
    	status.creatorName = isValid;
	});
	 
	 
	 //상품명입력
	 $("[name=productName]").blur(function(){
		 var productName = $(this).val();
		 var isValid = productName.length > 0;
		 
		 $(this).removeClass("success fail");
		if(isValid){
			$(this).addClass("success");
		}
		else{
			$(this).addClass("fail");
		}
			
		status.productName = isValid;
	 });

	 
	 //가격입력
	$("[name=productPrice]").blur(function(){
		var productPrice = $(this).val();
		var isValid = productPrice.length > 0;
		
		$(this).removeClass("success fail");
		if(isValid){
			$(this).addClass("success");
		}
		else{
			$(this).addClass("fail");
		}
		
		status.productPrice = isValid;
	});
	 
	 

	 
	 //대표이미지
	$("[name=attachMain]").blur(function(){
		var isResult1 = $("[name=attachMain]").val() == "";

		var regex = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
		var isResult2 = regex.test($(this).val());
		var isValid = !isResult1 && isResult2;
		console.log(isValid);
	
		$(this).removeClass("success fail fali2");
		if(isResult1){
			$(this).addClass("fail");
		}
		else if(!isResult2){
			$(this).addClass("fail2");
		}
		else{
			$(this).addClass("success");
		}
		status.attachMain = isValid;
	 }); 
	 
	 //상세이미지
	 $("[name=attachDetail]").blur(function(){
		 var isResult1 = $("[name=attachDetail]").val() == "";
		 var regex = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
		var isResult2 = regex.test($(this).val());
		var isValid = !isResult1 && isResult2;
		console.log(isValid);		
		
		$(this).removeClass("success fail fali2");
		if(isResult1){
			$(this).addClass("fail");
		}
		else if(!isResult2){
			$(this).addClass("fail2");
		}
		else{
			$(this).addClass("success");
		}
		status.attachDetail = isValid;
	
	 }); 

	 
	 //페이지 이탈 방지
	//- window에 beforeunload 이벤트 설정
	$(window).on("beforeunload", function(){
		
		return false;
	
	});
	 
	 //- form 전송할 때는 beforeunload 이벤트를 제거
	 $(".join-form").submit(function(e){
		 
		// $(".form-input").blur();
		 if(!status.ok()){
		 	e.preventDefault();
		 	console.table(status);
			 //return false;
		 }
		 else{
			 $(window).off("beforeunload");
		 }
	 });

	 
	 $("[name=insert]").click(function(e){
		 if(!status.ok()){
			// console.log($(".form-input").val().length);
			 
			 $(".form-input").filter(function() {
				    return $(this).val().length === 0||$(this).val() == "none";
				}).addClass("fail");
			 
			
			 e.preventDefault(); 
		 }
		 
	 });
	 
});
	
 

 
//모달 JS
 $(function(){
 	//덜 입력하고 상품등록 버튼 클릭시 
 	$("[name=insert]").click(function(e){
 		e.preventDefault();
 		
 		var productItemValue = $("[name=productItem]").val();
 	    var creatorNameValue = $("[name=creatorName]").val();
 	    var productNameValue = $("[name=productName]").val();
 	    var productPriceValue = $("[name=productPrice]").val();
 	    var attachMainValue = $("[name=attachMain]").val();
 	    var attachDetailValue = $("[name=attachDetail]").val();

 		if(productItemValue == ""){
 			$(".fail-feedback.productItem").show();
 		}
 		else{
 			$(".fail-feedback.productItem").hide();
 		}
 		
 		if(creatorNameValue == ""){
 			$(".fail-feedback.creatorName").show();
 		}
 		else{
 			$(".fail-feedback.creatorName").hide();
 		}
 		
 		if(productNameValue == ""){
 			$(".fail-feedback.productName").show();
 		}
 		else{
 			$(".fail-feedback.productName").hide();
 		}
 		
 		if(productPriceValue == ""){
 			$(".fail-feedback.productPrice").show();
 		}
 		else{
 			$(".fail-feedback.productPrice").hide();
 		}
 		
 		if(attachMainValue == ""){
 			$(".fail-feedback.attachMain").show();
 		}
 		else{
 			$(".fail-feedback.attachMain").hide();
 		}
 		
 		if(attachDetailValue == ""){
 			$(".fail-feedback.attachDetail").show();
 		}
 		else{
 			$(".fail-feedback.attachDetail").hide();
 		}
 		
 		if(
 				productItemValue === "" ||
 				creatorNameValue === "" ||
 				productNameValue === "" ||
 				productPriceValue === "" ||
 				attachMainValue === "" ||
 				attachDetailValue === ""
 				){
 			// 하나라도 값이 비어 있을 경우 모달창 열지 않음
 			return;
 		}
 		
 	    
 		$(".fail-feedback").hide();
 		$("#modal").show();
 		
 	});
          
 	//확인버튼 클릭시 모달버튼 숨김
 	$(".popUpClose").click(function(){
 		$("#modal").hide();
 	});
             
 	// 모달 확인 버튼 클릭 시 폼을 제출
 	$(".popUpConfirm").click(function(){
 		 // 폼을 선택하고 제출
 		$("form").submit();
 		 
 		$(window).off("beforeunload");
 	});
 });
	 

 
</script>
    
 <style>
  
</style>
    
<body>
	<div class="container w-600">
		<form class="join-form" action="insert" method="post" autocomplete="off" 
						enctype="multipart/form-data">
						
		<div class="row">
			<h2 class="mv-30">상품등록</h2>
		</div>
		
		<div class="flex-container">
			<div class="row w-20">
				<span><br>카테고리</span>
			</div>
		<div class="row">
		<div class="w-80">
			<select class="form-input find-input" style="width:480px" name="productItem">
				<option value="none">품목선택</option>
				<option value="의류">의류</option>
				<option value="스티커/지류">스티커/지류</option>
				<option value="폰악세서리">폰악세서리</option>
				<option value="리빙">리빙</option>
				<option value="문구/오피스">문구/오피스</option>
				<option value="기타">기타</option>
			</select>
			<div class="fail-feedback left">품목을 선택하세요.</div>
			</div>
			<div class="row">
			<input type="text" class="form-input find-input" style="width:480px" name="creatorName" placeholder="  크리에이터 입력">
			<div class="fail-feedback left">크리에이터를 입력하세요.</div>
			</div>
		</div>
		</div>
		
		<hr>
		
	<div class="flex-container">
	<div class="w-20">
	<div class="row">
		<span><br>상품이름</span>
	</div>
	<div class="row">
		<span><br>판매가격</span>
	</div>	
	</div>
	<div class="80">
		<div class="row">
			<input  type="text" class="form-input find-input w-100" style="width:480px" name="productName" placeholder="  상품명 입력">
			<div class="fail-feedback left">상품명을 입력하세요.</div>
		</div>
		<div class="row">
			<input  type="number" class="form-input find-input w-100" style="width:480px" name="productPrice" placeholder="  가격 입력">
			<div class="fail-feedback left">가격을 입력하세요.</div>
		</div>
		</div>
	</div>	
	
	<hr>
		
		<div class="flex-container">
		<div class="w-20">
			<div class="row">
				<span><br>메인이미지</span>
			</div>
			<div class="row">
				<span><br>상세이미지</span>
			</div>	
	</div>
	<div class="w-80">
		<div class="row left file-btn">
			<input  type="file" class="form-input find-input w-100" style="width:480px; padding:6px;" name="attachMain" accept="image/*" placeholder="대표이미지">
			<div class="fail-feedback left">대표이미지를 등록하세요.</div>
			<div class="fail2-feedback left">이미지 파일만 업로드 가능합니다.</div>
		</div>
		<div class="row left">
			<input type="file" class="form-input find-input w-100" style="width:480px; padding:6px;" name="attachDetail" accept="image/*" placeholder="상세이미지">
			<div class="fail-feedback left">상세이미지를 등록하세요.</div>
			<div class="fail2-feedback left">이미지 파일만 업로드 가능합니다.</div>
		</div>
		</div>
		</div>
		
		<hr>
		
		<div class="row">
			<button class="btn btn-positive w-100 popUpOpen" name="insert">상품등록</button>
		</div>

	</form>
	</div>
</div>	
	
	<div id="modal" class="backdrop">
        <div class="modal-container w-300">
            <div class="popUp-title">
                <i class="fa-solid fa-x popUpClose" style="float:right"></i>
                <h2 style="float:left">등록완료</h2>
            </div>
            
            <hr>
            
            <div class="popUp-content center">
                <br><br><br>
                <h4>상품등록이 완료되었습니다.</h4> 
                <br><br><br>
            </div>
            
            <div class="row">
                <button class="btn btn-positive w-100 popUpClose popUpConfirm">확인</button>
            </div>
        </div>
    </div>
    
	
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>
