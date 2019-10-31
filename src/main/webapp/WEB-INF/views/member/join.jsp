<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>GGV :: 회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet" href="/css/join.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function() {
		$(".custom-feedback").hide();

		var isCheckID = false;
		var isCheckEmail = false;

		// 아이디 중복 확인
		$("#checkIDbtn").click(function() {
			var userid = $("#userid").val();

			$.ajax({
				url : 'idCheck?userid=' + userid,
				type : 'get',
				success : function(data) {
					if(userid == ''){
						alert("아이디를 입력해주세요.");
					} else if (data > 0) {
						alert("중복된 아이디입니다. 다른 아이디를 입력해주세요.");
					} else {
						alert("사용 가능한 아이디입니다.");
						isCheckID = true;
						$("#userid").removeClass('is-invalid');
						$("#userid").addClass('is-valid');
						$(".userid-input .custom-feedback").hide();
					}
				}
			})
		});
		
		// 이메일 중복 확인
		$("#checkEmailbtn").click(function() {
			var email = $("#email").val();

			$.ajax({
				url : 'emailCheck?email=' + email,
				type : 'get',
				success : function(data) {
					if(email == ''){
						alert("이메일을 입력해주세요.");
					} else if (data > 0) {
						alert("중복된 이메일입니다. 다른 이메일을 입력해주세요.");
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

		$("#userid").on("change input",function(){
			isCheckID = false;
			$(this).val( $(this).val().replace(/ /gi,"") );
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
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
						// 아이디 유효성 검사 시작
						if ($("#userid").val().length > 3
								&& !checkID($("#userid").val())) {
							$(".userid-input .custom-feedback").hide();
							form.userid.classList.remove('is-invalid');
							form.userid.classList.add('is-valid');
						} else {
							form.userid.classList.remove('is-valid');
							form.userid.classList.add('is-invalid');
							$(".userid-input .custom-feedback").show();
							$("#userid").focus();
							event.preventDefault();
							return false;
						}
						// 아이디 유효성 검사 종료

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

						if(!isCheckID){
							alert("아이디 중복체크를 해주세요.");
							event.preventDefault();
							return false;
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
					}, false)
				})
			}, false)
		}());

		function checkID(value) {
			var regex = /[^a-zA-Z0-9]$/;
			if (regex.test(value)) {
				return true;
			} else {
				return false;
			}
		}

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
	<jsp:include page="../includes/header.jsp" />
	<main>
	<div class="container mt-5">
		<div class="py-5 text-center">
			<h2>회원가입</h2>
			<p class="lead">회원가입을 시작해 볼까요?</p>
		</div>
		<div class="row">
			<div class="col-md-4 mx-auto">
				<form class="needs-validation" novalidate="novalidate" method="post">
					<div class="mb-3">
						<label for="userid">아이디<span>*</span></label>
						<div class="input-group userid-input">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-user"></i></span>
							</div>
							<input type="text" class="form-control userid" id="userid"
								name="userid" placeholder="3글자 이상의 영문/숫자" required="required">
							<button type="button" class="btn btn-secondary" id="checkIDbtn">중복체크</button>
							<div class="custom-feedback">3글자 이상의 영문/숫자 조합의 아이디를 입력해주세요.</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="password">비밀번호<span>*</span></label>
						<div class="input-group password-input">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input class="form-control" placeholder="6글자 이상" id="password"
								type="password" name="password" required="required">
							<div class="custom-feedback w-100">6글자 이상의 비밀번호를 입력해주세요.</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="password2">비밀번호 재입력<span>*</span></label>
						<div class="input-group password2-input">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-lock"></i>
								</span>
							</div>
							<input class="form-control" placeholder="비밀번호 재입력" id="password2"
								type="password" name="password2" required="required">
							<div class="custom-feedback w-100">비밀번호가 동일하지 않습니다. 다시
								확인해주세요.</div>
						</div>
						<!-- form-group// -->
					</div>

					<div class="row">
						<div class="col-md-12 mb-3 name-input">
							<label for="name">이름<span>*</span></label> <input type="text"
								class="form-control" id="name" name="name"
								placeholder="한글 2글자 이상" value="" required="required">
							<div class="custom-feedback w-100">한글로 된 2글자 이상의 이름을
								입력해주세요.</div>
						</div>
					</div>

					<div class="mb-3 birthdate-input">
						<label for="birthdate">생년월일<span>*</span><span
							class="text-muted ml-4">ex) 19990101</span></label> <input
							type="text" class="form-control" id="birthdate" name="birthdate"
							required="required" placeholder="19990101">
						<div class="custom-feedback w-100">예시와 동일한 형태의 생년월일을 입력해주세요.</div>
					</div>

					<div class="mb-3 email-input">
						<label for="email">이메일<span>*</span><span
								class="text-muted ml-4">ex) abc@abc.com</span></label> 
						<div class="input-group">
							<input type="email" class="form-control" id="email" name="email"
								placeholder="you@example.com" required="required">
							<button type="button" class="btn btn-secondary" id="checkEmailbtn">중복체크</button>
							<div class="custom-feedback w-100">예시와 동일한 형태의 이메일을 입력해주세요.</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="phone">전화번호<span>*</span><span
							class="text-muted ml-4">ex) 010-0000-0000</span></label>
						<div class="input-group phone-input">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i class="fa fa-mobile"
									aria-hidden="true"></i></span>
							</div>
							<input type="text" class="form-control" id="phone" name="phone"
								placeholder="010-0000-0000" required="required">
							<div class="custom-feedback w-100">예시와 동일한 형태의 전화번호를
								입력해주세요.</div>
						</div>
					</div>

					<div>
						<label for="address">주소</label>
						<div class="d-flex">
							<input type="text" class="form-control col-8" id="address"
								name="address" placeholder="번지 및 도로명 주소">
							<button class="btn btn-secondary col-4" type="button"
								onclick="sample4_execDaumPostcode()">주소검색</button>
						</div>
					</div>

					<div class="mb-3">
						<label for="address2" hidden="hidden">상세주소</label> <input type="text"
							class="form-control" id="address2" name="address2"
							placeholder="상세주소를 입력하세요.">
					</div>

					<hr class="mb-4">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input"
							id="check-email" name="agree" value="1"> <label
							class="custom-control-label" for="check-email">이메일 수신을
							동의합니다.</label>
					</div>

					<div class="custom-control custom-checkbox mb-2">
						<input type="checkbox" class="custom-control-input"
							id="check-user" name="checkUser" checked value="1"> <label
							class="custom-control-label" for="check-user">개인정보 활용에
							동의합니다.</label>
					</div>

					<!-- Button to Open the Modal -->
					<div class="d-flex justify-content-center">
						<button type="button" class="btn btn-sm btn-secondary"
							data-toggle="modal" data-target="#myModal">개인정보 활용 동의서
							상세 내용 보기</button>
					</div>

					<!-- The Modal -->
					<div class="modal" id="myModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h1 class="modal-title">개인정보 활용 동의서</h1>
									<button type="button" class="close" data-dismiss="modal">×</button>
								</div>

								<!-- Modal body -->
								<div class="modal-body">
									<h3>스크롤을 내리면서 확인해 주세요.</h3>
									
									정보통신망법 규정에 따라 GGV에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 
									개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.<br>

									1. 수집하는 개인정보<br>
									이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 GGV 서비스를 회원과 동일하게 이용할 수 있습니다. 
									이용자가 예약, 리뷰, 취소 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, GGV는 
									서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.<br><br>
									
									회원가입 시점에 GGV가 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
									- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호, 전화번호, 이메일’을 필수항목으로 수집합니다. 
									만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 
									중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.<br><br>
									서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
									GGV 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 
									추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 
									대해 안내 드리고 동의를 받습니다.<br><br>
									
									서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다. 
									또한 이미지 및 음성을 이용한 검색 서비스 등에서 이미지나 음성이 수집될 수 있습니다.<br>
									구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나,<br>
									2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 서비스 이용 과정에서 위치정보가 수집될 수 있으며,
									이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.<br><br>
									
									2. 수집한 개인정보의 이용<br>
									GGV 및 GGV 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발・제공 및 향상, 안전한 인터넷 이용환경 구축 등 
									아래의 목적으로만 개인정보를 이용합니다.<br><br>
									
									- 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.<br>
									- 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.<br>
									- 법령 및 네이버 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.<br>
									- 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.<br>
									- 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.<br>
									- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.<br>
									- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.<br><br>
									3. 개인정보의 파기<br>
									회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.<br>
									단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.<br>
									
									이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우는 아래와 같습니다.<br>
									부정가입 및 징계기록 등의 부정이용기록은 부정 가입 및 이용 방지를 위하여 수집 시점으로부터 6개월간 보관하고 파기하고 있습니다. 부정이용기록 내 개인정보는 가입인증 휴대폰 번호(만 14세 미만 회원의 경우 법정대리인 DI)가 있습니다.<br>
									결제도용, 불법할인대출(일명 '카드깡') 등 관련 법령 및 이용약관을 위반하는 GGV 영화 예매의 부정거래기록(아이디, 이름, 휴대전화번호, IP주소, 쿠키, 기기정보)은 부정거래 방지 및 다른 선량한 이용자의 보호, 안전한 거래 환경 보장을 위하여 수집 시점으로부터 3년간 보관하고 파기합니다.<br>
									부정이용으로 징계를 받기 전에 회원 가입 및 탈퇴를 반복하며 서비스를 부정 이용하는 사례를 막기 위해 탈퇴한 이용자의 휴대전화번호를 복호화가 불가능한 일방향 암호화(해시 처리)하여 6개월간 보관합니다. QR코드 서비스에서 연락처를 등록한 이후 QR코드 삭제 시, 복구 요청 대응을 위해 삭제 시점으로 부터 6개월 보관합니다. 스마트 플레이스 서비스에서 휴대전화번호를 등록한 경우 분쟁 조정 및 고객문의 등을 목적으로 업체 등록/수정 요청시, 또는 등록 이후 업체 삭제 요청 시로부터 최대 1년간 보관 할 수 있습니다.<br><br>
									
									전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. GGV는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.<br>
									- 전자상거래 등에서 소비자 보호에 관한 법률<br>
									계약 또는 청약철회 등에 관한 기록: 5년 보관<br>
									대금결제 및 재화 등의 공급에 관한 기록: 5년 보관<br>
									소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관<br>
									- 전자금융거래법<br>
									전자금융에 관한 기록: 5년 보관<br>
									- 특정 금융거래정보의 보고 및 이용 등에 관한 법률<br>
									금융거래정보 : 5년 보관<br>
									- 통신비밀보호법<br>
									로그인 기록: 3개월<br>
									회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다. 법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다. 전자적 파일 형태의 경우 복구 및 재생이 되지 않도록 기술적인 방법을 이용하여 안전하게 삭제하며, 출력물 등은 분쇄하거나 소각하는 방식 등으로 파기합니다.<br>
									참고로 GGV는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리하고 있습니다. <br>
								</div>

								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-danger"
										data-dismiss="modal">확인</button>
								</div>

							</div>
						</div>
					</div>

					<hr class="mb-4">
					<input type="hidden" name="apiLogin" value="1">
					<button class="btn btn-primary btn-lg btn-block mb-5" type="submit">회원가입</button>
				</form>
			</div>
		</div>
	</div>
	</main>

	<footer>
		<div class="theater-info"
			style="background-color: #242320; width: 100%; height: 50px; display: flex;">

		</div>
		<div class="copyright">java | servlet&jsp | html | css | js |
			jquery | bootstrap4 | Oracle DB | AWS | Responsive Web</div>
	</footer>
</body>

</html>