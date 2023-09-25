<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/address.js"></script>
<script src="/js/addressMypageInsert.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		$(".checkbox").change(function(){
			if($(this).prop("checked")){
				$("[name=addressDefault]").prop("value","Y");
			}
			else{
				$("[name=addressDefault]").prop("value","N");
			}
		});
	});
</script>
<form action=" update" method="post" class="address-edit-form edit-container" autocomplete="off">






	        <div class="container w-400">
	
	            <div class="row">
	                <h1>배송지 수정</h1>
	            </div>
				
				<div class="row">
					<input type="hidden" name="addressNo" value="${addressDto.addressNo}">
				</div>
	
	            <div class="row">
	                <input type="text" class="form-input w-100" name="addressName"  value="${addressDto.addressName}" 
	                        placeholder="수령인">
	                <div class="fail-feedback">이름 형식이 올바르지 않습니다</div>
	            </div>
	
	            <div class="row">
	                <input type="text" class="form-input w-100" name="addressContact" value="${addressDto.addressContact}" 
	                        placeholder="전화번호">
	                <div class="fail-feedback">전화번호 형식이 올바르지 않습니다</div>
	            </div>
	
	            <div class="row left">
	                <input type="text" class="form-input post-search" name="addressPost" value="${addressDto.addressPost}" 
	                        placeholder="우편번호" size="6" maxlength="6" readonly>
	                <button type="button" class="btn post-search">
	                    <i class="fa-solid fa-magnifying-glass"></i>
	                </button>
	                <input type="text" class="form-input w-100 mt-10 post-search" 
	                         name="addressAddr1" placeholder="기본주소"  value="${addressDto.addressAddr1}" readonly>
	                
	                <input type="text" class="form-input w-100 mt-10" 
	                        name="addressAddr2" placeholder="상세주소" value="${addressDto.addressAddr2}">
	                <div class="fail-feedback">모든 주소를 작성하세요</div>
	            </div>	
				<div>
					<label>기본배송지로 설정</label><input class="checkbox" type="checkbox" name="addressCheck" checked>
					<input type="hidden" name="addressDefault" value="Y">
				</div>
				
		
	            <div class="row">
	                <button type="submit" class="btn btn-positive w-100">수정</button>
	                <a href="/cuddly/address/list"><button type="button" class="btn btn-negative w-100 btn-cancel">취소</button></a>
	            </div>
	        </div>

    	</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>