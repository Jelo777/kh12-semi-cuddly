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
hr {
	background: #F3F0FE;
	height: 3px;
	border: 0;
}

.sidebar {
	position: absolute;
	top: 100px;
	bottom: 100px;
	z-index: 99999;
	width: 250px;
	height: 600px;
	background: white;
	box-shadow: 0 0 0 1px #2d3436;
}

#sidebar-toggle+.sidebar {
	display: none;
}

#sidebar-toggle:checked+.sidebar {
	/* 		left:200px; */
	display: block;
}

</style>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<script>
	//x아이콘 눌렀을 때 사이드바 끄게 하기
	$(document).ready(
			function() {
				var sidebarVisible = false; // 초기에 사이드바가 숨겨진 상태

				$("#sidebar-toggle, .fa-regular.fa-circle-xmark.fa-2x").click(
						function() {
							if (sidebarVisible) {
								$(".sidebar").hide(); // 사이드바를 숨깁니다.
							} else {
								$(".sidebar").show(); // 사이드바를 표시합니다.
							}
							sidebarVisible = !sidebarVisible; // 상태를 토글합니다.
						});
			});
</script>


</head>
<body class="center">
	<main>
		<header class="mt-40">

			<div class="row">
				<input type="checkbox" style="display: none;" id="sidebar-toggle">
				<div class="sidebar">
					<div class="row right me-10">

						<a class="link" href="/cuddly/member/mypage"> 
							<i class="fa-solid fa-circle-user fa-2x"></i>
						</a> 
							<i class="fa-regular fa-circle-xmark fa-2x"></i>

					</div>
					<div class="row">
						<img src="/images/cuddlys.png" width="200" height="45">
					</div>

					<div class="row left ms-20 mt-30">
						<c:choose>
							<c:when test="${sessionScope.name==null}">
								<h3>
									<a class="link" href="/cuddly/member/login">로그인이 필요해요!</a>
								</h3>
							</c:when>
							<c:otherwise>
								<h3>${sessionScope.name}님환영해요!</h3>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="row left ms-20 mt-30">
						<h2>
							<a class="link" href="/cuddly">홈</a>
						</h2>
					</div>

					<div class="row left ms-20 mt-30">
						<h2>
							<a class="link" href="/cuddly/product/creator">크리에이터</a>
						</h2>
					</div>

					<div class="row left ms-20 mt-30">
						<h2>
							<a class="link" href="/cuddly/product/list">전체상품</a>
						</h2>
						<div class="row left">
							<h3>
                            	<a class="link" href="/cuddly/product/list?item=패션"> - 패션</a>
                            </h3>
                            <h3>
                            	<a class="link" href="/cuddly/product/list?item=문구/오피스"> - 문구/오피스</a>
                            </h3>
                            <h3>
                            	<a class="link" href="/cuddly/product/list?item=홈데코/리빙"> - 홈데코/리빙</a>
                            </h3>
                            <h3>
                            	<a class="link" href="/cuddly/product/list?item=폰악세서리"> - 폰악세서리</a>
                            </h3>
                            <h3>
                            	<a class="link" href="/cuddly/product/list?item=기타"> - 기타</a>
                            </h3>
                        </div>
					</div>

					<div class="row left ms-20 mt-30">
						<h2>
							<a class="link" href="/cuddly/review/list">리뷰</a>
						</h2>
					</div>

					<div class="row left ms-20 mt-30">
						<h2>
							<a class="link" href="/cuddly/faq/list">공지사항</a>
						</h2>
					</div>
				</div>

			</div>


			<div class="center w-20">
				<div class="logo mt-20 ms-30">
					<label for="sidebar-toggle" class="sidebar-menu">
						<i class="fa-solid fa-bars fa-2x"></i>
					</label>
				</div>
			</div>
			

			<div class="w-100 center">
				<div class="row">
					<a href="/cuddly"> 
						<img src="/images/cuddlyb.png" width="300" height="62" class="mb-20"><br>
					</a>
				</div>
				<div class="row">
					<form action="/cuddly/search">
						<input class="form-input find-input" name="keyword" placeholder="   찾으시는 상품 혹은 크리에이터를 입력하세요.">
						<button class="btn btn-positive">검색</button>
					</form>
				</div>
			</div>

			<div class="center w-20">
				<div class="etc mt-20">
					<i class="purple fa-brands fa-gratipay fa-2x"></i>
					 <a class="link" 
					 	href="/cuddly/orders/cartList?memberId=${sessionScope.name}">
					 	<i class="purple fa-solid fa-cart-shopping fa-2x"></i></a> 
						<a class="link"
						href="/cuddly/member/mypage"> 
						<i class="purple fa-solid fa-circle-user fa-2x"></i>
					</a>
				</div>
			</div>

		</header>
		<nav>
			<ul class="menu left">
				<li class="center"><a href="/cuddly/product/creator">크리에이터</a></li>
				<li class="center">
					<a href="/cuddly/product/list">전체상품</a>
					<ul>
						<li><a href="/cuddly/product/list?item=패션">패션</a></li>
						<li><a href="/cuddly/product/list?item=문구/오피스">문구/오피스</a></li>
						<li><a href="/cuddly/product/list?item=홈데코/리빙">홈데코/리빙</a></li>
						<li><a href="/cuddly/product/list?item=폰악세서리">폰악세서리</a></li>
						<li><a href="/cuddly/product/list?item=기타">기타</a></li>
					</ul>
				</li>
				<li class="center"><a href="/cuddly/review/list">리뷰</a></li>
				<li class="center"><a href="/cuddly/faq/list">FAQ</a></li>

				<%-- 관리자인 경우 추가 메뉴 출력 --%>
				<c:if test="${sessionScope.level == '관리자'}">
					<li class="menu-right">
						<a href="/cuddly/admin/product/list">관리자메뉴</a>
					</li>
				</c:if>
			</ul>
		</nav>

		<hr>
		<section>