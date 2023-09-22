<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
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
	
	<form action="cartInsert">
	
	<input type="hidden" name = "productNo" value="${productDto.productNo}">
	
		<select name="optionNo" class="form-input">
			<option>옵션 선택</option>
			<c:forEach var="optionList" items="${optionList}">
			<option value="${optionList.productOptionNo}">${optionList.productOptionName}</option>
			</c:forEach>
		</select>
		
		<div class="row">
		수량<input name="cartCount">
		</div>
		
		<div class="row">
		<button class="btn" type="submit">옵션 선택</button>
		</div>
		
		
		</form>
	</div>
	<div class="row">
		디테일이미지
		<img src="/cuddly/image/product/detail?productNo=${productDto.productNo}" width="200" height="200">
	</div>
</div>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>