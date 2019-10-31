<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../includes/myPageHeader.jsp"></jsp:include>
<script>
var movie_pk = "${myreview.movie_pk}";
function showList() {
	var reviewTB = $(".reviewTB");
	var userid = "${loginStat.userid}";
	
	reviewService.getList(userid,
	function(myreview) {
 		var str = "";
		var cnt;
		console.log(myreview);
		for (var i = 0; i < myreview.length; i++) {
		    str += "<tr data-review_pk="+myreview[i].review_pk+">";
			str += "	<td class='text-center m_title'>" + myreview[i].m_title + "</td>";
		    str += "	<td class='rv_title'>" + myreview[i].rv_title + "</td>"; 
		    str += "	<td class='text-center rv_date'>" + myreview[i].rv_date + "</td>";
		   	str += "	<td class='text-center score'>";
			str += 		myreview[i].score
			str += "	</td>";
			str += "</tr>";
		}
		reviewTB.html(str);
	});
}

$(function() {
	showList();
	var modal = $(".modal");
	var modalInputRv_title = modal.find("input[name=title]");
	var modalInputRv_content = modal.find("textarea[name=content]");
	var modalInputScore = modal.find("select[name=score]");
	var modalInputFilename = modal.find("input[name=filename]");
	var modalInputUserid = "${loginStat.userid}";
	var modalInputM_title = $("#mtitle");
	var modalInputMovie_pk = "${getMovieInfo.movie_pk}";
	var modalModBtn = $("#modBtn");
	var modalRemoveBtn = $("#rmBtn");
	
	$(".reviewTB").on("click", "tr", function(e) {
		var review_pk = $(this).data("review_pk");
		
		reviewService.get(review_pk, function(myreview) {
			modalInputRv_title.val(myreview.rv_title);
			console.log(myreview.m_title);	
			modalInputRv_content.val(myreview.rv_content);
			modalInputScore.val(myreview.score);
			modalInputM_title.html(myreview.m_title);
			
			modal.data("movie_pk", myreview.movie_pk);
			modal.data("review_pk", myreview.review_pk);
			
			$(".modal").modal("show");
			modal.find("#regBtn").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
		});
	});

	modalModBtn.on("click", function(e) {
		var myreview = {
			rv_title : modalInputRv_title.val(),
			rv_content : modalInputRv_content.val(),
			score : modalInputScore.val(),
			userid : modalInputUserid,
			movie_pk : movie_pk
		};
		
		reviewService.modify({
			review_pk : modal.data("review_pk"),
			rv_title : modalInputRv_title.val(),
			rv_content : modalInputRv_content.val(),
			score : modalInputScore.val(),
			userid : modalInputUserid
			
		}, function(result) {
			alert("내가 쓴 리뷰 수정이 완료되었습니다");

			modal.modal("hide");
			showList(1);
		});
	});

	modalRemoveBtn.click(function() {
		console.log(modal.data("review_pk"));
		reviewService.remove(modal.data("review_pk"), function() {
			alert("내가 쓴 리뷰가 삭제 완료되었습니다.");
			modal.modal("hide");
			showList(1);
		})
	});
});

var reviewService = (function() {
	function getList(userid, callback, error) {
		$.getJSON("/myPage/myPageReview/" + userid,
			function(data) {
				if(callback) {
					callback(data);
				}
			}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function get(review_pk, callback, error) {
		$.get("/myPage/myPageReview/get/" + review_pk, 
			function(result) {
				if(callback) {
					callback(result);
				}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function modify(myreview, callback, error) {
		$.ajax({
			type : 'put',
			url : '/review/modify/' + myreview.review_pk,
			data : JSON.stringify(myreview),
			contentType : "application/json; charset=UTF-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	function remove(review_pk, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/review/remove/' + review_pk,
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	return {
		getList : getList,
		get : get,
		remove : remove,
		modify : modify
	};		
})();
</script>
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

            <div class="container-fluid">
                <div class="my-resv">
                    <div class="h4 mt-2">내가 쓴 리뷰</div>
                    <div>
                        <span>고객님이 작성한 리뷰를 보거나 수정 및 삭제를 할 수 있습니다.
                        </span> 
                    </div>
                </div>
                <hr>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover review-table">
                        <thead class="thead-light">
                            <tr class="text-center">
                                <th>영화명</th>
                                <th>리뷰 제목</th>
                                <th>작성일자</th>
                                <th>평점</th>
                            </tr>
                        </thead>
                        <tbody class="reviewTB">
                        
                        </tbody>
                    </table>
                    <div class="pagination">
                        
                    </div>
                </div>
            </div>
            <!-- /#page-content-wrapper -->
        </div>
    <!-- 리뷰 전체 부분 시작 -->
	<div id="reviewList" class="col mx-auto p-0">
		<!-- 리뷰(버튼 부분, 리뷰쓰기 모달창) 시작 -->
			<div class="col p-0 mt-3 mb-3">
				<!-- 리뷰쓰기 모달 창 시작 부분 -->
				<div class="modal fade" id="myModal">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<!-- Modal Header -->
							<div class="container mt-2">
								<button type="button" class="close" data-dismiss="modal">×</button>
							</div>
							<!-- Modal body 시작 -->
							<div class="modal-body">
								<div class="container">
									<div class="row">
										<div class="col-lg-11 mx-auto modal-body2">
											<div class="card flex-row mb-3 modal-body2 modal-width">
												<div class="card-body modal-body3">
													<form class="form-signin" role="form" action="/myPage/myPageReview" method="post">
														<h3 class="text-center font-weight-bolder" id="mtitle"></h3>
														<hr class="my-4">
														<div class="container modal-body4">
															<!-- 제목, 내용 구간 -->
															<div>
																<div class="form-label-group mb-3">
																	<label for="inputTitle"><strong>제목</strong></label>
																	<input type="text" id="inputTitle" name="title"
																		class="form-control" placeholder="제목을 입력하세요."
																		required autofocus>
																</div>
																<div class="form-label-group mb-3">
																	<label for="inputContent"><strong>내용</strong></label>
																	<textarea id="inputContent" name="content"
																		class="form-control" rows="8"
																		placeholder="내용을 입력하세요." required></textarea>
																</div>
															</div>
															<!-- 평점 구간 -->
															<div class="mb-4">
																<label for="sel2"><strong>평점</strong></label> 
																<select class="custom-select form-control" id="sel2" name="score">
																	<option value="10" selected>10점</option>
																	<option value="9">9점</option>
																	<option value="8">8점</option>
																	<option value="7">7점</option>
																	<option value="6">6점</option>
																	<option value="5">5점</option>
																	<option value="4">4점</option>
																	<option value="3">3점</option>
																	<option value="2">2점</option>
																	<option value="1">1점</option>
																</select>
															</div>
															
															<div class="modal-footer pb-0">
																<button class="btn btn-warning btn-block"
																	type="button" id="modBtn">수정</button>
																<button class="btn btn-danger btn-block mt-0"
																	type="button" id="rmBtn">삭제</button>
																<button class="btn btn-primary btn-block"
																	type="button" id="regBtn">작성</button>
															</div>
														</div>
													</form>
												</div>
												<hr class="my-4">
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- Modal body 끝 -->
						</div>
					</div>
				</div>
				<!-- 리뷰쓰기 모달 창 종료 부분 -->
			</div>
		</div>
	<!-- 리뷰(버튼 부분, 리뷰쓰기 모달창) 종료 -->
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