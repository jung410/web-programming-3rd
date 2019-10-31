<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>GGV :: 회원정보찾기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/header.css">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/findIDPW.css">
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="/js/index.js"></script>
</head>
<script>
	$(function(){
		$("#findIdBtn").click(function(){
			var name = $(".index-findID input[name='name']").val();
			var email = $(".index-findID input[name='email']").val();
			$.ajax({
				url : 'findUserid?name='+name+'&email='+email,
				type : 'post',
				beforeSend : function() {
					$("#findIdBtn").find("span").addClass("spinner-border spinner-border-sm");
					$("#findIdBtn").attr("disabled", true);
				},
				success : function(){
					alert("메일이 전송되었습니다. 메일을 확인해주세요.");
				},
				error : function(){
					alert("입력된 정보와 일치하는 아이디가 없습니다. 다시 확인해주세요.");
				},
				complete : function() {
					$("#findIdBtn").find("span").removeClass("spinner-border spinner-border-sm");
					$("#findIdBtn").attr("disabled", false);
				}
			})
		})
		
		$("#findPwBtn").click(function(){
			var userid = $(".index-findPW input[name='userid']").val();
			var email = $(".index-findPW input[name='email']").val();
			$.ajax({
				url : 'findPassword?userid='+userid+'&email='+email,
				type : 'post',
				beforeSend : function() {
					$("#findPwBtn").find("span").addClass("spinner-border spinner-border-sm");
					$("#findPwBtn").attr("disabled", true);
				},
				success : function(){
					alert("메일이 전송되었습니다. 메일을 확인해주세요.");
				},
				error : function(){
					alert("아이디 또는 이메일에 대한 회원정보가 없습니다. 다시 확인해주세요.");
				},
				complete : function() {
					$("#findPwBtn").find("span").removeClass("spinner-border spinner-border-sm");
					$("#findPwBtn").attr("disabled", false);
				}
			})
		})
		
	})
</script>
<body>
    <!-- header 부분 시작 -->
    <jsp:include page="../includes/header.jsp" />
    <!-- header 부분 종료 -->

    <main>
        <div class="justify-content-center">
        	<div class="row mb-5">
	            <section class="index-findID col-sm-5 my-auto mx-auto px-3">
	                <h3 class="d-flex justify-content-center mb-4">- 아이디 찾기 -</h3>
	                <form method="post">
	                    <div class="form-group">
	                        <input type="text" class="form-control" name="name" placeholder="이름" required="required">
	                        <label for="name">이름</label>
	                    </div>
	                    <div class="form-group">
	                        <input type="email" class="form-control" name="email" id="email" placeholder="이메일" required="required">
	                        <label for="email">이메일</label>
	                    </div>
	                    <div class="form-group">
	                        <button type="button" id="findIdBtn" class="btn btn-primary btn-lg btn-block login-btn mx-auto"><span></span> 아이디 찾기</button>
	                    </div>
	                </form>
	            </section>
            </div>
            <div class="row">
	            <section class="index-findPW col-sm-5 m-auto mx-auto pt-5">
	                <h3 class="d-flex justify-content-center mb-4">- 비밀번호 찾기 -</h3>
	                <form method="post">
	                    <div class="form-group">
	                        <input type="text" class="form-control" name="userid" placeholder="아이디" required="required">
	                        <label for="name">아이디</label>
	                    </div>
	                    <div class="form-group">
	                        <input type="email" class="form-control" name="email" placeholder="이메일" required="required">
	                        <label for="email">이메일</label>
	                    </div>
	                    <div class="form-group">
	                        <button type="button" id="findPwBtn" class="btn btn-primary btn-lg btn-block login-btn mx-auto"><span></span> 비밀번호 찾기</button>
	                    </div>
	                </form>
	            </section>
            </div>
        </div>
    </main>

    <!-- footer 부분 시작 -->
    <footer>
        <div class="theater-info">
        </div>
        <div class="copyright">
            java | spring | jsp | css | js | jquery | bootstrap4 | Oracle DB | AWS | Responsive Web
            <br>
            copyright@2019 Hwang yung il | Park so yoon | Jeong min young
        </div>
    </footer>
    <!-- footer 부분 종료 -->
</body></html>