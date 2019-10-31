<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>GGV :: 영화예매</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet" href="/css/Ticketing.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>

var movie_pk;
var loc;
var t_address;
var scr_date;
var aud_name;
var scr_time;
var scr_pk;
var movieno = "${param.movie_pk}"

$(function() {
	if(movieno != 0){
		$("input[value="+movieno+"]").parent().addClass("active");
		$(".movieTitle").html($("input[value="+movieno+"]").parent().text());
		movie_pk = movieno;
		getMovieListAjax();
	} 
	$(".scrDate").on("click",".agree",function(){
		$(".scrDate label").removeClass("active");
		$(this).children().addClass("active");
	})
	
	$("#titleList div label").click(function() {
		$("#titleList label").removeClass("active");
		$(this).addClass("active");
		$(".movieTitle").html($(this).text());
		
		movie_pk = $(this).find(":radio").val();
		
		$(".locationList").html("");
		$(".addressList").html("");
		$(".dateList label").removeClass("active");
		$(".scrDate div").removeClass("agree");
		$(".scrDate div label").removeClass("btn-dark");
		$('.scrDate').hide();
		$(".timeList").html("");
		
		getMovieListAjax();
	}); 
	
	function getMovieListAjax () {
		$.getJSON("/reservation/ticketing/" + movie_pk, function(data) {
				
			for(var i in data) {
				$(".movieImg").html("<img class='w-100 text-center' src='/"+data[i].mainpost_img+"' alt=''>");
				var str = data[i].location;
				$(".locationList").append(
					"<div class='btn-group btn-group-toggle mb-2'><label class='btn btn-dark'><input type='radio' name='jb-radio2' value='"+str+"'>"+str+"</lable></div>"
				);
			}
		})
	};

	
	
	
	
	$(".c1 .locationList").on("click","label",function(e) {
		$(".locationList label").removeClass("active");
		$(this).addClass("active");
		loc= $(this).find(":radio").val();
		
		$(".addressList").html("");
		$(".dateList label").removeClass("active");
		$(".scrDate div").removeClass("agree");
		$(".scrDate div label").removeClass("btn-dark");
		$('.scrDate').hide();
		$(".timeList").html("");
		
		$(".locTitle").html("GGV "+loc)
		
		$.ajax({
			url : "/reservation/ticketing/" + movie_pk+"/"+loc+".json",
			type : "get",
			data : {},
			success : function(data) {

				for(var i in data) {
					$(".addressList").append(
						"<div class='btn-group btn-group-toggle mb-2'><label class='btn btn-dark'><input type='radio' name='jb-radio3' value='"+data[i].t_address+"'>"+data[i].t_address+"</lable></div>"
					);
				}
			}
		});
		return false;
	}); 
	$(".addressList").on("click","label",function(e) {
		$(".addressList label").removeClass("active");
		$(this).addClass("active");
		t_address =$(this).find(":radio").val();
		
		$(".dateList label").removeClass("active");
		$(".scrDate div").removeClass("agree");
		$(".scrDate div label").removeClass("btn-dark");
		$('.scrDate').hide();
		$(".timeList").html("");
		
		$(".addressTitle").html(t_address);
		
		$.ajax({
			url : "/reservation/ticketing/" + movie_pk+"/"+loc+"/"+t_address+".json",
			type : "get",
			data : {},
			success : function(data) {
				$('.scrDate').show();
				for(var i in data) {
					var scr_date=data[i].scr_date;
					$("input[value="+scr_date+"]").parent().parent().addClass("agree");
					$("input[value="+scr_date+"]").parent().addClass("btn-dark");
				}
			}
		});
	}); 
	
	$(".scrDate").on("click",".agree label",function(e) {
		$(".agree label").removeClass("active");
		$(this).addClass("active");
		scr_date = $(this).find(":radio").val();
		
		$(".timeList").html("");
		
		$(".dateTitle").html(scr_date);
		
		$.ajax({
			url : "/reservation/ticketing/" + movie_pk+"/"+loc+"/"+t_address+"/"+scr_date+".json",
			type : "get",
			data : {},
			success : function(data) {
				for(var i in data) {
					scr_time = data[i].scr_time;
					$(".timeList").append(
					"<div class='btn-group btn-group-toggle mb-2'><label class='btn btn-dark'><input type='radio' name='jb-radio5' value='"+ data[i].scr_time + "'/>"+ data[i].aud_name +"  :  "+ data[i].scr_time + " </label></div>"		
					);
				}
			}
		});
		return false;
	}); 
	$(".timeList").on("click","label",function(e) {
		$(".timeList label").removeClass("active");
		$(this).addClass("active");
		aud_name = $(this).text().substring(0,2)
		scr_time=$(this).find(":radio").val();
		
		$(".timeTitle").html(" / "+scr_time);
		$(".audTitle").html(aud_name);
		
		$.ajax({
			url : "/reservation/ticketing/" + movie_pk+"/"+loc+"/"+t_address+"/"+scr_date+"/"+ aud_name +"/"+ scr_time+".json",
			type : "get",
			data : {},
			success : function(data) {
				for(var i in data) {
				scr_pk = data[i].scr_pk;
				$(".scrPk").html('<input type="hidden"  name="scr_pk" value="'+ scr_pk +'">');
				}
				$(".nextBtn").removeAttr("disabled")
			}
		});
	
	});
 	

});
</script>
</head>

