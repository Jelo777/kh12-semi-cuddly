
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>


.position-center{
	position: fixed;
	top:50%;
	left:50%;
	transform : translate(-50%,-50%);
	background: white;
	display:none;
	padding: 1em;
	border : 2px solid gray;
	border-radius : 1em;
}

</style>

<script>
	$(function() {
		

		$(".btn.btn-order").click(function(e) {

			
			var no = $(".no").val().length===0;

			if (no) {

				e.preventDefault();
				
				$(".form-input").removeClass("fail");
				$(".form-input").addClass("fail");
				 $(".fail-feedback").css("display", "block");

			}


			if ($("input[type='checkbox']:checked").length === 0) {
				e.preventDefault();
				
				$(".fail2-feedback").css("display", "block");
			}

		})
		
		$(".payType").change(function(){
		
			$(".fail2-feedback").css("display", "none");
			
			
		})
		
		
		
		
		$(".btn-select").click(function() {
			//this == 누른 버튼 

			var no = $(this).closest(".flex-container").find(".addressNo").val();
			$(".no").val(no);

			var name =$(this).closest(".flex-container").find(".addressName").text();
			$(".name").val(name);

			var contact = $(this).closest(".flex-container").find(".addressContact").text();
			$(".contact").val(contact);

			var post = $(this).closest(".flex-container").find(".addressPost").text();
			$(".post").val(post);

			var addr1 = $(this).closest(".flex-container").find(".addressAddr1").text();
			$(".addr1").val(addr1);

			var addr2 = $(this).closest(".flex-container").find(".addressAddr2").text();
			$(".addr2").val(addr2);

			var coment =$(this).closest(".flex-container").find(".addressComent").text();
			$(".coment").val(coment);

		});
		
		//배송지 목록 버튼을 눌렀을 때
		$(".btn-addressList").click(function(){
			$(".position-center").show();//배송지 리스트 폼 보이기
		});
		
		//배송지 목록에서 나가기 버튼을 눌렀을 때
		$(".btn-exit").click(function(){
			$(".position-center").hide();
		});
		//배송지 목록에서 선택 버튼을 눌렀을 때
		$(".btn-select").click(function(){
			$(".form-input").removeClass("fail")
			$(".fail-feedback").css("display", "none");
			$(".position-center").hide();
		});

	})
</script>

<div class="container w-600">
	<div class="row">
		<h2 class="mv-30">주문</h2>
	</div>
	
	<h3 class= "left">주문자정보</h3>

<hr>
	<div class="row left">
		<label>이름: </label> ${memberDto.memberName}
	</div>
	<div class="row left">
		<label>이메일: </label> ${memberDto.memberEmail}
	</div>
	<div class="row left">
		<label>전화번호: </label> ${memberDto.memberContact}
	</div>


<form action="insert" method="post">
	<div class="float-container">
		<div class="float-left">
			<h3 class="left mt-50"> 배송지 정보</h3>
		</div>
		<div class="float-right">
			<button type ="button" class="btn btn-positive w-200 btn-addressList mt-30">배송지 목록</button>
		</div>
	</div>
	
	<hr>
		<div class="container w-600 addrBox">
			

			<div class="row">
				<input type="hidden" class="no form-input" name ="addrNo" 
							value="${addressDto.addressNo}" placeholder="번호" readonly>
			</div>

			<div class="row">
				<input class="name form-input text-input w-100" value="${addressDto.addressName}" placeholder="수령인" readonly>
			</div>

	<div class="row">
		<input class="contact form-input text-input w-100" value="${addressDto.addressContact}" placeholder="연락처" readonly>
	</div>

	<div class="row">
		<input class="post form-input text-input w-100"  value="${addressDto.addressPost}" placeholder="우편번호" readonly>
	</div>

	<div class="row">
		<input class="addr1 form-input text-input w-100" value="${addressDto.addressAddr1}" placeholder="기본주소" readonly>
	</div>

	<div class="row">
		<input class="addr2 form-input text-input w-100" value="${addressDto.addressAddr2}" placeholder="상세주소" readonly>
	</div>

	<div class="row">
		<input class="coment form-input text-input w-100" name="addrComent" value="${addressDto.addressComent}" placeholder="요청사항">
	</div>
	<h1 class="row fail-feedback">배송지를 선택해주세요.</h1>
	</div>


	<!--  		 <div class="row"> -->
	<!--         <label>전화번호 : </label> -->
	<%--         ${addressDto.addressContact} --%>
	<!--         </div> -->
	<!--          <br><br> -->

	<!--           <div class="row"> -->
	<!--         <label>우편번호 : </label> -->
	<%--          ${addressDto.addressPost} --%>

	<!--         </div> -->
	<!--          <br><br> -->

	<!--           <div class="row"> -->
	<!--         <label>기본주소 : </label> -->
	<%--         ${addressDto.addressAddr1} --%>
	<!--         </div> -->
	<!--          <br><br> -->

	<!--           <div class="row"> -->
	<!--         <label>상세주소 : </label> -->
	<%--          ${addressDto.addressAddr2} --%>
	<!--         </div> -->
	<!--          <br><br> -->

	<!--           <div class="row"> -->
	<!--         <label>요청사항 : </label> -->
	<!--          <input name="addrComent"> -->
	<!--         </div> -->
	<!--          <br><br> -->

	
	<h3 class="left mt-30">주문할 상품 정보</h3>

	<c:forEach var="product" items="${ordersProductDto}" varStatus="loop">
		<div class="row container w-600 card">
			<div class="flex-container">
				<div class="row w-30">
					<input type="hidden" name="details[${loop.index}].optionNo"
									value="${product.productOptionNo}">
					<input type="hidden" name="cartNo" value="${product.cartNo}">
					<img src="/cuddly/image/product/main?productNo=${product.productNo}"
									width="150" height="150" class="image image-round ms-10"> 
					<input type="hidden" name="details[${loop.index}].productNo" value="${product.productNo}">
				</div>
			<div class="w-75">
				<div class="row left title">
					<span class="ms-10 productName">${product.productName}</span>
				</div>
				<div class="float-container">
					<div class="float-left">
						<span class="ms-10 creatorName">${product.creatorName}</span>
					</div>
					<div class="float-right">
						<span class="me-10">옵션:${product.productOptionName} / 수량:${product.cartCount} </span>
						<input type="hidden" name="details[${loop.index}].ordersDetailCount" value="${product.cartCount}">
					</div>
				</div>
				<hr class="w-95">
				<div class="row right">
