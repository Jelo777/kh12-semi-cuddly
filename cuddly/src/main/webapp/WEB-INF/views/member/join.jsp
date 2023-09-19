<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

 
 
 
 
 
<title>조인</title>
</head>
<body>
	<h1>조인</h1>
	
	<form action="join" method="post" autocomplete="off"><br><br>
		아이디<input type="text"  name="memberId"><br><br>
		이름<input type="text" name ="memberName"><br><br>
		비밀번호<input type="text" name="memberPw"><br><br>
		연락처<input type="text" name="memberContact"><br><br>
		이메일<input type="text"  name="memberEmail"><br><br>
		생일<input type="date" name="memberBirth"><br><br>
		<button>가입하기</button>
	
	</form>
</body>
</html>