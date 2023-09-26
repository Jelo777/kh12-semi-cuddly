<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/mypageHeader.jsp"></jsp:include>
<script src="/js/memberInfoChange.js"></script>

<form class="change-form" action ="change" method="post" autocomplete="off">
        <div class="container w-400">
            
            <div class="row">
                <h1>개인정보 변경</h1>
            </div>

            <div class="row left">
                <label>연락처</label>
                <input type="tel" name="memberContact" value="${memberDto.memberContact}" placeholder="010XXXXXXXX (- 없이)"
                        class="form-input w-100">
                <div class="fail-feedback">전화번호 형식이 올바르지 않습니다</div>
            </div>

            <div class="row left">
                <label>생년월일</label>
                <input type="date" name="memberBirth" value="${memberDto.memberBirth}" 
                class="form-input w-100">
                <div class="fail-feedback">잘못된 날짜를 선택하셨습니다</div>
            </div>
            
            <div class="row left">
            	<input type="text" name="memberPw" class="form-input w-100" placeholder="비밀번호 확인">
            </div>
            <div class="row">
                <button type="submit" class="btn btn-positive w-100">변경하기</button>
            </div>


        </div>

    </form>
			<c:if test="${param.error != null}">
		        <div class="row important">
					<h3>입력하신 비밀번호가 일치하지 않습니다</h3>
				</div>
			</c:if>

<jsp:include page="/WEB-INF/views/template/mypageFooter.jsp"></jsp:include>