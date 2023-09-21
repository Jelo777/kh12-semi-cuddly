<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/js/adminInsertOptionCount.js"></script>
<script>

var optionList = [0];

<c:forEach  var="productOptionDto" items="${list}" >
	optionList.push(${productOptionDto.productOptionStock});
</c:forEach>

function changeOption(value){
	
	var getindex = value.selectedIndex;
	var getValue = optionList[getindex];
	
	var Myelement = document.getElementById("optionValue");
	Myelement.value = getValue;

}

function addOption(){
	var formData = $("#edit").serialize();
	
	$.ajax({
        url:'edit',
        type : 'POST', 
        data : formData, 
        dataType: 'text',
        success: function (data) {
        	if(data == 'null'){
        		alert("옵션명이 없습니다");
        	}else if(data == 'fail'){
        		alert("이미 등록 된 옵션입니다.");
        	}else{
        		location.reload();
        	}
        },
        error: function (request, error) {
            alert('code:'+request.status+"msg:"+request.responseText+"error:"+error);
        }
    });    
}


</script>

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
		
	<form action="editUpdate" method="post" enctype="multipart/form-data">
		
		<div class="flex-container w-100">
			<input type="hidden" name="productNo" value="${productDto.productNo}">
			
        	<div class="row w-100" style="float:left">
            	<select name="productOptionNo" class="form-input w-100" onchange="changeOption(this);">
                	<option>옵션선택</option>
                	<c:forEach var="productOptionDto" items="${list}">
                			<option value="${productOptionDto.productOptionNo}">${productOptionDto.productOptionName}</option>
                	</c:forEach>
            	</select>
        	</div>
        	
        	<div class="row w-100" style="float:right">
            	<button type="button" class="editMinus">-</button>
            		<input name="productOptionStock" id="optionValue" type="text" class="editNumBox" min="0" value="0" size="1em">
            	<button type="button" class="editPlus">+</button>
        	</div>
        	
        	<div class="row w-100" style="float:right">
            	<button class="btn btn-positive" type="submit">옵션수정</button>
        	</div>	
        </div>
	</form>
	
	<form id="edit" onsubmit="return false();" autocomplete="off">
	<div class="flex-container w-100">
		<input type="hidden" name="productNo" value="${productDto.productNo}">
	
        <div class="row w-100 let">
            <input class="form-input" type="text" name="productOptionName" placeholder="옵션입력">
        </div>
        
        <div class="row w-100 right">
            <button type="button" class="insertMinus">-</button>
            <input type="text" class="insertNumBox" name="productOptionStock" min="0" value="0" size="1em">
            <button type="button" class="insertPlus">+</button>
        </div>
        
        <div class="row w-100 right">
            <button class="btn btn-positive" type="submit" onclick="addOption();" >옵션추가</button>
        </div>
 	</div>
	</form> 

	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>