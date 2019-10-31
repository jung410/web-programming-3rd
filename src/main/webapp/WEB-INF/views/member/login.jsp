<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>GGV :: 로그인</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/header.css">
	<link rel="stylesheet" href="/css/index.css">
	<link rel="stylesheet" href="/css/footer.css">
	<link rel="stylesheet" href="/css/login.css">
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="/js/index.js"></script>
</head>
<script>
$(function(){
	$("#kakaoBtn").click(function(){
		window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=5de415f69c80956aabe62e730552ebd4&redirect_uri=https://ggv.min0s.com/user/kakao&response_type=code";
		//window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=5de415f69c80956aabe62e730552ebd4&redirect_uri=http://localhost:8080/user/kakao&response_type=code";
		//loginWithKakao();
	})
	
	$("#googleBtn").click(function(){
		alert("미구현 기능입니다. 죄송합니다.");
	})
})
//카카오 아이디로 로그인
Kakao.init('5de415f69c80956aabe62e730552ebd4');
function loginWithKakao() {
//로그인 창을 띄웁니다.
 Kakao.Auth.loginForm({
	 scope: "account_email, birthday",
     success: function(authObj) {
    	 Kakao.API.request({
   			url : '/v1/user/me',
   			/* data : {
   				propertyKeys: ['kaccount_email']
   			}, */
   			success:function(res){
   				//window.location.replace("http://localhost:8080");
   				//alert(res.properties.nickname+"님 환영합니다.");
   			}
   		 });
     },
     fail: function(err) {
         alert(JSON.stringify(err));
     }
 })
};


</script>
<body>
    <jsp:include page="../includes/header.jsp" />
    <main class="mt-4">
        <div class="login-form">
            <form method="post">
                <h2 class="text-center">간편로그인</h2>
                <div class="social-btn text-center">
                    <button id="googleBtn" type="button" class="btn btn-danger btn-block btn-lg"> Sign in with <b>Google</b></button>
                </div>
                <div class="social-btn text-center">
                    <button id="kakaoBtn" type="button" class="btn btn-warning btn-block btn-lg"> Sign in with <b>Kakao</b></button>
                </div>
                <div class="or-seperator"><i>or</i></div>
                <h2 class="text-center">로그인</h2>
                <div class="form-group">
                    <input type="text" class="form-control" name="userid" id="userid" placeholder="아이디" required="required">
                    <label for="userid">아이디</label>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" required="required">
                    <label for="password">비밀번호</label>
                </div>
                <p>일반계정 테스트 : tester1 / 123123</p>
                <p>관리자 테스트 : admin / 123123</p>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-block login-btn">로그인</button>
                </div>
                <p class="text-center small"><a href="findUser">아이디/비밀번호를 잃어버리셨나요?</a></p>
            </form>
            <p class="text-center small">계정이 없으신가요? <a href="join">회원가입!</a></p>
        </div>
    </main>

    <footer>
        <div class="theater-info" style="background-color: #242320; width:100%; height: 50px; display: flex;">

        </div>
        <div class="copyright">
            java | servlet&amp;jsp | html | css | js | jquery | bootstrap4 | Oracle DB | AWS | Responsive Web
        </div>
    </footer>
</body></html>