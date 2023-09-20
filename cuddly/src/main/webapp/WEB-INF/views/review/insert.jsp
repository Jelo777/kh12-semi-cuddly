<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록</title>
</head>
<body>

<form action="write" method="post" enctype="multipart/form-data">

<!--	리뷰 이미지 : <input type="file" name="attach" accept="image/*"><br><br>-->
	상품 번호 : <input type="text" name="productNo"><br><br>
	별점 : <input type="text" name="reviewGrade"><br><br>
	리뷰 내용 : <input type="text" name="reviewContent"><br><br>
	회원 아이디 : <input type="text" name="memberId"><br><br>
	
	

	<button type="submit">등록</button>


</form>


</body>
</html>