<body class="py-4 mt-5">
<jsp:include page="../includes/header.jsp" />
<main class="container mx-auto">

	<div class="text-white">

		<div class="row mb-3">
			<div class="col-md-4 themed-grid-col top-col text-center">
				<p>영화</p>
				<div class="row">
					<div class="col-md-12 themed-grid-col body-col heights"
						id="titleList" data-toggle="buttons" style="text-align: left;">
						<c:forEach items="${movie}" var="movie" varStatus="movieStat">
							<div class="btn-group btn-group-toggle mb-2">
								<label class="btn btn-dark"
									style="width: 330px; max-width: 330px; text-align: left;">
									<input type="radio" name="jb-radio" value="${movie.movie_pk}">
									${movie.m_title}
								</label>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-md-3 themed-grid-col top-col text-center">
				<p>극장</p>
				<div class="row">
					<div class="col-md-12 themed-grid-col body-col">
						<div class="container">
							<div class="row">
								<div class="col-6 c1">
									<div class="list-group locationList" role="tablist"></div>
								</div>
								<div class="col-6 c2">
									<div class="list-group addressList" role="tablist"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-5">
				<div class="row">
					<div class="col-3 themed-grid-col top-col text-center">
						<p>날짜</p>
						<div class="row">
							<div class="col-12 themed-grid-col text-center heights body-col ">
								<div class="scrDate">
									<p id="date-result-2" class="mb-1"></p>
									<p id="date-result-3" class="h2"></p>
									<div class="list-group list-color1 dateList" role="tablist">
										<script src="/js/ticketing.js"></script>
									</div>
								</div>

							</div>
						</div>
					</div>
					<div class="col-9 themed-grid-col top-col text-center">
						<p>시간</p>
						<div class="row">
							<div
								class="col-12 list-group list-color1 themed-grid-col body-col pl-3 timeList"
								role="tablist">
								<!-- <div class="or-seperator"><i>1관</i></div>
                  <a class="list-group-item list-group-item-action list-group-item-dark" data-toggle="list" href="#" >09 : 00</a>
                  <a class="list-group-item list-group-item-action list-group-item-dark" data-toggle="list" href="#" >11 : 00</a>
                  
                  <div class="or-seperator mt-4"><i>2관</i></div>
                  <a class="list-group-item list-group-item-action list-group-item-dark" data-toggle="list" href="#" >09 : 30</a>
                  <a class="list-group-item list-group-item-action list-group-item-dark" data-toggle="list" href="#" >11 : 30</a> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<form action="/reservation/seatReservation" method="get">
			<div class="row foot-col mt-3">
				<div class="col-md-2 border-0 pr-1 pl-1">
					<div class="themed-grid-col p-1   border-0  w-100 h-100">
						<input type="button" class=" w-100 h-100"
							onclick="history.go(-1);" value="영화">
					</div>
				</div>
				<div class="col-md-8 border-0">
					<div class="row">
						<div class="col-md-5 themed-grid-col p-1 border-0">
							<div class="row ">
								<div class="col-5 movieImg">
									<img class='w-100 text-center' src='' alt=''>
								</div>
								<div class="col-7">
									<p class="mt-5 movieTitle">영화 제목</p>
								</div>
							</div>
						</div>
						<div class="col-7 themed-grid-col border-0">
							<table class="ml-1 mt-3 p-2 mb-2">
								<tr>
									<th>극장</th>
									<td>:</td>
									<td>
										<a class='locTitle'></a>
										<a class='addressTitle'></a>
									</td>
								</tr>
								<tr>
									<th>일시</th>
									<td>:</td>
									<td>
										<a class='dateTitle'></a> 
										<a class='timeTitle'></a>
									</td>
								</tr>
								<tr>
									<th>상영관</th>
									<td>:</td>
									<td class='audTitle'></td>
								</tr>
							</table>
						</div>
						
					</div>
				</div>
				<div class="col-md-2 themed-grid-col p-1 ">
					<div class="scrPk"></div>
					<!-- <a href="/reservation/seatReservation/scr_pk?=" class="btn btn-danger w-100 h-75">결제하기</a>
            <div type="button" class="btn btn-danger w-100 h-75" value="결제하기" onclick="location.href='/reservation/seatReservation'"> -->
					<!-- <div class="btn  btn-danger w-100 h-75 nextBtn"><a>결제하기</a></div> -->
					<button type="submit" class="btn btn-danger w-100  nextBtn"
						disabled="disabled">좌석</button>
					<a class="btn btn-danger w-100  mt-1 cancleBtn"  onclick="history.go(-1);">예매취소</a>
				</div>
			</div>
		</form>
	</div>
	<!-- /container --> 
</main>
<jsp:include page="../includes/footer.jsp" />

</body>
</html>
