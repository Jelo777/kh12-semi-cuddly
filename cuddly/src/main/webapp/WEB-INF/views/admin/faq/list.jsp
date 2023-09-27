<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>


<!-- javascript 작성 공간 -->
<script>
    $(function(){
        //전체선택과 개별체크박스에 대한 이벤트 구현
        $(".delete-btn").hide();

        //전체선택
        $(".check-all").change(function(){
            var check = $(this).prop("checked");
            $(".check-all, .check-item").prop("checked", check);
            
            if(check) {
            	//$(".delete-btn").css("display", "inline-block");
            	//$(".delete-btn").show();
	           	$(".delete-btn").fadeIn("fast");
            	//$(".delete-btn").slideDown();
            }
            else {
            	//$(".delete-btn").css("display", "none");
            	//$(".delete-btn").hide();
            	$(".delete-btn").fadeOut("fast");
            	//$(".delete-btn").slideUp();
            }
        });

        //개별체크박스
        $(".check-item").change(function(){
            //var allCheck = 개별체크박스개수 == 체크된개별체크박스개수;
            //var allCheck = $(".check-item").length == $(".check-item:checked").length;
            var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;
            $(".check-all").prop("checked", allCheck);
            
            if($(".check-item").filter(":checked").length > 0) {
            	$(".delete-btn").fadeIn("fast");
            }
            else {
            	$(".delete-btn").fadeOut("fast");
            }
        });
        
        $(".delete-form").submit(function(e){
        	return confirm("정말 삭제하시겠습니까?");
        });
    });
</script>
	
	

	<div class="row">
		<h2>FAQ관리</h2>
	</div>
	
	
<!-- 폼 시작 -->
	<form class="delete-form" action="deleteByAdmin" method="post">
	
	<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
	<c:if test="${sessionScope.name != null}">
	<div class="row right">
		<c:if test="${sessionScope.level == '관리자'}">
		<button type="submit" class="btn btn-negative delete-btn">
			<i class="fa-solid fa-trash"></i>
			일괄삭제
		</button>
		</c:if>
	


	<div class="row right">
		<a href="write" class="btn">
			<i class="fa-solid fa-write"></i>
			작성하기 
		</a>
		</div>
			</c:if>
		
	<form action="list" method="post" autocomplete="off">
		<div class="row">
		
		
	
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
				<th>no</th>
				<th>title</th>
				<th>content</th>
				<th>writer</th>
				<th>date</th>
				<th>category</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="faqDto" items="${list}">
					<tr>
					<c:if test="${sessionScope.level == '관리자'}">
					<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="boardNoList" value="${faqDto.faqNo}">
					</td>
					</c:if>
					
					
					
			<td>${faqDto.faqNo}</td>
			<td align="left">
			
			
			
				<!-- 제목을 누르면 상세페이지로 이동 -->
				<a class="link" href="detail?faqNo=${faqDto.faqNo}">
					${faqDto.faqTitle}
				</a>
			</td>
		
			<td>${faqDto.faqId}</td>
			<td>${faqDto.faqDate}</td>
			<td>${faqDto.faqCategory}</td>
						
							
					</tr>
				</c:forEach>
			</tbody>
	
		</table>
	</div>
	
</div>

<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
		<a href="list?${vo.prevQueryString}"> <i
			class="fa-solid fa-angle-left"></i>
		</a>
	</c:if>

	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		<c:choose>
			<c:when test="${vo.page == i}">
				<a class="on">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.getQueryString(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
		<a href="list?${vo.nextQueryString}"> <i
			class="fa-solid fa-angle-right"></i>
		</a>
	</c:if>
</div>








<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>