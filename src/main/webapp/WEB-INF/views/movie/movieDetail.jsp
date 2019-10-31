<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<title>GGV :: 영화 상세정보</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/movieDetail.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/js/index.js"></script>
<script type="text/javascript" src="/js/movieDetail.js"></script>
<script>	
function makeStars(scoreOrigin) {
	var score = scoreOrigin;
	var str = "";
	var cnt;
	for (var cnt = 0; cnt < score; cnt++) {
		if (cnt % 2 == 1) {
			str += '<i class="fa fa-star"></i>';
		} else if (score - 1 == cnt) {
			str += '<i class="fa fa-star-half-empty"></i>';
		}
	}
	for (var i = 0; i < parseInt((10 - cnt) / 2); i++) {
		str += '<i class="fa fa-star-o"></li>';
	}
	return str; // 문자열만 제작해서 반환
};

var pageNum = 1; // 전역변수 1로 초기화
function showReplyPage(replyCnt) {
	var endNum = Math.ceil(pageNum / 10) * 10;
	var startNum = endNum - 9;
	var prev = startNum != 1;
	var next = false;
	var str = '';
	if (endNum * 10 >= replyCnt) {
		endNum = Math.ceil(replyCnt / 10);
	}
	if (endNum * 10 < replyCnt) {
		next = true;
	}
	if (prev) {
		str += '<li class="page-item"><a href="' + (startNum - 1) + '" class="page-link">prev<</a></li>';
	}
	for (var i = startNum; i <= endNum; i++) {
		var active = pageNum == i ? "active" : "";
		str += '<li class="page-item ' +active+ ' "><a href="' + i + '" class="page-link ">' + i + '</a></li>';
	}
	if (next) {
		str += '<li class="page-item"><a href="' + (endNum + 1)	+ '" class="page-link">next</a></li>';
	}
	$(".pagination").html(str);
	$(".pagination").on("click", "a", function(e) {
		e.preventDefault();
		pageNum = $(this).attr("href");
		showList(pageNum);
	})
};

var useridList = [];
var movie_pk = "${getMovieInfo.movie_pk}";
var userid = "${loginStat.userid}";

function showMyReview() {
	if(!userid) {
		var str = "<tr class='text-center bg-secondary' style='background: #f9f3c7;'>" +
				"<td colspan='5'>" +
				"<a href='/user/login' class='text-white'>로그인 후 리뷰쓰기가 가능합니다. 로그인 후 이용해주세요.</a>" +
				"</td>" +
				"</tr>";
				
		$(".myreviewTB").html(str);
		return;
	}
	
	reviewService.getListMyReview(movie_pk, userid, function(list) {
		var str = "";
		if(list.length) { // 작성한 리뷰가 있을때
			str += "<tr data-review_pk="+list[0].review_pk+" class='h-10' style='background: #f9f3c7;'>";
			str += "	  <td class='text-center review_pk small pt-3'>내 리뷰</td>";
			str += "	  <td class='rv_title pt-3'>" + list[0].rv_title + "</td>";
			str += "	  <td class='text-center score text-warning' style='font-size:20px;'>";
			str += makeStars(list[0].score)
			str += "	  </td>";
			str += "<td class='text-center userid pt-3'>" + list[0].userid + "</td>";
			str += "<td class='text-center rv_date pt-3'>" + list[0].rv_date + "</td>";
			str += "</tr>";
		}
		else {			  // 작성한 리뷰가 없을때
			str = "<tr class='text-center bg-secondary' style='background: #f9f3c7;'>" +
			"<td colspan='5'>" +
			"<a href='/user/login' class='text-white btn-review-write'>작성하신 리뷰가 없습니다. 리뷰를 작성하시려면 이 곳을 클릭해주세요.</a>" +
			"</td>" +
			"</tr>";
		}
		$(".myreviewTB").html(str);
	})
}

