<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<script src="/js/adminInsertOptionCount.js"></script>
<script>

var optionList = [0];

<c:forEach  var="productOptionDto" items="${list}" >
	optionList.push(${productOptionDto.productOptionStock});
</c:forEach>

function optionUpdate(){

	var formData = $("#update").serialize();
	
	$.ajax({
		url:'optionUpdate',
		mothod:'post',
		data : formData, 
        dataType: 'text',
        success: function(data){
        	if(data != 'null'){
        		alert("옵션 수정이 완료되었습니다.");
        		location.reload();
        	}
        }
	});
}

function changeOption(value){
	
	var getindex = value.selectedIndex;
	var getValue = optionList[getindex];
	
	var Myelement = document.getElementById("optionValue");
	Myelement.value = getValue;
	

}

function addOption(){
	var formData = $("#edit").serialize();
	
	$.ajax({
        url:'/cuddly/rest/admin/product/option/insert',
        method : 'POST', 
        data : formData, 
        dataType: 'text',
        success: function (data) {
        	if(data == 'null'){
        		alert("옵션명이 없습니다");
        	}
        	else if(data == 'fail'){
        		alert("이미 등록 된 옵션입니다.");
        	}
        	else{
        		alert("옵션 등록이 완료되었습니다.");
        		location.reload();
        	}
        },
        error: function (request, error) {
            alert('code:'+request.status+"msg:"+request.responseText+"error:"+error);
        }
    });    
}


</script>

		<div class="row">
			<h2 class="mv-30">${productDto.productName} 수정</h2>
		</div>

	<div class="container w-200">
		
		<div class="row">
			<img src="/cuddly/image/product/main?productNo=${productDto.productNo}" 
							width="200" height="200" class="image image-round">
		</div>
		
		<div class="row left">
			<span class="productName">${productDto.productName}</span>
		</div>
		<div class="row left">
			<span class="creatorName">${creatorDto.creatorName}</span>
		</div>	
		<div class="row left">
			<span class="productPrice">
				<fmt:formatNumber value="${productDto.productPrice}" pattern="#,###원" />
			</span>
		</div>
	</div>
	
	<div class="container w-600">	
	<form id="update" onsubmit="return false();" action="optionUpdate" method="post" enctype="multipart/form-data">
		
		<div class="flex-container">
			<input type="hidden" name="productNo" value="${productDto.productNo}">
			
        		<div class="w-60">
        	<div class="row">
            	<select name="productOptionNo" class="form-input find-input w-100" 
            					style="width:380px; padding-left:10px" onchange="changeOption(this);">
                	<option>옵션선택</option>
                	<c:forEach var="productOptionDto" items="${list}">
                			<option value="${productOptionDto.productOptionNo}">${productOptionDto.productOptionName}</option>
                	</c:forEach>
            	</select>
            	</div>
        	</div>
        	
        	<div class="w-20">
        	<div class="row">
        	<div class="count-box mh-10">
            	<button type="button" class="editMinus" style="border:none; background-color: #FFFEFC">-</button>
            		<input name="productOptionStock" id="optionValue" type="text" 
            					class="editNumBox mt-8 center" min="0" value="0" size="1em" style="border:none; background-color: #FFFEFC">
            	<button type="button" class="editPlus" style="border:none; background-color: #FFFEFC">+</button>
            	</div>
            	</div>
        	</div>
        	
        	<div class="w-20">
        	<div class="row">
            	<button class="btn btn-positive" type="submit" onclick="optionUpdate();">옵션수정</button>
            	</div>	
        	</div>	
        </div>
	</form>
	

	<form id="edit" onsubmit="return false();" autocomplete="off">
		<input type="hidden" name="productNo" value="${productDto.productNo}">
	
	<div class="flex-container">
		<div class=" w-60">
        	<div class="row">
            	<input class="form-input find-input" style="width:380px; padding-left:10px" 
            					type="text" name="productOptionName" placeholder="옵션입력">
        	</div>
      	</div>
        
        <div class="w-20">
        	
        	<div class="row">
        	<div class="count-box mh-10">
 				
            	<button type="button" class="insertMinus" style="border:none; background-color: #FFFEFC">-</button>
            		<input type="text" class="insertNumBox mt-8 center" name="productOptionStock" min="0" value="0" size="1em" style="border:none; background-color: #FFFEFC">
            	<button type="button" class="insertPlus" style="border:none; background-color: #FFFEFC">+</button>
        	</div>
        	</div>
        </div>
        
        <div class=" w-20">
        	<div class="row">
            	<button class="btn btn-positive" type="submit" onclick="addOption();" >옵션추가</button>
        	</div>
        </div>
        
 	</div>
	</form> 
	</div>


<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>