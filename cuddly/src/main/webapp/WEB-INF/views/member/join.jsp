<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/js/memberJoin.js"></script>

<form class="join-form" action="join" method="post" autocomplete="off">
	<div class="container form-border mt-30">
        <div class="center w-400">

            <div class="row">
				<img src="/images/cuddlys.png" class="mt-40">
			</div>
            
            <div class="row left">
                <label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
                <input type = "text" name="memberId" placeholder="영문 소문자, 숫자 5~15자" 
                        class="form-input underline-input w-100 member-input">
                <div class="success-feedback">멋진 아이디입니다!</div>
                <div class="fail-feedback">아이디를 형식에 맞게 입력하세요</div>
                <div class="fail2-feedback">이미 사용중인 아이디입니다</div>
            </div>
            <div class="row left">
                <label>이름<i class="fa-solid fa-asterisk red"></i></label>
                <input type = "text" name="memberName" placeholder="한글 2~7자" 
                        class="form-input underline-input w-100 member-input">
                <div class="success-feedback">형식에 맞게 잘 지었네요</div>
                <div class="fail-feedback">이름 형식에 맞게 지어요</div>
            </div>
            <div class="row left">
                <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" name="memberPw" 
                        placeholder="영문,숫자,특수문자 반드시 1개 이상 포함"
                        class="form-input underline-input w-100 member-input">
                <div class="success-feedback">올바른 비밀번호 형식입니다</div>
                <div class="fail-feedback">잘못된 비밀번호 형식입니다</div>
            </div>
            <div class="row left">
                <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
                <input type="password" id="password-check" placeholder="비밀번호 한 번 더 입력" 
                		class="form-input underline-input w-100 member-input">
                <div class="success-feedback">비밀번호가 일치합니다</div>
                <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
                <div class="fail2-feedback">비밀번호를 먼저 작성하세요</div>
            </div>
            <div class="row left">
                <label>연락처</label>
                <input type="tel" name="memberContact" placeholder="010XXXXXXXX (- 없이)"
                        class="form-input underline-input w-100 member-input">
                <div class="fail-feedback">전화번호 형식이 올바르지 않습니다</div>
            </div>
            <div class="row left">
            <label>이메일</label>
            <input type="text" name="memberEmail" placeholder="test@kh.com" 
            				class="form-input underline-input w-100 member-input">
            <div class="fail-feedback">이메일 형식이 잘못되었습니다</div>
            <div class="fail2-feedback">이미 이 이메일로 아이디를 만드셨습니다</div>
            
            </div>
            
            <div class="row flex-container">
            	<div class="w-50">
		       	<button type="button" class="btn btn-send btn-positive">
			        <i class="fa-solid fa-spinner fa-spin"></i>
			        <span>인증번호 보내기</span>
		    	</button>
		        </div>
		        
	            <div class="cert-wrapper right">
			        <input type="text" class="form-input underline-input member-input cert-input w-50">
			        <button type="button" class="btn btn-cert btn-positive">확인</button>
			        
			        <div class="fail2-feedback">인증번호를 입력해주세요</div>
			        <div class="fail-feedback">인증번호 잘못입력하셨습니다</div>
			        <div class="success-feedback">성공!</div>
	    		</div>
            </div>
            <div class="row left">
                <label>생년월일</label>
                <input type="date" name="memberBirth" class="form-input underline-input member-input w-100">
                <div class="fail-feedback">잘못된 날짜를 선택하셨습니다</div>
            </div>
            <div class="row">
                <button type="submit" class="btn btn-positive w-100 mb-40" name="join">가입하기</button>
            </div>
        </div>
	</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>