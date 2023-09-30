
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.card {
	/* border:1px solid; */
	box-shadow: 0 0 0 1px #2d3436;
}


.list {
	box-shadow: 0 0 0 1px #2d3436;
}

.position-center{

	position: fixed;
	top:50%;
	left:50%;
	transform : translate(-50%,-50%);
	background: white;
 		box-shadow: 0 0 0 2px black;
	display:none;
	padding:0.5em;

}
</style>

<script>
	$(function() {
		

		$(".btn.btn-order").click(function(e) {

			var no = $
			{
				NoAddr
			}
			;

			if (no) {

				e.preventDefault();
				alert("기본 배송지를 설정해주세요")

			}


			if ($("input[type='checkbox']:checked").length === 0) {
				e.preventDefault();
				alert("결제방식을 선택해주세요");
			}

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
			$(".position-center").hide();
		});

	})
</script>


	<h1>주문할 상품 정보</h1>


<br>
<br>
<h4>주문자정보</h4>
<br>

<div class="row">
	<label>이름: </label> ${memberDto.memberName}
</div>
<div class="row">
	<label>이메일: </label> ${memberDto.memberEmail}
</div>
<div class="row">
	<label>전화번호: </label> ${memberDto.memberContact}
</div>

<br>
<br>

<form action="insert" method="post">
	<h1>배송지 정보</h1>
	<br>
	<br>

	<button type ="button" class="btn btn-positive w-400 btn-addressList">배송지 목록</button>


	<div class="row">
		<input type="hidden" class="no form-input" name ="addrNo" value="" placeholder="번호" readonly>
	</div>

	<div class="row">
		<input class="name form-input"  value="" placeholder="수령인" readonly>
	</div>

	<div class="row">
		<input class="contact form-input" value="" placeholder="연락처" readonly>
	</div>

	<div class="row">
		<input class="post form-input" value="" placeholder="우편번호" readonly>
	</div>

	<div class="row">
		<input class="addr1 form-input" value="" placeholder="기본주소" readonly>
	</div>

	<div class="row">
		<input class="addr2 form-input" value="" placeholder="상세주소" readonly>
	</div>

	<div class="row">
		<input class="coment form-input"  name="addrComent" value="" placeholder="요청사항">
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


	<h1>주문할 상품 정보</h1>

	<c:forEach var="product" items="${ordersProductDto}" varStatus="loop">
		<input type="hidden" name="details[${loop.index}].optionNo"
			value="${product.productOptionNo}">
		<input type="hidden" name="cartNo" value="${product.cartNo}">
		<div class="row">
			<img src="/cuddly/image/product/main?productNo=${product.productNo}"
				width="200" height="200"> <input type="hidden"
				name="details[${loop.index}].productNo" value="${product.productNo}">
		</div>

		<div class="row">
			<label>상품 이름:</label>${product.productName}
		</div>

		<div class="row">
			<label>크리에이터:</label>${product.creatorName}
		</div>

		<div class="row">
			<label>상품 가격:</label>${product.cartPrice}
		</div>

		<div class="row">
			<label>옵션:</label>${product.productOptionName}
		</div>

		<div class="row">
			<label>수량:</label>${product.cartCount} <input type="hidden"
				name="details[${loop.index}].ordersDetailCount"
				value="${product.cartCount}">
		</div>
		<br>
		<br>
	</c:forEach>



	<div class="row">
		<label>총가격:</label>${total}
	</div>

	<div class="row">
		<h1>결제 정보</h1>
	</div>

	<input type="hidden" name="addressNo" value="${addressDto.addressNo}">
	<input type="hidden" name="ordersPrice" value="${total}">결제
	금액:${total}



	<div class="row">
		<input type="checkbox" name="ordersPayment" value="네이버페이"
			class="payType">네이버 페이 <input type="checkbox"
			name="ordersPayment" value="카카오페이" class="payType">카카오 페이 <input
			type="checkbox" name="ordersPayment" value="무통장입금" class="payType">무통장
		페이
	</div>


	<button class="btn btn-order">주문하기</button>
</form>










<div class="container w-700">
	<div class="row position-center w-700">
		<c:forEach var="addressDto" items="${list}">
			<div class="flex-container card mt-10">
				<div class="w-75 mt-20">
					<input type="hidden" class="addressNo"
						value="${addressDto.addressNo}">
					<div class="row left ms-10">
						<h1 class="addressName">${addressDto.addressName}</h1>
						<c:if test="${addressDto.addressDefault =='Y'}">
								(기본배송지)
								</c:if>
	
					</div>
					<div class="row left ms-10">
						<h5 class="addressPost">${addressDto.addressPost}</h5>
						<h5 class="addressAddr1">${addressDto.addressAddr1}</h5>
						<h5 class="addressAddr2">${addressDto.addressAddr2}</h5>
					</div>
					<div class="row left ms-10">
						<h5 class="addressContact">${addressDto.addressContact}</h5>
					</div>
					<div class="row left ms-10">
						<h5 class="addressComent">${addressDto.addressComent}</h5>
					</div>
				</div>
				<div class="w-25 mt-20">
					<div class="row right me-10">
						<h5>
							<button type="submit" style="width: 150px; font-size: 16px;"
								class="btn btn-positive btn-select">선택</button>
						</h5>
					</div>
				</div>
	
			</div>
		</c:forEach>
				<button type="button" style="width: 150px; font-size: 16px;" 
					class="btn btn-exit mt-30">나가기</button>
	</div>
</div>

</body>
</html>