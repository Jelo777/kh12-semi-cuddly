<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-700">
	
		<div class="float-container card mt-50">

    <div class="row">

<table class="table table-striped">
     
        

       
    </div>
    <div class="row">
     
            <thead>
                <tr>
                    <th>no</th>
                    <th>category</th>
                    <th>title</th>
                    <th>date</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${faqDto.faqNo}</td>
                    <td>${faqDto.faqCategory}</td>
                    <td>${faqDto.faqTitle}</td>
                    <td>${faqDto.faqDate}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</div>
   
<div class="container w-700">

    <div class="row left">
<div class="float-container card mt-50">
<table class="table table-striped">

            <tbody>
                <tr>

                    <td height="300">${faqDto.faqContent}</td>
                    
                </tr>
            </tbody>
        </table>
    </div>
    </div>

    	
   





    <div class="row right">


        


        <a href="list" class="btn btn-positive">
            <i class="fa-solid fa-list"></i>
            목록
        </a>
        
        <c:if test="${sessionScope.level == '관리자'}">
        <a href="edit?faqNo=${faqDto.faqNo}" class="btn btn-positive">
            <i class="fa-solid fa-edit"></i>
            수정
        </a>
        </c:if>
        
        <c:if test="${sessionScope.level == '관리자'}">
        <a href="delete?faqNo=${faqDto.faqNo}" class="btn btn-positive">
            <i class="fa-solid fa-delete"></i>
            삭제
        </a>
        </c:if>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
