<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>GGV :: 마이페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/header.css">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/join.css">
    <link href="/css/myPageMain.css" rel="stylesheet">
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
    <script src="/js/index.js"></script>
    
    <style>
		.modal-width{width: 100%;}
    </style>
    <script>
    	var apilogin = '${loginStat.apiLogin}';
        $(function () {
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });
            
            $(".custom-feedback").hide();
            var isCheckEmail = false;
            
         	// 이메일 중복 확인
    		$("#checkEmailbtn").click(function() {
    			var email = $("#email").val();

    			$.ajax({
    				url : '/user/emailCheck?email=' + email,
    				type : 'get',
    				success : function(data) {
    					if(email == ''){
    						alert("이메일을 입력해주세요.");
    						isCheckEmail = false;
    					} else if (data == 999){
    						alert("기존 이메일과 동일합니다. 사용 가능합니다.");
    						isCheckEmail = true;
    						$("#email").removeClass('is-invalid');
    						$("#email").addClass('is-valid');
    						$(".userid-input .custom-feedback").hide();
    					} else if (data > 0) {
    						alert("중복된 이메일입니다. 다른 이메일을 입력해주세요.");
    						isCheckEmail = false;
    					} else {
    						alert("사용 가능한 이메일입니다.");
    						isCheckEmail = true;
    						$("#email").removeClass('is-invalid');
    						$("#email").addClass('is-valid');
    						$(".userid-input .custom-feedback").hide();
    					}
    				}
    			})
    		});
         	
    		$("#email").on("change input",function(){
    			isCheckEmail = false;
    			$(this).val( $(this).val().replace(/ /gi,"") );
    			$(this).removeClass('is-valid');
    			$(this).addClass('is-invalid');
    		});
    		
    		$("#password, #password2, #name, #birthdate, #phone").on("input",function(){
    			$(this).val( $(this).val().replace(/ /gi,"") );
    		});
         	
    		(function() {
    			'use strict'
    			window.addEventListener('load', function() {
    				// Fetch all the forms we want to apply custom Bootstrap validation styles to
    				var forms = document.getElementsByClassName('needs-validation')
    				// Loop over them and prevent submission
    				Array.prototype.filter.call(forms, function(form) {

    					form.addEventListener('submit', function(event) {
    						if(apilogin == 0){
    							// 비밀번호1 유효성 검사 시작
        						if ($("#password").val().length < 6) {
        							$(".password-input .custom-feedback").show();
        							form.password.classList.remove('is-valid');
        							form.password.classList.add('is-invalid');
        							$("#password").focus();
        							event.preventDefault();
        							return false;
        						} else {
        							$(".password-input .custom-feedback").hide();
        							form.password.classList.remove('is-invalid');
        							form.password.classList.add('is-valid');
        						}
        						// 비밀번호1 유효성 검사 종료

        						// 비밀번호2 유효성 검사 시작
        						if ($("#password").val() != $("#password2").val()) {
        							form.password2.classList.remove('is-valid');
        							form.password2.classList.add('is-invalid');
        							$(".password2-input .custom-feedback").show();
        							$("#password2").focus();
        							event.preventDefault();
        							return false;
        						} else {
        							$(".password2-input .custom-feedback").hide();
        							form.password2.classList.remove('is-invalid');
        							form.password2.classList.add('is-valid');
        						}
        						// 비밀번호2 유효성 검사 종료
        						
        						// 이름 유효성 검사 시작
								if ($("#name").val().length > 1
										&& !checkKor($("#name").val())) {
									$(".name-input .custom-feedback").hide();
									form.name.classList.remove('is-invalid');
									form.name.classList.add('is-valid');
								} else {
									form.name.classList.remove('is-valid');
									form.name.classList.add('is-invalid');
									$(".name-input .custom-feedback").show();
									$("#name").focus();
									event.preventDefault();
									return false;
								}
								// 이름 유효성 검사 종료
	    						
								// 이메일 유효성 검사 시작
								if (!checkEmail($("#email").val())) {
									form.email.classList.remove('is-valid');
									form.email.classList.add('is-invalid');
									$(".email-input .custom-feedback").show();
									$("#email").focus();
									event.preventDefault();
									return false;
								} else {
									$(".email-input .custom-feedback").hide();
									form.email.classList.remove('is-invalid');
									form.email.classList.add('is-valid');
								}
								// 이메일 유효성 검사 종료
    						}
    						
    						// 생년월일 유효성 검사 시작
    						if (!checkBirtdate($("#birthdate").val())) {
    							form.birthdate.classList.remove('is-valid');
    							form.birthdate.classList.add('is-invalid');
    							$(".birthdate-input .custom-feedback").show();
    							$("#birthdate").focus();
    							event.preventDefault();
    							return false;
    						} else {
    							$(".birthdate-input .custom-feedback").hide();
    							form.birthdate.classList.remove('is-invalid');
    							form.birthdate.classList.add('is-valid');
    						}
    						// 생년월일 유효성 검사 종료
							
    						// 전화번호 유효성 검사 시작
    						if (!checkPhone($("#phone").val())) {
    							form.phone.classList.remove('is-valid');
    							form.phone.classList.add('is-invalid');
    							$(".phone-input .custom-feedback").show();
    							$("#phone").focus();
    							event.preventDefault();
    							return false;
    						} else {
    							$(".phone-input .custom-feedback").hide();
    							form.phone.classList.remove('is-invalid');
    							form.phone.classList.add('is-valid');
    						}
    						// 전화번호 유효성 검사 종료
							if(apilogin == 1){
								isCheckEmail = true;
							}
    						if(!isCheckEmail){
    							alert("이메일 중복체크를 해주세요.");
    							event.preventDefault();
    							return false;
    						}
    						
    						if($('input:checkbox[id="check-user"]').is(":checked") == false){
    		                    $(".custom-control-label").focus();
    		                    alert("개인정보제공에 동의해 주세요.");
    		                	event.preventDefault();
    		                	return false;
    		                }
    						if(confirm("정보를 변경하시겠습니까?")){
	    						alert("정보 변경이 완료되었습니다.");
	    						return true;
    						} else {
    							alert("정보 변경을 취소합니다.");
    							event.preventDefault();
    							return false;
    						}
    					}, false)
    				})
    			}, false)
    		}());

    		function checkKor(value) {
    			var regex = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    			if (regex.test(value)) {
    				return true;
    			} else {
    				return false;
    			}
    		}

    		function checkEmail(value) {
    			var regex = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
    			if (regex.test(value)) {
    				return true;
    			} else {
    				return false;
    			}
    		}

    		function checkPhone(value) {
    			var regex = /^\d{2,3}-\d{3,4}-\d{4}$/;
    			if (regex.test(value)) {
    				return true;
    			} else {
    				return false;
    			}
    		}
    		
    		function checkBirtdate(value){
    			var regex = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    			if (regex.test(value)) {
    				return true;
    			} else {
    				return false;
    			}
    		}
    		
    		$(".movieCancleBtn").click(function(e){
    			if(confirm("정말 예매를 취소하시겠습니까?")){
    				frm.submit();
    			} else {
    				return false;
    			}
    		})
    		
    		$(".removeBtn").click(function(e){
        		if(confirm("정말 회원탈퇴 하시겠습니까?\n모든 예매내역과 리뷰가 삭제됩니다.")){
        			removefrm.submit();
        		} else {
        			return false;
        		}
        	})
        })
        	// 우편번호 찾기 API
		function sample4_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
					// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수
	
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}
	
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById("address").value = roadAddr;
				}
			}).open();
		}
        
    </script>
</head>

<body>
    <!-- header 부분 시작 -->
    <header>
        <nav class="navbar navbar-expand-sm bg-white navbar-light fixed-top border border-top-0 border-left-0 border-right-0">
            <div class="container d-flex justify-content-between">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a class="navbar-brand d-flex align-items-center" href="/"><img src="/images/h1_cgv.png" alt=""></a>
                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/movie/movieChart">MOVIE</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/reservation/ticketing">RESERVATION</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/myPage/myPageMain">MYGGV</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link logout-btn" href="/user/logout">LOGOUT</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>