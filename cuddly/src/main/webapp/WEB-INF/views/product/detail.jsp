<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>
	var count = 0;

	function addSelectedOption() {
		var optionSelect = $("#optionSelect");
		var cartCount = $("#cartCount");
		var selectedOptions = $("#selectedOptions");

		// 옵션 선택 여부 확인
		if (optionSelect.val() === "옵션 선택" || cartCount.val() === "") {

			$("#optionSelect").removeClass("fail")
			$("#optionSelect").addClass("fail")
			$(".fail-feedback").css("display", "block")

			return;
		}

		var selectedCount = cartCount.val();

		var selectedOptionText = optionSelect.find(":selected").text();
		var selectedOptionDiv = $("<div class='optionList'></div>");
		selectedOptionDiv.text("선택한 옵션: " + selectedOptionText + ", 수량: "
				+ selectedCount);
		selectedOptions.append(selectedOptionDiv);

		count++;

		// 추가된 옵션 뒤에 X 아이콘을 포함한 HTML 추가
		var optionItem = $("<button class='option-remove' type='button'><i class='fa fa-times-circle'></i></button>");
		selectedOptionDiv.append(optionItem);

		optionItem.data("index", count);

		console.log(count);

		for (var i = 0; i < count; i++) {

			var hiddenInput = document.createElement("input");
			hiddenInput.className = "hiddenSelect";
			hiddenInput.type = "hidden";
			hiddenInput.name = "cartList[" + i + "].optionNo";
			hiddenInput.value = optionSelect.find(":selected").val();
			$("#orderForm").append(hiddenInput);

			var hiddenInput2 = document.createElement("input");
			hiddenInput2.type = "hidden";
			hiddenInput2.name = "cartList[" + i + "].cartCount";
			hiddenInput2.value = $(".cartCount").val();
			$("#orderForm").append(hiddenInput2);

		}

		optionSelect.val("옵션 선택");
		cartCount.val("1");

		$(".cartCount,.form-input").removeClass("fail")
		$(".fail-feedback").css("display", "none");
		$(".fail2-feedback").css("display", "none");
	}

	$(function() {

		var params = new URLSearchParams(location.search);
		var productNo = params.get("productNo");

		$.ajax({
			url : "/cuddly/rest/wishlist/check",
			method : "post",
			data : {
				productNo : productNo
			},
			success : function(response) {
				if (response.check == true) {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass(
							"fa-solid");
				} else {
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass(
							"fa-regular");
				}
				//전달받은 좋아요 개수를 하트뒤의 span에 출력
				$(".fa-heart").next("span").text(response.count);
			}
		});

		$(".fa-heart").click(
				function() {
					$.ajax({
						url : "/cuddly/rest/wishlist/action",
						method : "post",
						data : {
							productNo : productNo
						},
						success : function(response) {
							if (response.check == true) {
								$(".fa-heart").removeClass(
										"fa-solid fa-regular").addClass(
										"fa-solid");
							} else {
								$(".fa-heart").removeClass(
										"fa-solid fa-regular").addClass(
										"fa-regular");
							}
							//전달받은 좋아요 개수를 하트뒤의 span에 출력
							$(".fa-heart").next("span").text(response.count);
						}
					});
				});

		$("[name=action]").click(function(e) {
			var a = $(".hiddenSelect").val() == null;
			if ($(".hiddenSelect").val() == null) {
				$(".fail2-feedback").css("display", "block");
				e.preventDefault();
			} else if ($(this).val() == "cart") {
				var userConfirmed = confirm("장바구니로 이동하시겠습니까?");
				if (!userConfirmed) {
					/*  $(document).ready(function() {
						 $("[name=action]").val("cancel")
						 console.log($("[name=action]").val("cancel"));
						 $("#orderForm").submit();
						 
						    });  */

					$(this).val("cancel");

				}
			}

		});

		$(document).on("click", ".option-remove", function(e) {

			var index = $(this).data("index") - 1;
			$(this).closest(".optionList").remove();

			console.log("index: " + index);

			$("[name='cartList[" + index + "].optionNo']").remove();
			$("[name='cartList[" + index + "].cartCount']").remove();

			count--;

		});

	});
</script>
<script>
	//등급별 가격 찍어주는 스크립트
	$(function() {
		$(".level").hide();

		var level = $("#memberLevel").val();
		var originPrice = $(".price").data("price");
		var goldPrice = originPrice * 0.9;
		var silverPrice = originPrice * 0.95;
		var bronzePrice = originPrice;

		if (level == "골드")
			$(".price").text(goldPrice + "원");
		else if (level == "실버")
			$(".price").text(silverPrice + "원");
		else
			price = $(".price").text(bronzePrice + "원");

		$(".price-btn").click(function(e) {
			$(".gold").text("골드 : " + goldPrice + "원");
			$(".silver").text("실버 : " + silverPrice + "원");
			$(".bronze").text("브론즈 : " + bronzePrice + "원");
			$(".level").show();
		});

		$(".price-btn").mouseleave(function() {
			$(".level").hide();
		});

	});
</script>
<script>
	//상품문의 관련된 스크립트
	$(function() {
		$(".qna-write-form").hide();//문의작성란 숨겨놓기
		$(".qna-answer").hide();//문의답변 숨겨놓기
		
		$(".qna-list").click(function() {
			$(this).next(".qna-answer").show();
		});

		$(".qna-write").click(function() {
			$(".qna-write-form").show();
		});

	});
</script>
<style>
.price-by-level {
	font-size: 24px;
	text-align: center;
	background-color: white;
	box-shadow: 0px 0px 1px 0px #2d3436;
}
</style>
<input id="memberLevel" type="hidden" value="${sessionScope.level}">


