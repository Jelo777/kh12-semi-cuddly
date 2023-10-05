<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			cartCount.val(stock);
			return;
		}
		
		var selectedOption = optionSelect.find(":selected");
		var stock = selectedOption.data("stock");
		
		var selectedCount = cartCount.val();
		
		
		if(selectedCount>stock){
			
			$(this).addClass("fail");
			$(".fail3-feedback").css("display", "block");
			cartCount.val(stock);
			return;
		}
		else if(selectedCount<=0){
			$("#cartCount").addClass("fail");
			return;
			
		}
		
		selectedOption.removeData("stock").data("stock", stock - selectedCount);
			
		
		
		

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
		$(".fail3-feedback").css("display", "none");
		
		
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
		
		
		  $("#optionSelect").change(function() {
			  
			  $("#cartCount").val("1");
			  $("#cartCount").removeClass("fail");
			  $(".form-input").removeClass("fail")
			  $(".fail3-feedback").css("display", "none");
			  $(".fail-feedback").css("display", "none");
				$(".fail2-feedback").css("display", "none");
		        var selectedOption = $(this).find(":selected");
		        var optionStock = selectedOption.data("stock");

						        
		        if (optionStock !== undefined && optionStock !== null) {
		            $("#cartCount").attr("max", optionStock);
		            $("#cartCount").attr("min", 1);
		            
		            
		            
		            
		        } else {
		            $("#cartCount").removeAttr("max");
		        }
		        
		        
		        
		    });
		  
		  
		  
		  
		  $("#cartCount").change(function(){
			  
				  $(this).removeClass("fail");
				  $(".form-input").removeClass("fail")
				  $(".fail3-feedback").css("display", "none");
				  $(".fail-feedback").css("display", "none");
					$(".fail2-feedback").css("display", "none");
			  	var optionSelect = $("#optionSelect");
				var selectedOption = optionSelect.find(":selected");
				var stock = selectedOption.data("stock");
			  
			  if($(this).val()>stock){
	 				
				  $(this).addClass("fail");
				  $(".fail3-feedback").css("display", "block");
				  
			  }
				
				
			  
			  
			  
		  })
		  
		  
		
		

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
			
			$("#cartCount").removeClass("fail");
			
			var a = $(".hiddenSelect").val() == null;
			
			$("#cartCount").attr("type", "text");
			
			if ($(".hiddenSelect").val() == null) {
				$("#cartCount").removeClass("fail");
				$(".fail3-feedback").css("display", "none");
				$("#cartCount").val("1");
				$(".fail2-feedback").css("display", "block");
				e.preventDefault();
			} 
		
			else if ($(this).val() == "cart") {
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
			 $(".form-input").removeClass("fail")
			$("#cartCount").removeClass("fail");
			$(".fail3-feedback").css("display", "none");
			$(".fail-feedback").css("display", "none");
			$(".fail2-feedback").css("display", "none");
			$("#cartCount").val("1");  

			 var index = $(this).data("index") - 1;
			  var removedOptionNo = $("[name='cartList[" + index + "].optionNo']").val();
			  var removedCount = $("[name='cartList[" + index + "].cartCount']").val();
			  
			  var selectedOption = $("#optionSelect option[value='" + removedOptionNo + "']");
			  var currentStock = selectedOption.data("stock");

			  selectedOption.removeData("stock").data("stock", currentStock + parseInt(removedCount));

			  $(this).closest(".optionList").remove();

			$("[name='cartList[" + index + "].optionNo']").remove();
			$("[name='cartList[" + index + "].cartCount']").remove();
			
			count--;
			
			


		});

	});
