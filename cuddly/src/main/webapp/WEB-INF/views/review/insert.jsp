<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    

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
            
            $(".star").click(function() {
            	
                var selectedRating = $(this).data("rating");
                $("#reviewGrade").val(selectedRating);

            	//solid/far가 채워진 거 regular/fas가 빈 거
         
                // 이전 별 아이콘들을 모두 solid로 변경
                $(".star").removeClass("fas").addClass("far");

                // 현재 별 아이콘과 그 이전 별 아이콘들을 solid로 변경
                $(this).removeClass("far").addClass("fas");
                $(this).prevAll(".star").removeClass("far").addClass("fas");
            });

            
            
        });        
    </script>

<div class="container w-600">
					<div class="row">
						<div class="flex-container card">
							<div class="w-25 flex-container align-center">
								<a href="/cuddly/product/detail?productNo=${productDto.productNo}">
								<img src="/cuddly/image/product/main?productNo=${productDto.productNo}"
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




  <form action="write" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productNo" value="${productNo}">
        
       <i class="star far fa-star yellow" data-rating="1"></i>
<i class="star far fa-star yellow" data-rating="2"></i>
<i class="star far fa-star yellow" data-rating="3"></i>
<i class="star far fa-star yellow" data-rating="4"></i>
<i class="star far fa-star yellow" data-rating="5"></i>
<input type="hidden" name="reviewGrade" id="reviewGrade" value="0"> <!-- 초기값 -->

        
        <br><br>
        
        <input type="text" name="reviewContent" placeholder="리뷰 내용"><br><br>
        <input type="file" class="file-chooser" name="attach" accept="image/*"><br><br>
        <img class="now" src="" width="200" height="200"><br><br>
        <button class="btn-save">사진 등록</button><br><br>
        <button type="submit">리뷰 등록</button>
    </form>


</body>
</html>