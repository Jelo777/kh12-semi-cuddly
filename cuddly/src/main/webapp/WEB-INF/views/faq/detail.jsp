<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-900">
	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<th width="15">no.${faqDto.faqNo}</th>
					<th width="15%">${faqDto.faqCategory}</th>
					<th width="55%">${faqDto.faqTitle}</th>
					<th>${faqDto.faqDate}</th>
				</tr>
			</thead>
			<tbody>
				<tr class="left">
					<td colspan="4" style="height: 400px;">
						${faqDto.faqContent}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row right">
		<a href="list" class="btn btn-positive"> <i
			class="fa-solid fa-list"></i> 목록
		</a>

		<c:if test="${sessionScope.level == '관리자'}">
			<a href="edit?faqNo=${faqDto.faqNo}" class="btn btn-positive"> <i
				class="fa-solid fa-edit"></i> 수정
			</a>
		</c:if>

		<c:if test="${sessionScope.level == '관리자'}">
			<a href="delete?faqNo=${faqDto.faqNo}" class="btn btn-positive">
				<i class="fa-solid fa-trash"></i> 삭제
			</a>
		</c:if>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>