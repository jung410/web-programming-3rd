<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		for (var i = 0; i < myreview.length; i++) {
		    str += "<tr data-review_pk="+myreview[i].review_pk+">";
			str += "	<td class='text-center m_title'>" + myreview[i].m_title + "</td>";
		    str += "	<td class='rv_title'>" + myreview[i].rv_title + "</td>"; 
		   	str += "	<td class='text-center score'>";
			str += 		myreview[i].score
			str += "	</td>";
			str += "</tr>";
		}
		reviewTB.html(str);
		
	});
}

var reviewService = (function() {
	function getList(userid, callback, error) {
		$.getJSON("/myPage/myPageMain/" + userid,
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
	
	return {
		getList : getList
	};		
})();
</script>
<style>
/* 2019.10.30 박소윤 내용추가(테이블 영화명 길이 관리 위해 사용) */
.tb-movie-name {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>
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
                <div class="my-resv d-flex">
                    <div class="h4 mt-2">MY 예매 내역</div>
                    <div class="ml-4 mb-1 d-flex align-items-end">
                    <c:forEach items="${myResvList}" var="myResvList" varStatus="stat">
                    <c:if test="${stat.last}">${stat.count}</c:if>
                    </c:forEach>
                    <c:if test="${empty myResvList}">0</c:if>
                    건
                    </div>
                    <div class="ml-1 mb-1 d-flex align-items-end"><a href="myPageResv"><i class="fa fa-plus-square"></i></a></div>
                </div>
                <div class="my-resv-list">
                    <ul>
                    	<c:forEach items="${myResvList}" var="myResvList" varStatus="stat">
                    	<c:if test="${stat.count <= 3}">
                        <li>
                            <div class="d-flex row mt-4">
                                <div class="col-5">
                                    <a href="/movie/movieDetail/${myResvList.movie_pk}"><span class="h4">${myResvList.m_title}</span></a>
                                </div>
                                <div class="col-7 d-flex justify-content-center">
                                    <span>${myResvList.scrdate}<br>GGV ${myResvList.t_address} ${myResvList.aud_name} ${myResvList.scrtime}</span>
                                </div>
                            </div>
                            <hr>
                        </li>
                        </c:if>
                    	</c:forEach>
                    </ul>
                </div>
            </div>
            <div class="container-fluid mt-5 my-review-container">
                <div class="my-review d-flex">
                    <div class="h4 mt-2">내가 쓴 리뷰</div>
                    <div class="ml-4 mb-1 d-flex align-items-end small">
                    	<p>*최근 작성한 리뷰 4건만 확인할 수 있습니다. <br>
                    	(자세한 내용은 내가 쓴 리뷰 페이지를 통해 확인 가능)</p>
                    </div>
                    <div class="ml-1 mb-3 d-flex align-items-end"><a href="/myPage/myPageReview"><i class="fa fa-plus-square"></i></a></div>
                </div>
                <div class="my-review-list table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th>영화명</th>
                                <th>리뷰 제목</th>
                                <th>평점</th>
                            </tr>
                        </thead>
                        <tbody class="reviewTB">
						    <c:forEach items="${getMyReviewMainList}" var="myreviewmain">         
                        	<tr>
                                <td class="tb-movie-name">${myreviewmain.m_title}</td>
                                <td>${myreviewmain.rv_title}</td>
                                <td>${myreviewmain.score}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
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