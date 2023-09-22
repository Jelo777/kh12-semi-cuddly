<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<style>
	.card{
            /* border:1px solid; */
            box-shadow: 0 0 0 1px #2d3436;
	}
</style>




	<div class="container w-700">
		
		<c:forEach var="addressDto" items="${list}">
			<div class="flex-container card mt-50">
				<div class="w-75 mt-20">
					<div class="row left ms-30">
						<h1>${addressDto.addressName}
							<c:if test="${addressDto.addressDefault =='Y'}">
							(기본배송지)
							</c:if>
						</h1>
					</div>
					<div class="row left ms-30">
						<h5>${addressDto.addressPost}/${addressDto.addressAddr1}/${addressDto.addressAddr2}</h5>
					</div>  
					<div class="row left ms-30">
						<h5>${addressDto.addressContact}</h5>
					</div>
					<div class="row left ms-30">
						<h5>${addressDto.addressComent}</h5>
					</div>
				</div>
				<div class="w-25 mt-20">
					<div class="row right me-30">
						<h5>
						<a  href="#">
							<button type ="button"  style="width:150px; font-size:16px;"class="btn btn-positive">수정하기</button>
						</a>
						</h5>	
					</div>
				</div>
			
			</div>
		</c:forEach>
			
			<div class="row">
					<button type ="button"  class="btn btn-positive w-300 insert-address">등록하러 가기</button>
			</div>
			
	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>