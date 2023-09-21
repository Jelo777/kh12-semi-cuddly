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

	<div class="container w-500">
		
		<c:forEach var="addressDto" items="list">
		
			<div class="flex container card mt-50">
			
			<h1>하위</h1>
			
			
			</div>
			
		</c:forEach>
		
	</div>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>