<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faq Detail</title>
</head>
<body>
    <h1>Faq Detail</h1>
    
        <table border="1" width="1000">
        	<thead>
           	 <tr>
                <th width="10%">no </th>
                <th width="10%">category </th>
                <th width="10%">title </th>
                <th width="20%">content </th>
                <th width="10%">date </th>
             </tr>
                
                <td>${faqDto.faqNo}</td>
                <td>${faqDto.faqCategory}</td>
                <td>${faqDto.faqTitle}</td>
                <td>${faqDto.faqContent}</td>
                <td>${faqDto.faqDate}</td>
        </table>
        
        
   
    <c:if test="${not empty idDto}">
        <h2>Author Information</h2>
        <table border="1">
            <tr>
                <th>Member ID</th>
                <td>${idDto.memberId}</td>
            </tr>
            <tr>
                <th>Member Name</th>
                <td>${idDto.memberName}</td>
            </tr>
            <tr>
                <th>Member Contact</th>
                <td>${idDto.memberContact}</td>
            </tr>
            <tr>
                <th>Member Email</th>
                <td>${idDto.memberEmail}</td>
             
            </tr>
        </table>
    </c:if>
    
 
</body>
</html>
