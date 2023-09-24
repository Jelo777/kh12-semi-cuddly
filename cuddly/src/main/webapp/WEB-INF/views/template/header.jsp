<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CUDDLY</title>

<!-- favicon 설정 -->
<link rel="shortcut icon" href="/images/favicon.ico">

<!-- css 파일을 불러오는 코드 -->
<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/layout.css">
<link rel="stylesheet" type="text/css" href="/css/commons.css">

<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->


<style>
	hr{
	background:#F3F0FE;
	height:3px;
	border:0;
	}


	.sidebar{
	
		position: absolute;
		top : 100px;
		bottom :100px;
		z-index: 99999;
		width :250px;
		height : 500px;
		background: white;
		box-shadow: 0 0 0 1px #2d3436;
		
		
	}
	#sidebar-toggle + .sidebar{
	
		display:none;
	}
	#sidebar-toggle:checked +.sidebar{
/* 		left:200px; */
		display:block;
	
	}








</style>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body class="center">
	<main>
	<header class="mt-40">
	
         	<div class="row">
        		<input type="checkbox" style="display:none;" id="sidebar-toggle">
        		<div class="sidebar">
        		<div class="row">
	            	<img src="/images/cuddlys.png" width="200" height="50"><br>
            	</div>
        			
        			<div class="row left ms-30 mt-30">
	        			<c:if test="${sessionScope.name==null}">
	        				<h5><a class="link" href="/cuddly/member/login">로그인이 필요해요!</a></h5>
	        			</c:if>
        			</div>
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        			
        		</div>
         	
         	</div>
         
            <div class="w-100 left">
                <div class="logo mt-20 ms-30">
                	<label for ="sidebar-toggle" class="sidebar-menu">
						<i class="fa-solid fa-bars fa-2x"></i>
                	</label>
                	
				</div>
            </div>
            
            <div class="w-100 center">
            	<div class="row">
            	<a href="/cuddly">
            	<img src="/images/cuddlyb.png" width="230" height="50"><br>
            	</a>
            	</div>
            	<div>
            		<form action="/cuddly/search">
						<input class="form-input" name="keyword">
						<button class="btn">검색</button>
					</form>
				</div>
            </div>
            
            <div class="w-100 right">
		        <div class="etc mt-20">
					<i class="fa-brands fa-gratipay fa-2x"></i>
					<i class="fa-solid fa-cart-shopping fa-2x"></i>
					<a class="link" href="/cuddly/member/mypage">
					<i class="fa-solid fa-circle-user fa-2x"></i>
					</a>
				</div>
            </div>
        
	</header>
	<nav>
		<ul class="menu">
			<li><a href="/cuddly/product/creator">크리에이터</a></li>
			<li><a href="#">굿즈</a></li>
			<li><a href="#">문구</a></li>
			<li><a href="#">엑세서리</a></li>
			
			<%-- 관리자인 경우 추가 메뉴 출력 --%>
			<c:if test="${sessionScope.level == '관리자'}">
				<li><a href="/cuddly/admin/home">관리자메뉴</a></li>
			</c:if>
		</ul>
	</nav>
	
	<hr>
	<section>