function showList(page) {
	var reviewTB = $(".reviewTB");
	
	reviewService.getList(
	{
		movie_pk : movie_pk,
		page : page
	},
	function(reviewCnt, score, list) {
		var str = "";
		var cnt;
		for (var i = 0; i < list.length; i++) {
			str += "<tr data-review_pk="+list[i].review_pk+">";
			str += "	  <td class='text-center review_pk'>" + list[i].review_pk + "</td>";
			str += "	  <td class='rv_title'>" + list[i].rv_title + "</td>";
			str += "	  <td class='text-center score text-warning' style='font-size:20px;'>";
			str += makeStars(list[i].score)
			str += "	  </td>";
			str += "<td class='text-center userid'>" + list[i].userid + "</td>";
			str += "<td class='text-center rv_date'>" + list[i].rv_date + "</td>";
			str += "</tr>";
			
			//useridList.push(list[i].userid);
		}
		reviewTB.html(str);
		$("#scoreResult").html(makeStars(score));
		$("#scoreValue").html(score);
		showReplyPage(reviewCnt); // reviewCnt를 호출
	});		
}

var apilogin = "${loginStat.apiLogin}";
$(function() {
	showList();
	var modal = $(".modal");
	var modalInputRv_title = modal.find("input[name=title]");
	var modalInputRv_content = modal.find("textarea[name=content]");
	var modalInputScore = modal.find("select[name=score]");
	var modalInputFilename = modal.find("input[name=filename]");
	var modalInputUserid = "${loginStat.userid}";
	var modalInputM_title = $("#mtitle");
	var modalModBtn = $("#modBtn");
	var modalRemoveBtn = $("#rmBtn");
	var modalRegisterBtn = $("#regBtn");
	
	$(".reviewTB, .myreviewTB").on("click", "tr[data-review_pk]", function(e) {
		var review_pk = $(this).data("review_pk");
		var userid = $(this).find(".userid").html();
		
		reviewService.get(review_pk, function(myreview) {
			modalInputRv_title.val(myreview.rv_title);
			modalInputRv_content.val(myreview.rv_content);
			modalInputScore.val(myreview.score);
			
			modal.data("movie_pk", myreview.movie_pk);
			modal.data("review_pk", myreview);
			modalModBtn.show();
			modalRemoveBtn.show();

			$(".modal").modal("show");
			
			if(modalInputUserid == userid) {
				modal.find("#regBtn").hide();
				
			} else {
				modal.find("#regBtn").hide();
				modal.find("#modBtn").hide();
				modal.find("#rmBtn").hide();
				return false;
			}
		});
	});
	
	$(document).on("click", ".btn-review-write", function(e) {
		event.preventDefault();
		if(apilogin == 1) {
			alert("간편로그인 사용자는 리뷰쓰기를 할 수 없습니다. \n일반회원으로 로그인 후 이용해주세요.");
			return false;
		}
		
		if(!modalInputUserid) {
			alert("로그인 후 다시 시도해주세요.");
			return false;
		}
		
		reviewService.getListMyReview(movie_pk, modalInputUserid, function(list) {
			if(list.length) {
				alert("동일 영화에 1개의 리뷰만 작성할 수 있습니다.");
				return false;
			}
			modal.find("input, textarea").val("");
			modal.find("select").val("10");
			modal.find("button").hide();
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		})
	});
	
	$("#regBtn").on("click", function(e) {
		if(inputTitle.value.trim() == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if(inputContent.value.trim() == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
	});
	
	$(".myreview-btn").on("click", function(e) {
		if(apilogin == 1) {
			alert("간편로그인 사용자는 리뷰쓰기를 할 수 없습니다. \n일반회원으로 로그인 후 이용해주세요.");
			return false;
		}
		
		if(modalInputUserid != '') {
			
		} else {
			alert("로그인 후 다시 시도해주세요.")
			return false;
		}
	});
	
	modalRegisterBtn.on("click", function(e) {
		var myreview = {
			rv_title : modalInputRv_title.val(),
			rv_content : modalInputRv_content.val(),
			score : modalInputScore.val(),
			userid : modalInputUserid,
			movie_pk : movie_pk
		};

		reviewService.insert(myreview, function(result) {
			alert("리뷰가 성공적으로 작성되었습니다.");

			modal.find("input").val("");
			modal.modal("hide");
			pageNum = 1;
			showList(1);
			showMyReview();
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
			review_pk : modal.data("review_pk").review_pk,
			rv_title : modalInputRv_title.val(),
			rv_content : modalInputRv_content.val(),
			score : modalInputScore.val(),
			userid : modalInputUserid
			
		}, function(result) {
			alert("내가 쓴 리뷰 수정이 완료되었습니다");

			modal.modal("hide");
			showList(pageNum);
			showMyReview();
		});
	});
	
	modalRemoveBtn.click(function() {
		reviewService.remove(modal.data("review_pk").review_pk, function() {
			alert("내가 쓴 리뷰가 삭제 완료되었습니다.");

			modal.modal("hide");
			showList(pageNum);
			showMyReview();
			useridList.splice(useridList.indexOf(userid), 1);
		})
	});
	
	showMyReview();
});

var reviewService = (function() {
	function getList(myreview, callback, error) {
		var movie_pk = myreview.movie_pk;
		var page = myreview.page || 1;
		
		$.getJSON("/review/list/" + movie_pk + "/" + page,
			function(data) {
				if(callback) {
					callback(data.reviewCnt, data.score, data.list);
				}
			}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function getListMyReview(movie_pk, userid, callback, error) {
		$.get("/review/getMyReview/" + movie_pk + "?userid=" + encodeURIComponent(userid), function(result) {
			if(callback) {
				callback(result);
			}	
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function get(review_pk, callback, error) {
		$.get("/review/get/" + review_pk, function(result) {
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	function insert(myreview, callback, error) {
		$.ajax({
			type : 'post',
			url : '/review/insert',
			data : JSON.stringify(myreview),
			contentType : "application/json; charset=UTF-8",
			success : function(result) {
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
		getListMyReview : getListMyReview,
		insert : insert,
		getList : getList,
		get : get,
		remove : remove,
		modify : modify
	};		
})();

</script>
</head>

<body>
	<jsp:include page="../includes/header.jsp" />
	<main>
	<section class="index-movie mt-5 mx-auto">
		<div class="d-flex justify-content-center mt-3"><h2 class="movie-detail-title mt-5 mb-4">MOVIE DETAIL</h2></div>
		<div class="button-nav d-flex justify-content-center mb-5 index-movie-btn-group">
		<div class="bg-white px-4">
			<a href="/movie/movieChart"><button type="button" class="run-now btn btn-dark">전체 영화목록 보기</button></a>
		</div>
		</div>
		
		<div class="row mx-auto container-fluid">
			<!-- 포스터 부분 -->
			<div class="col-xl-3 card-group mx-auto pl-0 poster-group">
				<div class="d-flex justify-content-center">
					<div class="ml-4">
						<img class="card-img-top" src="/${getMovieInfo.mainpost_img}" alt="Card image">
						<c:if test="${!isUpcomming}">
						<a href="/reservation/ticketing?movie_pk=${getMovieInfo.movie_pk}" class="btn btn-primary w-100">예매하기</a>
						</c:if>
					</div>
				</div>
			</div>
			<!-- 영화 상세정보 부분 -->
			<div class="col-xl-3 movie-detail-info mx-auto mt-3 w-100">
				<div class="container pl-0">
					<h2 class="ml-1">${getMovieInfo.m_title}</h2>
					<h5 class="ml-1">${getMovieInfo.m_title_eng}</h5>
				</div>
				<table class="table table-borderless table-sm">
					<tr>
						<th scope="row">장르</th>
						<td>${getMovieInfo.genre}</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">등급</th>
						<td>${getMovieInfo.watchgrade}</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">상영시간</th>
						<td>${getMovieInfo.runningtime}</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">개봉일자</th>
						<td>${getMovieInfo.opendate}</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">감독</th>
						<td>${getMovieInfo.director}</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">배우</th>
						<td>하단 내용 참고</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">예매율</th>
						<td>${getMovieInfo.reservation_rate}%</td>
					</tr>
					<tr>
						<th class="movieDetail-table-th">평론가 평점</th>
						<td>
							<div class="form-group clearfix">
								<span class="text" id="starScore">${getMovieInfo.score_avg}</span>점(10점만점)
							</div>
						</td>
					</tr>
				</table>
			</div>

			<!-- 줄거리 부분 -->
			<div class="col-xl-5 movie-detail-info mx-auto mt-3 w-100 p-0">
				<h4>배우</h4>
				<div class="row">
					<c:forEach items="${getMovieInfo.actorlist}" var="actor">
					<div class="card card-wrapper border-0 mt-3 col-sm-3">
						<img class="card-img-top mt-3 mx-auto" src="/images/${getMovieInfo.movie_pk}/${actor.actor_img}"
							alt="Card image">
						<div class="card-body text-center p-0 mt-2">
							<p class="card-title mb-1 font-weight-bolder">${actor.actor_name}</p>
							<p class="card-text">${actor.a_cast}</p>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="container mt-5 mx-auto">
			<div class="col">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs">
					<c:if test="${!isUpcomming}">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#reviewList">리뷰</a></li>
					</c:if>
					<li class="nav-item"><a class="nav-link ${isUpcomming ? 'active' : '' }" data-toggle="tab"
						href="#plot">줄거리</a></li>
				</ul>
			</div>

			<!-- Tab panes -->
			<div class="tab-content">
				<c:if test="${!isUpcomming}">
				<div id="reviewList" class="container tab-pane active">
					<!-- 리뷰 전체 부분 시작 -->
					<div class="col mx-auto p-0">
						<!-- 리뷰(버튼 부분, 리뷰쓰기 모달창) 시작 -->
						<div class="container row">
							<div class="col p-0 mt-3 mb-3">
								<!-- Button to Open the Modal -->
								<div class="container">
									<div class="container float-left row w-50">
										<div class="mt-1">
											<p class="font-weight-bold scoreBox">관람객 평점</p>
										</div>
										<div class="active row ml-3">
											<span id="scoreResult" class="text-warning"></span>
										</div>
										<div class="mt-1 ml-2">
											<p class="ml-2 scoreBox">(<span id="scoreValue" class="scoreBox"></span>)</p>
										</div>
									</div>
									<div class="float-right row pr-0">
										<div>
											<button type="button" class="btn btn-info m-1 btn-review-write" >리뷰쓰기</button>
										</div>
										<div>
											<a href="/myPage/myPageReview" class="btn btn-info mt-1 myreview-btn">나의 리뷰 목록</a>
										</div>
									</div>
								</div>
								<!-- 리뷰쓰기 모달 창 시작 부분 -->
								<div class="modal fade" id="myModal">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<!-- Modal Header -->
											<div class="container">
												<button type="button" class="close" data-dismiss="modal">×</button>
											</div>
											<!-- Modal body 시작 -->
											<div class="modal-body mt-3">
												<div class="container">
													<div class="row">
														<div class="col-lg-11 mx-auto modal-body2">
															<div class="card flex-row mb-3 modal-body2">
																<div class="card-body modal-body3">
																	<form class="form-signin" role="form"
																		action="/review/insert" method="post">
																		<h3 class="text-center font-weight-bolder">${getMovieInfo.m_title}</h3>
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
																				<label for="sel2"><strong>평점</strong></label> <select
																					class="custom-select form-control" id="sel2"
																					name="score">
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
																			<%-- ${loginStat.userid} --%>
																			<input type="hidden" name="userid" value="${loginStat.userid}">
																			<div class="modal-footer">
																				<button class="btn btn-warning btn-block"
																					type="button" id="modBtn">수정</button>
																				<button class="btn btn-danger btn-block"
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
						<!-- 리뷰 게시판 시작 -->
						<div class="container-fluid p-0">
							<div class="table-responsive table-responsive">
								<table class="table table-hover review-table">
									<thead class="text-center font-weight-bold">
										<tr>
											<td>NO</td>
											<td>제목</td>
											<td>평점</td>
											<td>작성자</td>
											<td>작성일자</td>
										</tr>
									</thead>
									<tbody class="myreviewTB">
										
									</tbody>
									<tbody class="reviewTB ">
										<%-- ${getReviewList.list} --%>
									</tbody>
								</table>
							</div>
						</div>
						<!-- 리뷰 게시판 종료 -->
						<!-- pagination 시작 -->
						<div class="container mt-4">
							<ul class="pagination justify-content-center">
								<li class="page-item"><a class="page-link" href="#">&lt;&lt;</a></li>
								<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
								<li class="page-item active"><a class="page-link" href="1">1</a></li>
								<li class="page-item"><a class="page-link" href="2">2</a></li>
								<li class="page-item"><a class="page-link" href="3">3</a></li>
								<li class="page-item"><a class="page-link" href="4">4</a></li>
								<li class="page-item"><a class="page-link" href="5">5</a></li>
								<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
								<li class="page-item"><a class="page-link" href="#">&gt;&gt;</a></li>
							</ul>
						</div>
						<!-- pagination 종료 -->
					</div>
					<!-- 리뷰 전체 부분 종료 -->
				</div>
				</c:if>
				<div id="plot" class="container tab-pane fade mt-3 ${isUpcomming ? 'active show' : '' }">
					<p>${getMovieInfo.plot}</p>
				</div>
			</div>
		</div>

		<section class="index-event">
			<div class="d-flex justify-content-center mb-5 index-event-btn mx-auto">
				<div class="px-3 bg-white">
					<div>
						<p class="mb-0 pt-1">예고편</p>
					</div>
				</div>
			</div>
			<div class="embed-responsive embed-responsive-16by9">${getMovieInfo.trailer}</div>
		</section>

		<section class="index-event">
			<div class="d-flex justify-content-center mb-5 index-event-btn mx-auto ">
				<div class="px-3 bg-white">
					<div>
						<p class="mb-0 pt-1">스틸컷</p>
					</div>
				</div>
			</div>
		</section>

		<!--Carousel Wrapper-->
		<div>
			<div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails" data-ride="carousel">
				<!--Slides-->
				<div class="carousel-inner" role="listbox">
					<div class="carousel-item active">
						<img class="d-block w-50 mx-auto" src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[0].stillcut_img}" alt="First slide">
					</div>
					<div class="carousel-item">
						<img class="d-block w-50 mx-auto" src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[1].stillcut_img}" alt="Second slide">
					</div>
					<div class="carousel-item">
						<img class="d-block w-50 mx-auto" src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[2].stillcut_img}" alt="Third slide">
					</div>
				</div>
				<!--/.Slides-->
				<!--Controls-->
				<a class="carousel-control-prev" href="#carousel-thumb"	role="button" data-slide="prev"> 
					<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
					<span class="sr-only">Previous</span>
				</a> 
				<a class="carousel-control-next" href="#carousel-thumb"	role="button" data-slide="next"> 
					<span class="carousel-control-next-icon" aria-hidden="true"></span> 
					<span class="sr-only">Next</span>
				</a>
				<!--/.Controls-->
				<ol class="carousel-indicators">
					<li data-target="#carousel-thumb" data-slide-to="0" class="active">
						<img src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[0].stillcut_img}" width="100" alt="First">
					</li>
					<li data-target="#carousel-thumb" data-slide-to="1">
						<img src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[1].stillcut_img}" width="100" alt="Second">
					</li>
					<li data-target="#carousel-thumb" data-slide-to="2">
						<img src="/images/${getMovieInfo.movie_pk}/${getMovieInfo.stillcutlist[2].stillcut_img}" width="100" alt="Third">
					</li>
				</ol>
			</div>
		</div>
		<!--/.Carousel Wrapper-->
	</section>
	</main>
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>