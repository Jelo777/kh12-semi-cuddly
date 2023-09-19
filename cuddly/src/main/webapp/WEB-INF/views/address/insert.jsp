<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script>
 $(function(){
     //검색버튼, 우편번호 입력창, 기본주소 입력창을 클릭하면 검색 실행
     $(".post-search").click(function(){
         new daum.Postcode({
         oncomplete: function(data) { 
         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var addr = ''; // 주소 변수
         var extraAddr = ''; // 참고항목 변수

         //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
         if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
             addr = data.roadAddress;
         } else { // 사용자가 지번 주소를 선택했을 경우(J)
             addr = data.jibunAddress;
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         // document.querySelector("[name=memberPost]").value=data.zonecode;
         $("[name=addressPost]").val(data.zonecode);
         // document.querySelector("[name=memberAddr1]").value=addr;
         $("[name=addressAddr1]").val(addr);
         // 커서를 상세주소 필드로 이동한다.
         // document.querySelector("[name=memberAddr2]").focus();
         $("[name=addressAddr2]").focus();
     }
     }).open();
     });
 });
 
 </script>



<title>배송지 등록</title>
</head>
<body>
	<h1>배송지 등록</h1>
		<form action="insert" method="post" autocomplete="off"><br><br>
			아이디<input type="text"  name="memberId"><br><br>
			이름<input type="text" name ="addressName"><br><br>
			연락처<input type="text" name="addressContact"><br><br>
			우편번호<input type="text" name="addressPost">
			<button type="button" class="btn post-search">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button><br><br>
			기본주소<input type="text" name="addressAddr1"><br><br>
			상세주소<input type="text" name="addressAddr2"><br><br>
			요청사항<textarea name="addressComent"></textarea><br><br>
			<button>등록하기</button>
		</form>
</body>
</html>