<%-- 			<span class="me-10 productPrice">${product.cartPrice}원</span> --%>
					<span class="me-10 productPrice"><fmt:formatNumber value="${product.productPrice}" pattern="#,###원" /></span>
				</div>
			</div>
		</div>
			
		</div>
	</c:forEach>


<!-- 	<div class="row"> -->
<%-- 		<label>총가격:</label><fmt:formatNumber value="${total}" pattern="#,###원" /> --%>
<!-- 	</div> -->

	<div class="row left">
		<h3 class="mt-20">결제 정보</h3>
	</div>
	<hr>

	<div class="left productPrice mb-20">
		<input type="hidden" name="ordersPrice" value="${total}">총결제 금액 : <fmt:formatNumber value="${total}" pattern="#,###원" />
	</div>


	<div class="row left">
		<input type="checkbox" name="ordersPayment" value="네이버페이" class="payType">네이버 페이 
		<input type="checkbox" name="ordersPayment" value="카카오페이" class="payType">카카오 페이 
		<input type="checkbox" name="ordersPayment" value="무통장입금" class="payType">무통장 페이
	</div>
	<div class="row left">
		<span class="fail2-feedback mb-10">결제 방식을 선택해주세요</span>
	</div>


	<button class="btn btn-order btn-positive w-100">주문하기</button>
	
</form>
</div>




<div class="container w-700">
	<div class="row position-center w-700">
		<c:forEach var="addressDto" items="${list}">
			<div class="flex-container mt-10">
				<div class="w-80">
					<input type="hidden" class="addressNo"
						value="${addressDto.addressNo}">
					<div class="row left ms-10">
						<span class="addressName ms-10" style="font-size:20px; font-weight: bold;">${addressDto.addressName}</span>
						<c:if test="${addressDto.addressDefault =='Y'}">
								(기본배송지)
						</c:if>
					</div>
					<div class="row left ms-10">
						<span class="addressPost ms-10">${addressDto.addressPost}</span>
						<span class="addressAddr1">${addressDto.addressAddr1}</span>
						<span class="addressAddr2">${addressDto.addressAddr2}</span>
					</div>
					<div class="row left">
						<span class="addressContact ms-10">${addressDto.addressContact}</span>
					</div>
					<div class="row left">
						<span class="addressComent ms-10">${addressDto.addressComent}</span>
					</div>
				</div>
				<div class="w-20">
					<div class="row right">
							<button type="submit"
								class="btn btn-small btn-positive btn-select me-20">선 택</button>
					</div>
				</div>
			</div>
			
			<hr>
			
		</c:forEach>
				<button type="button" class="btn btn-exit btn-negative mt-30">나가기</button>
				<a href="/cuddly/member/address/list">
					<button class="btn btn-positive">배송지 추가</button>
				</a>
	</div>
</div>

</body>
</html>