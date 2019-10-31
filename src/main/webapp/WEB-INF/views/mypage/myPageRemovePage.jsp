<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../includes/myPageHeader.jsp"></jsp:include>
    <!-- header 부분 종료 -->

    <main class="d-flex mt-5 mx-auto" id="wrapper">
        <!-- Sidebar -->
        <jsp:include page="../includes/myPageSideMenu.jsp"></jsp:include>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">

            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <button class="btn btn-danger" id="menu-toggle">Toggle Menu</button>
            </nav>

            <div class="container-fluid row col-8 mx-auto d-flex mt-3">
                <div class="col-sm-4 d-flex justify-content-center">
                    <img src="/images/user.png" alt="" class="">
                </div>
                <jsp:include page="../mypage/myPageTitle.jsp"></jsp:include>
            </div>
            <hr>
			
            <div class="container-fluid modify-form">
                <div class="my-resv">
                    <div class="h4 mt-2">회원 탈퇴</div>
                    <div>
                        <span>GGV 회원탈퇴시 모든 혜택을 놓치게 됩니다.
                        </span>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-lg-5 mx-auto">
                        <form class="needs-validation" method="post" name="removefrm">
                        	<input type="hidden" name="userid" value="${loginStat.userid}">
                            <div class="mb-3">
                                <label for="password">현재 비밀번호<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="비밀번호" id="password" type="password"
                                        name="password" required="required">
                                    <div class="invalid-feedback" style="width: 100%;">
                                        비밀번호를 입력해주세요.
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="password2">비밀번호 재입력<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="비밀번호 재입력" id="password2" type="password"
                                        name="password2" required="required">
                                    <div class="invalid-feedback" style="width: 100%;">
                                        비밀번호를 재입력해주세요.
                                    </div>
                                </div> <!-- form-group// -->
                            </div>
                            <hr class="mb-4">
                            <button class="btn btn-danger btn-lg btn-block mb-5 removeBtn" type="button">회원 탈퇴</button>
                        </form>
                    </div>
                </div>
			<script>
			var apilogin = '${loginStat.apiLogin}';
			if(apilogin == 1){
        		$("input").attr("readonly", "readonly");
        		$(".removeBtn").attr("disabled", "disabled");
        	}
			</script>
            </div>
        </div>
        <!-- /#page-content-wrapper -->
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
</body>

</html>