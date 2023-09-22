<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <script>
        $(function(){
            $(".popUpOpen").click(function(e){
            	e.preventDefault();
                //모달을 보이도록 설정
                $("#modal").show();
            });
         
            //확인버튼 클릭시 모달버튼 숨김
            $(".popUpClose").click(function(){
                $("#modal").hide();
            });
            
         // 모달 확인 버튼 클릭 시 폼을 제출
            $(".popUpConfirm").click(function(){
                // 폼을 선택하고 제출
                $("form").submit();
            });
        });
    </script>
    
 <style>
        #modal.backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
        }
        .modal-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
        }
    </style>
    
<body>
	<div class="container w-600">
		<form action="insert" method="post" autocomplete="off" enctype="multipart/form-data">
		<div class="row">
			<h1>상품등록</h1>
		</div>
		<div class="row">
			<select class="form-input w-100" name="productItem">
				<option>품목선택</option>
				<option value="의류">의류</option>
				<option value="스티커/지류">스티커/지류</option>
				<option value="폰악세서리">폰악세서리</option>
				<option value="리빙">리빙</option>
				<option value="문구/오피스">문구/오피스</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<div class="row">
			<input class="form-input w-100" name="creatorName" placeholder="크리에이터 입력">
		</div>
		<div class="row">
			<input class="form-input w-100" name="productName" placeholder="상품명 입력">
		</div>
		<div class="row">
			<input class="form-input w-100" type="number" name="productPrice" placeholder="가격 입력">
		</div>
		<div class="row left">
			메인이미지
			<input class="form-input w-100" type="file" name="attachMain" accept="image/*" placeholder="대표이미지"> <br><br>
		</div>
		<div class="row left">
			상세이미지
			<input class="form-input w-100" type="file" name="attachDetail" accept="image/*" placeholder="상세이미지"> <br><br>
		</div>
		<div class="row">
			<button class="btn btn-positive w-100 popUpOpen">상품등록</button>
		</div>

	</form>
	</div>
	
	<div id="modal" class="backdrop">
        <div class="modal-container w-300">
            <div class="popUp-title">
                <i class="fa-solid fa-x popUpClose" style="float:right"></i>
                <h2 style="float:left">등록완료</h2>
            </div>
            
            <hr>
            
            <div class="popUp-content center">
                <br><br><br>
                <h4>상품등록이 완료되었습니다.</h4> 
                <br><br><br>
            </div>
            
            <div class="row">
                <button class="btn btn-positive w-100 popUpClose popUpConfirm">확인</button>
            </div>
        </div>
    </div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
