<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>

	.card {
            /* border: 1px solid #2d3436; */
            box-shadow:0px 0px 0px 1px black;
            border-radius: 0.2em;
        }
        
      
        
        

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
			
			
			

			//전체선택
			$(".check-all").change(function() { //모두선택이 체크박스가 변하면
				var check = $(this).prop("checked"); //모두선택이 체크된 상태일 때 true 아니면 false
				$(".check-all, .check-item").prop("checked", check); //다른 체크박스들을 모두선택 체크박스의 상태로 바꿔라
				recalculateTotal();
			});

			//개별체크박스
			$(".check-item").change(
					function() {
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






	<h1>장바구니 목록</h1>

	<div id="selectAllDiv">
		<input type="checkbox" class="check-all">모두 선택

		<div class="container w-600">
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
									width="150" height="200">
								</a>
								
							</div>
							<div class="w-75">
								<div class="row left title"> 상품명 : ${cart.productName}</div>
								<div class="row flex-container auto-width">
								<div class="left felx-container"> 크리에이터 : ${cart.creatorName}</div>
								<div class="right">옵션 : ${cart.productOptionName} / 수량: ${cart.cartCount}</div></div>
								<div class="row left">
									가격 : <label class="price" data-cart-price="${cart.cartPrice}"><fmt:formatNumber value="${cart.cartPrice}" pattern="#,###원" /></label>
								</div>
								<div class="row right">추가 날짜 : ${cart.cartDate}</div>
								<div class="row right">
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
	<div class="row"><h1>
		총 가격:<label class="total">0</label>원</h1>
	</div>
	<h1 class="fail-feedback">
	선택된 상품이 없습니다.
	</h1>
	<button type="submit" class="btn">주문하기</button>
	<button class="btn" value="delete">선택삭제</button>
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
