<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                    <div class="h4 mt-2">내 정보 변경</div>
                    <div>
                        <span>아이디를 제외한 개인 정보를 변경할 수 있습니다.
                        </span>
                    </div>
                </div>
                <hr>

                <div class="row">
                    <div class="col-lg-5 mx-auto">
                        <form class="needs-validation" novalidate="" method="post">
                        	<input type="hidden" name="userid" value="${loginStat.userid}">
                        	
                        	<c:if test="${loginStat.apiLogin == 1 }">
                            <div class="mb-3 password-input">
                                <label for="password">변경할 비밀번호<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="kakao 로그인은 비밀번호를 변경할 수 없습니다." id="password" type="password"
                                        name="password" required="" readonly="readonly">
                                    <div class="custom-feedback w-100">6글자 이상의 비밀번호를 입력해주세요.</div>
                                </div>
                            </div>
							
                            <div class="mb-3 password2-input">
                                <label for="password2">비밀번호 재입력<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="kakao 로그인은 비밀번호를 변경할 수 없습니다." id="password2" type="password"
                                        name="password2" required="" readonly="readonly">
                                    <div class="custom-feedback w-100">비밀번호가 동일하지 않습니다. 다시
								확인해주세요.</div>
                                </div> <!-- form-group// -->
                            </div>
                            
                            <div class="row name-input">
                                <div class="col-md-12 mb-3">
                                    <label for="name">이름<span>*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="kakao 로그인은 이름을 변경할 수 없습니다."
                                        value="${loginStat.name}" required="" readonly="readonly">
                                    <div class="custom-feedback w-100">한글로 된 2글자 이상의 이름을
								입력해주세요.</div>
                                </div>
                            </div>

                            <div class="mb-3 birthdate-input">
                                <label for="birthdate">생년월일<span>*</span></label>
                                <input type="text" class="form-control" id="birthdate" name="birthdate" placeholder="19910410" required="" value="${loginStat.birthdate}">
                                <div class="custom-feedback w-100">예시와 동일한 형태의 생년월일을 입력해주세요.</div>
                            </div>

                            <div class="mb-3 email-input">
                                <label for="email">이메일<span>*</span><span class="text-muted ml-4">ex) abc@abc.com</span></label>
                                <input type="email" class="form-control" id="email" name="email"
                                    placeholder="kakao 로그인은 이메일을 변경할 수 없습니다." required="" value="${loginStat.email}" readonly="readonly">
                                <div class="custom-feedback w-100">예시와 동일한 형태의 이메일을 입력해주세요.
                            	</div>
                            </div>

                            <div class="mb-3 phone-input">
                                <label for="phone">전화번호<span>*</span><span class="text-muted ml-4">ex)
                                        010-0000-0000</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-mobile"
                                                aria-hidden="true"></i></span>
                                    </div>
                                    <input type="phone" class="form-control" id="phone" name="phone"
                                        placeholder="010-0000-0000" required="" value="${loginStat.phone}">
                                    <div class="custom-feedback w-100">예시와 동일한 형태의 전화번호를
								입력해주세요.</div>
                                </div>
                            </div>

                            <div>
                                <label for="address">주소</label>
                                <div class="d-flex">
                                    <input type="text" class="form-control col-8" id="address" name="address"
                                        placeholder="번지 및 도로명 주소" value="${loginStat.address}">
                                    <button class="btn btn-secondary col-4 btn-sm" type="button" onclick="sample4_execDaumPostcode()">주소검색</button>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address2" hidden="hidden">상세주소</label>
                                <input type="text" class="form-control" id="address2" name="address2"
                                    placeholder="상세주소를 입력하세요." value="${loginStat.address2}">
                            </div>
                            <hr class="mb-4">
                            <div class="custom-control custom-checkbox">
                            	<c:if test="${loginStat.agree eq 1}">
                            	<input type="checkbox" class="custom-control-input" id="check-email" name="agree" value="1" checked>
                            	</c:if>
                            	<c:if test="${loginStat.agree eq 0}">
                            	<input type="checkbox" class="custom-control-input" id="check-email" name="agree" value="1">
                            	</c:if>
                                <label class="custom-control-label" for="check-email">이메일 수신을 동의합니다.</label>
                            </div>
							</c:if>
							<c:if test="${loginStat.apiLogin == 0 }">
							<div class="mb-3 password-input">
                                <label for="password">변경할 비밀번호<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="6글자 이상" id="password" type="password"
                                        name="password" required="">
                                    <div class="custom-feedback w-100">6글자 이상의 비밀번호를 입력해주세요.</div>
                                </div>
                            </div>
							
                            <div class="mb-3 password2-input">
                                <label for="password2">비밀번호 재입력<span>*</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                    </div>
                                    <input class="form-control" placeholder="비밀번호 재입력" id="password2" type="password"
                                        name="password2" required="">
                                    <div class="custom-feedback w-100">비밀번호가 동일하지 않습니다. 다시
								확인해주세요.</div>
                                </div> <!-- form-group// -->
                            </div>
                            <div class="row name-input">
                                <div class="col-md-12 mb-3">
                                    <label for="name">이름<span>*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="한글 2글자 이상"
                                        value="${loginStat.name}" required="">
                                    <div class="custom-feedback w-100">한글로 된 2글자 이상의 이름을
								입력해주세요.</div>
                                </div>
                            </div>

                            <div class="mb-3 birthdate-input">
                                <label for="birthdate">생년월일<span>*</span></label>
                                <input type="text" class="form-control" id="birthdate" name="birthdate" placeholder="19910410" required="" value="${loginStat.birthdate}">
                                <div class="custom-feedback w-100">예시와 동일한 형태의 생년월일을 입력해주세요.</div>
                            </div>

                            <div class="mb-3 email-input">
                                <label for="email">이메일<span>*</span><span class="text-muted ml-4">ex) abc@abc.com</span></label>
                                <div class="input-group">
	                                <input type="email" class="form-control" id="email" name="email"
	                                    placeholder="you@example.com" required="" value="${loginStat.email}">
	                                <button type="button" class="btn btn-secondary" id="checkEmailbtn">중복체크</button>
	                                <div class="custom-feedback w-100">예시와 동일한 형태의 이메일을 입력해주세요.
	                            	</div>
                            	</div>
                            </div>

                            <div class="mb-3 phone-input">
                                <label for="phone">전화번호<span>*</span><span class="text-muted ml-4">ex)
                                        010-0000-0000</span></label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"> <i class="fa fa-mobile"
                                                aria-hidden="true"></i></span>
                                    </div>
                                    <input type="phone" class="form-control" id="phone" name="phone"
                                        placeholder="010-0000-0000" required="" value="${loginStat.phone}">
                                    <div class="custom-feedback w-100">예시와 동일한 형태의 전화번호를
								입력해주세요.</div>
                                </div>
                            </div>

                            <div>
                                <label for="address">주소</label>
                                <div class="d-flex">
                                    <input type="text" class="form-control col-8" id="address" name="address"
                                        placeholder="번지 및 도로명 주소" value="${loginStat.address}">
                                    <button class="btn btn-secondary col-4 btn-sm" type="button" onclick="sample4_execDaumPostcode()">주소검색</button>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="address2" hidden="hidden">상세주소</label>
                                <input type="text" class="form-control" id="address2" name="address2"
                                    placeholder="상세주소를 입력하세요." value="${loginStat.address2}">
                            </div>
                            <hr class="mb-4">
                            <div class="custom-control custom-checkbox">
                            	<c:if test="${loginStat.agree eq 1}">
                            	<input type="checkbox" class="custom-control-input" id="check-email" name="agree" value="1" checked>
                            	</c:if>
                            	<c:if test="${loginStat.agree eq 0}">
                            	<input type="checkbox" class="custom-control-input" id="check-email" name="agree" value="1">
                            	</c:if>
                                <label class="custom-control-label" for="check-email">이메일 수신을 동의합니다.</label>
                            </div>
							</c:if>
                            <div class="custom-control custom-checkbox mb-2">
                                <input type="checkbox" class="custom-control-input" id="check-user" name="checkUser" value="1"
                                    checked>
                                <label class="custom-control-label" for="check-user">개인정보 활용에 동의합니다.</label>
                            </div>

                            <!-- Button to Open the Modal -->
                            <div class="d-flex justify-content-center">
                                <button type="button" class="btn btn-sm btn-secondary" data-toggle="modal"
                                    data-target="#myModal">
                                    개인정보 활용 동의서 상세 내용 보기
                                </button>
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
                            <c:if test="${loginStat.apiLogin == 0 }">
                            <button class="btn btn-primary btn-lg btn-block mb-5" type="submit">수정 완료</button>
                            </c:if>
                            <c:if test="${loginStat.apiLogin == 1 }">
                            <button class="btn btn-primary btn-lg btn-block mb-5" type="submit" formaction="myPageKakaoModify">수정 완료</button>
                            </c:if>
                        </form>
                    </div>
                </div>

            </div>
        </div>
        <!-- /#page-content-wrapper -->

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
</body>

</html>