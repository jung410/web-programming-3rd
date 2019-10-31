<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <title>GGV</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="js/index.js"></script>
    <script>
    
    init();
    
    function init(stat){ 						// 파라미터
		$.ajax("/movie/onoff", {
			data:{stat:stat||"movieChart"}, 	// 키:값||기본값(movieChart)  
			success:function(data){
				var now = new Date().getTime(); // 개봉예정작(기존 예매율 대신 개봉일자) 내용 작업 위해 작성 
				var str = "";
				for(var i = 0; i < 4; i++) {
				    str+="				<div class=\"col d-flex justify-content-center mb-4\">\r\n";
				    str+="                    <div class=\"card\">\r\n";
				    str+="	                    <div class=\"h-75\">\r\n";
				    str+="			          		<img class=\"card-img-top\" src=\"/"+data[i].mainpost_img+"\" alt=\"Card image\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\""+data[i].m_title+"\">\r\n"; 
				    str+="			          	</div>\r\n";
				    str+="                        <div class=\"card-body\">\r\n";
				    str+="                             <h4 class=\"card-title\">"+data[i].m_title+"</h4>\r\n";
				    if(now < new Date(data[i].opendate).getTime()) {
						str += "			<p>개봉일자 : " + data[i].opendate	+ "</p>\r\n";
						str += "			<div class=\"d-flex justify-content-around\">\r\n";
					}
					else {
						str += "			<p>예매율 : " + data[i].reservation_rate	+ "%</p>\r\n";
					    str +="             <div class=\"float-left\">\r\n"; 
					}
				    str+="				             <a href=\"/movie/movieDetail/"+data[i].movie_pk+"\" class=\"btn btn-primary btn-sm\">상세보기</a>\r\n"; 
				    str+="				             </div>\r\n";
		 		    if(stat != 'upComing') {
					    str+="				             <div class=\"float-right\">\r\n"; 
					    str+="			             	 <a href=\"/reservation/ticketing?movie_pk="+data[i].movie_pk+"\" class=\"btn btn-primary btn-sm\">예매하기</a>\r\n"; 
					    str+="			             	 </div>\r\n";
		 		    }
				    str+="                        </div>\r\n";
				    str+="                    </div>\r\n";
				    str+="               </div>";
				}
				$(".idx-chart-group").html(str);
			}
		})    	
    }
    
    $(function() {
    	$(".moviebtn button").click(function() {
    		init($(this).data("name"))
    	})
    })
    
    </script>
</head>


<body>
    <jsp:include page="includes/header.jsp" />
    <!-- main 부분 시작 -->
    <main>
        <section class="index-carousel w-100 mt-4">
            <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel">
                <div class="carousel-inner mx-auto" role="listbox">
                    <div class="carousel-item active">
                        <img class="d-block w-100 mx-auto" src="images/82019170643_727.png" alt="First slide">
                        <div class="carousel-caption">
                            <h3>우주여행</h3>
                            <p>go to galaxy!</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100 mx-auto" src="images/82110170260_727.png" alt="Second slide">
                        <div class="carousel-caption">
                            <h3>나쁜녀석들</h3>
                            <p>bad person</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100 mx-auto" src="images/82078170845_727.png" alt="Third slide">
                        <div class="carousel-caption">
                            <h3>뮤직!</h3>
                            <p>play the music!</p>
                        </div>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </section>
        <section class="index-movie mt-5 mx-auto">
            <div class="button-nav d-flex justify-content-center mb-5 index-movie-btn-group">
                <div class="bg-white px-4 moviebtn">
                    <button type="button" class="run-now btn btn-danger mr-4" data-name="movieChart">현재 상영작</button>
                    <button type="button" class="run-next btn btn-dark" data-name="upComing">개봉 예정작</button>
                </div>
            </div>
            
            <div class="card-group row mx-auto idx-chart-group">
                
            </div>
            
            <div class="float-right">
                <a href="movie/movieChart">+더보기</a>
            </div>
        </section>

        <section class="index-trailer mt-5">
            <div class="d-flex justify-content-center index-trailer-btn pt-4">
                <div>
                    <p class="mb-0 pt-1">예고편</p>
                </div>
            </div>
            <div class="embed-responsive embed-responsive-16by9 index-trailer-youtube mx-auto mt-4">
                <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/1OJZSa5258A" frameborder="0"
                    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen></iframe>
            </div>
        </section>

        <section class="index-event">
            <div class="d-flex justify-content-center mb-5 index-event-btn mx-auto ">
                <div class="px-3 bg-white">
                    <div>
                        <p class="mb-0 pt-1">이벤트</p>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center row">
                <img src="images/(240X200)CGV_web_banner.jpg" alt="">
                <img src="images/9_web.jpg" alt="">
                <img src="images/1905_113_wb.jpg" alt="">
                <img src="images/1909_040_wb_240x200.jpg" alt="">
                <img src="images/dmf(240x200).jpg" alt="">
                <img src="images/megi.jpg" alt="">
                <img src="images/megi2.jpg" alt="">
            </div>
        </section>
    </main>
    <!-- main 부분 종료 -->
    <jsp:include page="includes/footer.jsp" />
</body>

</html>