</script>
<script>
	//등급별 가격 찍어주는 스크립트
	$(function() {
		$(".price-by-level").hide();

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

		$(".price-btn").hover(function(e) {
			$(".gold").text("골드 : " + goldPrice + "원");
			$(".silver").text("실버 : " + silverPrice + "원");
			$(".bronze").text("브론즈 : " + bronzePrice + "원");
			$(".price-by-level").show();
		});

		$(".price-btn").mouseleave(function() {
			$(".price-by-level").hide();
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
.price-by-level,
.price-btn {
	background-color: white;
	border: 2px solid #BEADFA;
	border-radius: 0.3em;
	padding: 5px;
}



</style>

<input id="memberLevel" type="hidden" value="${sessionScope.level}">


<div class="container w-900">
	<div class="flex-container">
		<div class="col-2">
			<div class="row">
				<img
					src="/cuddly/image/product/main?productNo=${productDto.productNo}"
					width="100%" height="100%" class="image image-round">
			</div>
		</div>

		<div class="col-2">
			<div class="row left">
				<h1 class="ms-20 mt-10">${productDto.productName}</h1>
			</div>
			<div class="row left">
				<label style="font-size: 20px;" class="ms-20">${creatorName}</label>
			</div>

			<div class="float-container">
				<div class="row float-left">
					<h2 class="price ms-20" data-price="${productDto.productPrice}">가격</h2>
				</div>
				<div class="row float-right">
					<label class="price-btn">등급별 가격 확인</label>
				</div>
			</div>

			<div class="price-by-level m-10">
				<div class="row left">
					<label class="level gold etcFontSize">골드</label>
				</div>
				<div class="row left">
					<label class="level silver etcFontSize">실버</label>
				</div>
				<div class="row left">
					<label class="level bronze etcFontSize">브론즈</label>
				</div>
			</div>
			
			<hr class="w-95 right">

			<div class="row left">
				<i class="fa-solid fa-heart red ms-20"></i> <span>좋아요 개수</span>
			</div>
			<div class="row left">
				<span class="ms-20">등록일 : ${productDto.productDate}</span>
			</div>
			<div class="row left">
				<span class="ms-20"><i class="fa-solid fa-star yellow"></i> <fmt:formatNumber value="${reviewAvg}" pattern="0.0"/></span>
			</div>
			
			<hr class="w-95 right">
			
				<form id="orderForm" action="/cuddly/orders/cartInsert">
					<input type="hidden" name="productNo" value="${productDto.productNo}">
					<div class="row">
						<select id="optionSelect" class="form-input find-input ms-20" style="width:430px">
							<option>  옵션 선택</option>
							<c:forEach var="optionList" items="${optionList}">
								<option class="select" value="${optionList.productOptionNo}" data-stock="${optionList.productOptionStock }">
									<c:choose>
									<c:when test="${optionList.productOptionStock<=0}">
									${optionList.productOptionName}<span> (품절)</span>
									</c:when>
									<c:otherwise>
									${optionList.productOptionName}
									</c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
						<div class="fail-feedback left ms-40 mt-5">옵션을 선택하세요</div>
					</div>
					
					<div class="row flex-container left">
						<input type="number" min="1" id="cartCount"
							class="cartCount form-input find-input w-50 ms-20 center" value="1">
						<button class="btn btn-more w-100 ms-10" type="button" onclick="addSelectedOption();"
							name="add">옵션추가</button>
					</div>
						<div class="fail3-feedback left ms-40" style="display: none; color:#d63031">선택할 수 있는 수량을 넘었습니다.</div>	
					
						<div id="selectedOptions" class="left ms-20"></div>
						
					<div class="fail2-feedback">옵션을 최소 하나이상 추가해주세요</div>
					
					<hr class="w-95 right">
					
					<div class="row">
						<button class="btn btn-positive w-95 ms-20" name="action" value="order"
							type="submit">주문</button>
					</div>
					<div class="row">
						<button class="btn btn-positive btn-cart w-95 ms-20" name="action"
							value="cart" type="submit">장바구니</button>
					</div>
				</form>
		</div>
	</div>


	<div id="productDetail"
		class="flex-container form-input form-underline underline-input mt-30">
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
		<h2 class="mt-30">리뷰</h2>
	</div>
	<div class="flex-container form-input form-underline underline-input mb-10">

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
		<div class="flex-container card mb-10">
			<div class="w-80 mh-10 mb-10">
				<div class="float-container">
					<div class="float-left productName mv-10">${productDto.productName}</div>
					<div class="float-right mv-10">${reviewListDto.reviewDate}</div>
				</div>
				<div class="float-container">
					<div class="float-left mv-10">${reviewListDto.memberId}</div>
					<div class="float-right mv-10"><span class="star-rating">
                        <c:forEach var="i" begin="1" end="${reviewListDto.reviewGrade}">
                            <i class="fas fa-star yellow"></i>
                        </c:forEach>
                        <c:forEach var="i" begin="1" end="${5-reviewListDto.reviewGrade}">
                        	<i class="far fa-star yellow"></i>
                        </c:forEach>
                    </span></div>
				</div>
				
				<div class="row left">${reviewListDto.reviewContent}</div>
				 <c:if test="${reviewListDto.memberId == sessionScope.name}">
				<div class="row left">
					<a href="/cuddly/review/edit?reviewNo=${reviewListDto.reviewNo}" class="btn btn-positive btn-small">수정하기</a>
					<a href="/cuddly/review/delete?reviewNo=${reviewListDto.reviewNo}" class="btn btn-negative btn-small">삭제하기</a>
				</div>
			</c:if>
			</div>
			<div class="w-20 me-10 mb-10">
				<img
					src="/cuddly/image/review/image?reviewNo=${reviewListDto.reviewNo}"
					onerror="this.style.display='none'" alt=''
					width="150px" height="150px" class="image image-round">
			</div>
		</div>
	</c:forEach>

	

	<div class="flex-container form-input form-underline underline-input mb-10">
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
	
	<div class="float-container">
		<div class="float-left" id="qnaList">
			<h2 class="mt-30">Q&A</h2>
		</div>
		<c:if test="${sessionScope.name != null}">
			<div class="float-right">
				<button type="button" class="btn btn-positive qna-write mt-20">문의하기</button>
			</div>
		</c:if>
	</div>

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
	
	<div class="row">
		<table class="table table-slit table-hover">
			<thead>
				<tr>
					<th width="15%">답변상태</th>
					<th>문의내용</th>
					<th width="15%">작성자</th>
					<th width="15%">작성일</th>
				</tr>
			</thead>
			<tbody>
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
						<td class="left">${qnaListDto.qnaContent}</td>
						<td>${qnaListDto.memberId}</td>
						<td>${qnaListDto.qnaDate}</td>
					</tr>
					<c:if test="${qnaListDto.qnaAnswer!=null}">
						<tr class="qna-answer">
							<td colspan="4" class="left" style="padding-left:150px">${qnaListDto.qnaAnswer}</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>