<div class="container w-900">
	<div class="flex-container">
		<div class="col-2">
			<div class="row">
				<img
					src="/cuddly/image/product/main?productNo=${productDto.productNo}"
					width="100%" height="100%">
			</div>
		</div>

		<div class="col-2">
			<div class="row left ms-20">
				<h1>${productDto.productName}</h1>
			</div>
			<div class="row left ms-20">
				<label style="font-size: 22px;">${creatorName}</label>
			</div>

			<div class="row left ms-20 flex-container">
				<div class="row w-50 left">
					<h2 class="price" data-price="${productDto.productPrice}">가격</h2>
				</div>
				<div class="row w-50">
					<label class="price-btn"
						style="box-shadow: 0px 0px 1px 0px #2d3436;">등급별 가격 확인</label>
				</div>
			</div>

			<div class="price-by-level m-20">
				<div class="row">
					<label class="level gold">골드</label>
				</div>
				<div class="row">
					<label class="level silver">실버</label>
				</div>
				<div class="row">
					<label class="level bronze">브론즈</label>
				</div>
			</div>

			<div class="row left ms-20">
				<i class="fa-solid fa-heart red"></i> <span>좋아요 개수</span>
			</div>
			<div class="row left ms-20">등록일 : ${productDto.productDate}</div>
			<div class="row left ms-20">평점 : ${reviewAvg}</div>
			<div class="flex-container">
				<form id="orderForm" action="/cuddly/orders/cartInsert">
					<input type="hidden" name="productNo"
						value="${productDto.productNo}">
					<div class="row ms-20">
						<select id="optionSelect" class="form-input w-100">
							<option>옵션 선택</option>
							<c:forEach var="optionList" items="${optionList}">
								<option class="select" value="${optionList.productOptionNo}">${optionList.productOptionName}</option>
							</c:forEach>
						</select>
						<div class="fail-feedback">옵션을 선택하세요</div>
					</div>
					<div class="row left ms-20">
						<input type="number" min="1" id="cartCount"
							class="cartCount form-input w-50" value="1">
						<button class="btn" type="button" onclick="addSelectedOption();"
							name="add">옵션추가</button>
						<div id="selectedOptions"></div>
					</div>
					<div class="fail2-feedback">옵션을 최소 하나이상 추가해주세요</div>
					<div class="row ms-20">
						<button class="btn w-100" name="action" value="order"
							type="submit">주문</button>
					</div>
					<div class="row ms-20">
						<button class="btn btn-positive btn-cart w-100" name="action"
							value="cart" type="submit">장바구니</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div id="productDetail"
		class="flex-container form-input form-underline">
		<h3 class="col-3">
			<a class="link" href="#productDetail"><label class="purple">상품상세</label></a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#reviewList">리뷰</a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#qnaList">상품문의</a>
		</h3>
	</div>

	<div class="row">
		<img
			src="/cuddly/image/product/detail?productNo=${productDto.productNo}"
			width="100%" height="100%">
	</div>



	<div class="row left" id="reviewList">
		<h2>리뷰</h2>
	</div>
	<div class="flex-container form-input form-underline">

		<h3 class="col-3">
			<a class="link" href="#productDetail">상품상세</a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#reviewList"><label class="purple">리뷰</label></a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#qnaList">상품문의</a>
		</h3>

	</div>

	<c:forEach var="reviewListDto" items="${reviewList}">
		<div class="flex-container" style="border: 1px solid #636e72;">
			<div class="w-75" style="padding: 1em;">
				<div class="row left">${productDto.productName}
					${reviewListDto.reviewGrade}</div>
				<div class="row left">${reviewListDto.memberId}
					${reviewListDto.reviewDate}</div>
				<div class="row left">${reviewListDto.reviewContent}</div>
			</div>
			<div class="w-25" style="padding: 1em;">
				<img
					src="/cuddly/image/review/image?reviewNo=${reviewListDto.reviewNo}"
					width="100%" height="100%">
			</div>
		</div>
	</c:forEach>

	<div class="row left" id="qnaList">
		<h2>Q&A</h2>
	</div>
	<c:if test="${sessionScope.name != null}">
		<div class="row right">
			<button type="button" class="btn qna-write">문의하기</button>
		</div>
	</c:if>

	<div class="row qna-write-form">
		<form action="/cuddly/qna/write" method="post">
			<input type="hidden" name="productNo" value="${productDto.productNo}">
			<input type="hidden" name="memberId" value="${sessionScope.name}">
			<div class="row">
				<input class="form-input w-100" name="qnaContent"
					placeholder="상품문의내용입력">
			</div>
			<div class="row">
				<button class="btn btn-positive w-100">작성</button>
			</div>
		</form>
	</div>

	<div class="flex-container form-input form-underline">
		<h3 class="col-3">
			<a class="link" href="#productDetail">상품상세</a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#reviewList">리뷰</a>
		</h3>
		<h3 class="col-3">
			<a class="link" href="#qnaList"><label class="purple">상품문의</label></a>
		</h3>
	</div>

	<table class="table table-border">
		<tr>
			<th>답변상태</th>
			<th>문의내용</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="qnaListDto" items="${qnaList}">
			<tr class="qna-list">
				<td><c:choose>
						<c:when test="${qnaListDto.qnaAnswer==null}">
						답변미완료
					</c:when>
						<c:otherwise>
						답변완료
					</c:otherwise>
					</c:choose></td>
				<td>${qnaListDto.qnaContent}</td>
				<td>${qnaListDto.memberId}</td>
				<td>${qnaListDto.qnaDate}</td>
			</tr>
			<c:if test="${qnaListDto.qnaAnswer!=null}">
				<tr class="qna-answer">
					<td colspan="4">${qnaListDto.qnaAnswer}</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>