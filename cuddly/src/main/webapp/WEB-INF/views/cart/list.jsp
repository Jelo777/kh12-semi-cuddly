<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>

</style>
<body>



	<script>
		$(function() {
			//전체선택과 개별체크박스에 대한 이벤트 구현
			
			
			
			$(".btn").click(function(e){
				
				if($("input[type=checkbox]:checked").length==0){
					
					e.preventDefault();
					$(".fail-feedback").css("display","block")
					
					
				}
					
				
			
				else if($(this).val()=="delete"){
					 // 현재 폼의 action을 변경
				    $(this).closest("form").attr("action", "/cuddly/orders/delete");

				    // 폼을 제출
				    $(this).closest("form").submit();
				
					
				}
				
				
			})
			
			//재고가 0인 상품 주문 막기
// 		$(".order").click(function (e) {
			
			
//     var allValid = true; // 모든 선택된 항목이 초기에는 유효하다고 가정합니다
    
//     // 선택된 체크박스 요소를 순회합니다
//     $(".check-item:checked").each(function (index) {
//         var stock = parseInt($(this).closest(".row").find(".stock").data("stock")); // 재고를 가져옵니다
//         var count = parseInt($(this).closest(".row").find(".count").data("count")); // 카운트를 가져옵니다

//         // 현재 선택된 항목에 대해 재고가 카운트보다 적은지 확인합니다
//         if (stock < count) {
//             allValid = false; // 하나 이상의 선택된 항목이 유효하지 않음을 나타냅니다
//             return false; // 루프를 조기에 종료합니다
//         }
//     });

//     // 적어도 하나의 선택된 항목이 유효하지 않은 경우 기본 동작(예: 폼 제출)을 방지합니다
//     if (!allValid) {
//         e.preventDefault();
//         $(".fail2-feedback").css("display","block")
//     }
// });

			
			
			
			

			//전체선택
			$(".check-all").change(function() { //모두선택이 체크박스가 변하면
				$(".fail2-feedback").css("display","none")
				var check = $(this).prop("checked"); //모두선택이 체크된 상태일 때 true 아니면 false
				$(".check-all, .check-item").prop("checked", check); //다른 체크박스들을 모두선택 체크박스의 상태로 바꿔라
				recalculateTotal();
			});

			//개별체크박스
			$(".check-item").change(
					function() {
						$(".fail-feedback").css("display","none")
						$(".fail2-feedback").css("display","none")
						//var allCheck = 개별체크박스개수 == 체크된개별체크박스개수;
						//var allCheck = $(".check-item").length == $(".check-item:checked").length;
						var allCheck = $(".check-item").length == $(
								".check-item").filter(":checked").length;
						//$(".check-item").filter(":checked").length 는 $(".check-item")중에서 checked상태인 것만 필터링 하는 것.
						$(".check-all").prop("checked", allCheck);

						recalculateTotal();
					});

			function recalculateTotal() {
				var total = 0;

				$(".check-item:checked").each(
						function() {
							var price = $(this).closest(".row").find(".price")
									.data("cart-price");
							//각 항목에 대한 가격을 개별적으로 적용하려면 루프 내에서 현재 항목을 기준으로 DOM을 탐색하여 
							//해당 항목과 관련된 가격을 선택해야 하기 때문에 (this) 사용
							total += price;
						});

				$(".total").text(total);
			}

		});
	</script>






<div class="container w-600">
	<div class="row">
		<h1  class="mv-30">장바구니 목록</h1>
	</div>
	
	<div id="selectAllDiv" class="left">
		<input type="checkbox" class="check-all">모두 선택

			<form action="insert" method="get">
				<c:forEach items="${cartList}" var="cart">
					<div class="row">
						<div class="flex-container card">
							<div class="w-5">
								<input type="checkbox" name="cartNo"
										value="${cart.cartNo}" class="check-item">
							</div>
							<div class="w-25 flex-container align-center">
								<a href="/cuddly/product/detail?productNo=${cart.productNo}">
									<img src="/cuddly/image/product/main?productNo=${cart.productNo}"
													width="150" height="150" class="image image-round">
								</a>
								
							</div>
							<div class="w-75">
								<div class="row left title"> 
									<span class="ms-10">상품명 : ${cart.productName}</span>
								</div>
								<div class="row flex-container auto-width">
									<div class="left felx-container">
										<span class="ms-10">크리에이터 : ${cart.creatorName}</span>
									</div>
									<div class="right count" data-count="${cart.cartCount}">
										<span class="me-10">옵션 : ${cart.productOptionName} / 수량: ${cart.cartCount}</span>
									</div>
								</div>
								<div class="row left">
									<span class="ms-10">가격 : <label class="price" data-cart-price="${cart.cartPrice}">
											<fmt:formatNumber value="${cart.cartPrice}" pattern="#,###원" /></label></span>
								</div>
								<div class="row right">
									<span class="me-10">추가 날짜 : ${cart.cartDate}</span>
								</div>
								<div class="row right stock" data-stock="${cart.productOptionStock}"></div>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="row">
					<h1 class="right">총 가격:<label class="total">0</label>원</h1>
				</div>
	
				<h3 class="row left fail-feedback">선택된 상품이 없습니다.</h3>
				<h3 class="row left fail2-feedback">주문하시려는 상품의 재고를 확인해주세요</h3>
	
				<div class="row">
					<button class="btn btn-negative" value="delete">선택삭제</button>
					<button type="submit" class="btn order btn-positive">주문하기</button>
				</div>
			</form>
	</div>
</div>

	<div class="row page-navigator mv-30">
    <!-- 이전 버튼 -->
    <c:if test="${!vo.first}">
        <a href="/cuddly/orders/cartList?${vo.getPrevQueryString()}"> <i
            class="fa-solid fa-angle-left"></i>
        </a>
    </c:if>

    <!-- 숫자 버튼 -->
    <c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
        <c:choose>
            <c:when test="${vo.page == i}">
                <a class="on">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="/cuddly/orders/cartList?${vo.getQueryString(i)}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 버튼 -->
    <c:if test="${!vo.last}">
        <a href="/cuddly/orders/cartList?${vo.getNextQueryString()}"> <i
            class="fa-solid fa-angle-right"></i>
        </a>
    </c:if>
</div>



</body>
</html>
