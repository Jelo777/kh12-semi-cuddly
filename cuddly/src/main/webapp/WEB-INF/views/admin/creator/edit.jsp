<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function() {
		$(".preview").hide();
		
		$(".file-chooser").change(function(e) {

					e.preventDefault();

					//파일선택창을 Javascript 형태로 불러와야함(내장API 사용)
					//var input = document.querySelector(".file-chooser");
					var input = $(".file-chooser")[0];

					//input이 file일 경우에만 files라는 항목이 존재
					//console.log(input.files);
					if (input.files.length == 0)
						return;

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
						url : "http://localhost:8080/restfile/upload",
						method : "post",
						processData : false,
						contentType : false,
						data : form,
						success : function(response) {
							//console.log(response);
							//이미지의 src를 바꾸는 코드
							$(".preview-image").attr(
									"src",
									"http://localhost:8080/restfile/download?attachNo="
											+ response.attachNo);
						},
					});
					$(".preview").show();
				});
	});
</script>
<div class="container w-400">

	<div class="row">
		<img class="image image-circle"
			src="/cuddly/image/creator?creatorNo=${creatorDto.creatorNo}"
			onerror="this.style.display='none';" width="200" height="200">
		<h1 class="mv-20">${creatorDto.creatorName}</h1>
	</div>


	<form action="edit" method="post" enctype="multipart/form-data">
		<input type="hidden" name="creatorNo" value="${creatorDto.creatorNo}">
		<div class="row">
			<input class="form-input find-input w-100 file-chooser" type="file"
							style="padding:6px;" name="attach" accept="image/*">
		</div>
		<div class="preview">
			<div class="row">
				<img class="image image-round preview-image" src="" width="200" height="200">
			</div>
			<div class="row">
				<h2>미리보기</h2>
			</div>
		</div>
		<div class="row">
			<button class="btn btn-positive w-100">이미지 수정</button>
		</div>

	</form>

</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>