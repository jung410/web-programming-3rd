<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<title>GGV :: 영화목록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/movieChart.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/js/index.js"></script>
<script src="/js/movieChart.js"></script>
<script>
init();
function init(stat) {
	$.ajax("/movie/onoff",
		{
		data : {stat : stat || "movieChart"},
		success : function(data) {
			var now = new Date().getTime();
			var str = "";
			for (var i = 0; i < data.length; i++) {
				str += "<div class=\"col-sm-3 d-flex justify-content-center mb-4\">\r\n";
				str += "	<div class=\"MovieListView_rank__1CZFi\">" + (i + 1) + "</div>\r\n";
				str += "	<div class=\"card\">\r\n";
				str += "		<div class=\"h-75\">\r\n";
				str += "			<img class=\"card-img-top\" src=\"/"+data[i].mainpost_img+"\" alt=\"Card image\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\""+data[i].m_title+"\">\r\n";
				str += "		</div>\r\n";
				str += "        <div class=\"card-body\">\r\n";
				str += "      		<h4 class=\"card-title\">" + data[i].m_title + "</h4>\r\n";
				if(now < new Date(data[i].opendate).getTime()) {
					str += "			<p>개봉일자 : "	+ data[i].opendate	+ "</p>\r\n";
					str += "			<div class=\"d-flex justify-content-around\">\r\n";
				}
				else {
					str += "			<p>예매율 : " + data[i].reservation_rate	+ "%</p>\r\n";
					str += "			<div class=\"float-left\">\r\n";
				}
				str += "				<a href=\"/movie/movieDetail/"+data[i].movie_pk+"\" class=\"btn btn-primary btn-sm\">상세보기</a>\r\n";
				str += "			</div>\r\n";
					if (stat != 'upComing') {
					str += "	<div class=\"float-right\">\r\n";
					str += "		<a href=\"/reservation/ticketing?movie_pk="	+ data[i].movie_pk + "\" class=\"btn btn-primary btn-sm upComing\">예매하기</a>\r\n";
					str += "	</div>\r\n";
					}
				str += "		</div>\r\n";
				str += "	</div>\r\n";
				str += "</div>";
			}
			$(".movie-chart-group").html(str);
		}
	})
}
	
$(function() {
	$(".moviebtn button").click(function() {
		init($(this).data("name"));
	})
});
</script>
</head>

<body>
	<jsp:include page="../includes/header.jsp" />
	<main>
	<section class="index-movie mt-5 mx-auto">
		<div class="d-flex justify-content-center mt-3">
			<h2 class="movie-detail-title text-center mt-5 mb-5">MOVIE CHART</h2>
		</div>
		<div class="button-nav d-flex justify-content-center mb-5 index-movie-btn-group">
			<div class="bg-white px-4 moviebtn">
				<button type="button" class="run-now btn btn-danger mr-4" data-name="movieChart">현재 상영작</button>
				<button type="button" class="run-next btn btn-dark" data-name="upComing">개봉 예정작</button>
			</div>
		</div>
		<%-- ${movieList} --%>
		<div class="card-deck row mx-auto movie-chart-group"></div>
	</section>
	</main>
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>