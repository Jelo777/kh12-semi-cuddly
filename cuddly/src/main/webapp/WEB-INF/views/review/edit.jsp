<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

</head>
<body>

 <script>
        //목표 : 설정하기 버튼을 누르면 선택된 파일을 업로드하고 이미지 변경
        $(function(){
            $(".btn-save").click(function(e){
            	
            	e.preventDefault();

                //파일선택창을 Javascript 형태로 불러와야함(내장API 사용)
                //var input = document.querySelector(".file-chooser");
                var input = $(".file-chooser")[0];

                //input이 file일 경우에만 files라는 항목이 존재
                //console.log(input.files);
                if(input.files.length == 0) return;

                //비동기 통신
                //- form으로 파일을 전송할 때 multipart/form-data 설정을 했었다
                //- 비동기 통신일 때는 무슨 처리를 해야 하는가?
                //- processData : false로 설정
                //- contentType : false로 설정
                //- FormData 객체를 만들어 파일을 추가한 뒤 전송
                var form = new FormData();
                //form.append("이름", 데이터);
                form.append("attach", input.files[0]);

                $.ajax({
                    url:"http://localhost:8080/restfile/upload",
                    method:"post",
                    processData:false,
                    contentType:false,
                    data: form,
                    success:function(response){
                        //console.log(response);
                        //이미지의 src를 바꾸는 코드
                        $(".now").attr("src", "http://localhost:8080/restfile/download?attachNo="+response.attachNo);
                    },
                });
            });
        });        
    </script>

<div class="container w-600">
					<div class="row">
						<div class="flex-container card">
							<div class="w-25 flex-container align-center">
								<a href="/cuddly/product/detail?productNo=${productDto.productNo}">
								<img class=".now" src="/cuddly/image/product/main?productNo=${productDto.productNo}"
									width="150" height="200">
								</a>
							</div>
							<div class="w-75">
								<div class="row left title"> 상품명 : ${productDto.productName}</div>
								<div class="row left">
									가격 : <label class="price">${productDto.productPrice}</label>
								</div>
							</div>
						</div>
					</div>
</div>




<form action="edit" method="post" enctype="multipart/form-data">
<!--	리뷰 이미지 : <input type="file" name="attach" accept="image/*"><br><br>-->
	<input type="hidden" name="productNo" value="${reviewDto.productNo}">
	<input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">
	별점 : <input type="text" name="reviewGrade" value="${reviewDto.reviewGrade}"><br><br>
	리뷰 내용 : <input type="text" name="reviewContent" value="${reviewDto.reviewContent}"><br><br>
	<input type="file" class="file-chooser" name="attach" accept="image/*"><br><br>
	
	<c:choose>
	<c:when test="${reviewDto.image}">
		<img class="now" src="/cuddly/image/review/image?reviewNo=${reviewDto.reviewNo}" width="200" height="200">
	</c:when>
	<c:otherwise>
		<img class="now" src="https://dummyimage.com/50x50/000/fff">
	</c:otherwise>
	</c:choose>
	
	<br><br>
	<button class="btn-save">사진 등록</button><br><br>
	

	<button type="submit">수정하기</button>
	
	



</form>





</body>
</html>