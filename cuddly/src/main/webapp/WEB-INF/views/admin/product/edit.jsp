<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/js/adminOptionCount.js"></script>

<form action="edit" method="post" enctype="multipart/form-data">
	<div class="container w-600">
		<div class="row">
			<h1>${productDto.productName} 수정</h1>
		</div>
		
		<div class="row">
			<img src="/cuddly/admin/image?productNo=${productDto.productNo}" width="200" height="200"><br><br>
		</div>
		
		<div class="row">
			<h3>${productDto.productName}</h3><br>
			<h3>${creatorDto.creatorName}</h3><br>
			<h3>${productDto.productPrice}</h3><br>
		</div> 
		
		<div class="flex-container w-500">
        	<div class="w-100 left">
            	<select class="form-input w-100">
                	<option>옵션선택</option>
            	</select>
        	</div>
        	
        	<div class="w-100 right">
            	<button type="button" class="editMinus">-</button>
            	<input type="text" class="editNumBox" min="0" value="0" size="1em">
            	<button type="button" class="editPlus">+</button>
        	</div>
        	
        	<div class="w-100 right">
            	<button class="btn btn-positive" type="button">옵션수정</button>
        	</div>	
        </div>
        
	<div class="flex-container w-500">    
        <div class="row">
            <input class="form-input" type="text" name="productOptionName" placeholder="옵션입력">
        </div>
        
        <div class="row">
            <button type="button" class="insertMinus">-</button>
            <input type="text" class="insertNumBox" name="productOptionStock" min="0" value="0" size="1em">
            <button type="button" class="insertPlus">+</button>
        </div>
        
        <div class="row">
            <button class="btn btn-positive" type="submit">옵션추가</button>
        </div>
 	</div>
		
<!-- 		<div class="row"> -->
				<input type="hidden" name="productNo" value="${productDto.productNo}">
<!-- 			<input type="text" name="productOptionName" placeholder="옵션입력"> -->
<!-- 			<input type="number" name="productOptionStock"> -->
<!-- 			<button type="submit">옵션등록</button> -->
<!-- 		</div> -->
		

	</div>
</form>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>