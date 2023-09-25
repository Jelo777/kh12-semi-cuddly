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
        alert("옵션과 수량을 선택하세요.");
        return;
    }

    
    var selectedCount = cartCount.val();
    if (isNaN(selectedCount) || selectedCount === "") {
        alert("수량을 숫자로 입력하세요.");
        return;
    }

    
    var selectedOptionText = optionSelect.find(":selected").text();
    var selectedOptionDiv = $("<div></div>");
    selectedOptionDiv.text("선택한 옵션: " + selectedOptionText + ", 수량: " + selectedCount);
    selectedOptions.append(selectedOptionDiv);

    count++;
    
    console.log(count);
    
	
	for(var i=0; i<count; i++){   
    
    var hiddenInput = document.createElement("input");
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
    cartCount.val("");
}






    $(function(){
        var params = new URLSearchParams(location.search);
        var productNo = params.get("productNo");

        $.ajax({
            url:"/cuddly/rest/wishlist/check",
            method:"post",
            data:{productNo:productNo},
            success:function(response){
                if(response.check==true){
                    $(".fa-heart").removeClass("fa-solid fa-regular")
                    .addClass("fa-solid");
                }
                else{
                    $(".fa-heart").removeClass("fa-solid fa-regular")
                    .addClass("fa-regular");
                }
                //전달받은 좋아요 개수를 하트뒤의 span에 출력
                $(".fa-heart").next("span").text(response.count);
            }
        });

        $(".fa-heart").click(function(){
            $.ajax({
                url:"/cuddly/rest/wishlist/action",
                method:"post",
                data:{productNo:productNo},
                success:function(response){
                    if(response.check==true){
                        $(".fa-heart").removeClass("fa-solid fa-regular")
                        .addClass("fa-solid");
                    }
                    else{
                        $(".fa-heart").removeClass("fa-solid fa-regular")
                        .addClass("fa-regular");
                    }
                    //전달받은 좋아요 개수를 하트뒤의 span에 출력
                    $(".fa-heart").next("span").text(response.count);
                }
            });
        });
        
    
       	
       
            $(".btn.btn-cart").click(function(e){
            	
                var userConfirmed = confirm("장바구니로 이동하시겠습니까?");
                
                if (!userConfirmed) {
	
                e.preventDefault();
                
                } 
           
        });

        
       	
       	
       });
        
        
        
        

        
       
    
    
    
    

</script>



<div class="container w-1000">
	
	<div class="row">
		<img src="/cuddly/image/product/main?productNo=${productDto.productNo}" width="200" height="200">
	</div>
	<div class="row">
		<h2>${productDto.productName}</h2>
		상품번호 : ${productDto.productNo}
	</div>
	<div class="row">
		<i class="fa-solid fa-heart red"></i> 
		<span>좋아요 개수</span>
	</div>
	<div class="row">
		<h2>가격 : ${productDto.productPrice}</h2>
	</div>
	<div class="row">
		등록일 : ${productDto.productDate}
	</div>
	<div class="row">
		평점 : ${reviewAvg}
	</div>
	<div class="row">
		${creatorName}
	</div>
	<div class="row">
		<form id="orderForm" action="/cuddly/orders/cartInsert">
		    <input type="hidden" name="productNo" value="${productDto.productNo}">
		    
		    <select id="optionSelect" class="form-input">
		        <option>옵션 선택</option>
		        <c:forEach var="optionList" items="${optionList}">
	<option class="select" value="${optionList.productOptionNo}">${optionList.productOptionName}</option>
		        </c:forEach>
		    </select>
		    
		    <div class="row">
		        수량<input id="cartCount" class="cartCount">
		    </div>
		    
		    <div class="row">
		        <button class="btn" type="button" onclick="addSelectedOption();">옵션 선택</button>
		    </div>
		     <div class="row"><button class="btn" type="submit" name="action" value="order">주문</button>
		    <a href="/cuddly/orders/cartList?memberId=${sessionScope.name}">
    	<button class="btn btn-cart" type="submit" name="action" value="cart">장바구니</button>
			</a></div>
 
		       
		</form>

		<div id="selectedOptions"></div>
	</div>
	<div class="row">
		디테일이미지
		<img src="/cuddly/image/product/detail?productNo=${productDto.productNo}" width="200" height="200">
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
