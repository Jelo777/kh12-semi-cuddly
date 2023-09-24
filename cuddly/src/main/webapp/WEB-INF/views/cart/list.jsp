<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 목록</title>
</head>
<body>

<script>
$(function(){
    //전체선택과 개별체크박스에 대한 이벤트 구현

    //전체선택
    $(".check-all").change(function(){  //모두선택이 체크박스가 변하면
        var check = $(this).prop("checked");    //모두선택이 체크된 상태일 때 true 아니면 false
        $(".check-all, .check-item").prop("checked", check);    //다른 체크박스들을 모두선택 체크박스의 상태로 바꿔라
        recalculateTotal();
    });

    //개별체크박스
    $(".check-item").change(function(){
        //var allCheck = 개별체크박스개수 == 체크된개별체크박스개수;
        //var allCheck = $(".check-item").length == $(".check-item:checked").length;
        var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;
        //$(".check-item").filter(":checked").length 는 $(".check-item")중에서 checked상태인 것만 필터링 하는 것.
        $(".check-all").prop("checked", allCheck);
        
        recalculateTotal();      
    });
    
    function recalculateTotal() {
        var total = 0;

        $(".check-item:checked").each(function() {
            var price = $(this).closest(".row").find(".price").data("cart-price");
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
</div>
	<form action="insert" method="get">
        <c:forEach items="${cartList}" var="cart">
        <div class="row">
            <a href="/cuddly/product/detail?productNo=${cart.productNo}"><img src="/cuddly/image/product/main?productNo=${cart.productNo}" width="200" height="200"></a>
            	상품명 : ${cart.productName}
            	크리에이터 : ${cart.creatorName}
            	옵션 : ${cart.productOptionName}
               수량: ${cart.cartCount}
               가격 : <label class="price" data-cart-price="${cart.cartPrice}">${cart.cartPrice}</label>
               추가 날짜 : ${cart.cartDate}	<br><br>
              추가하기 <input type="checkbox" name="cartNo" value="${cart.cartNo}" class="check-item">
               <hr>
               </div>
        </c:forEach>
        
        <div class="row">총 가격:<label class="total">0</label>원</div>
       <button type="submit">주문하기</button>
        </form>
    
</body>
</html>
