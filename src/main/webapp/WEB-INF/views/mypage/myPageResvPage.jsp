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

            <div class="container-fluid">
                <div class="my-resv">
                    <div class="h4 mt-2">MY 예매 내역</div>
                    <div>
                        <span>지난 1개월 동안의 예매내역을 볼 수 있습니다.
                            <br>
                            <span class="text-danger">(1개월 이내라도 상영이 종료된 영화는 표시되지 않습니다.)</span>
                            <br>
                            <span class="text-danger">(상영 시작 시간이 빠른 순으로 정렬되어 표시됩니다.)</span>
                        </span>
                    </div>
                </div>
                <hr>
                <div class="my-resv-list">
                    <ul class="pl-0" style="list-style: none;">
                    	<c:forEach items="${myResvList}" var="myResvList">
                        <li>
                            <div class="d-flex row mt-4">
                                <div class="col-sm-4">
                                    <img src="/${myResvList.mainpost_img}" alt="" class="w-100">
                                    <br>
                                    <div class="mt-2 text-center">
                                        <span class="h4">${myResvList.m_title}</span>
                                        <img src="/images/age_15.png" class="m-poster">
                                    </div>
                                </div>
                                <div class="col-sm-8 row ml-2">
                                    <p class="h4"><span class="text-danger">예매번호 :</span><span class="ml-4">${myResvList.resv_num}</span></p>
                                    <div class="col-4 px-0">
                                        <p><span class="h4 text-primary">상영정보 :</span> </p>
                                    </div>
                                    <div class="col-6 px-0 mt-1 font-weight-bold">
                                        <p>${myResvList.scrdate}</p>
                                        <p>GGV ${myResvList.t_address}</p>
                                        <p>${myResvList.aud_name} / 
                                        	<c:forEach items="${myResvList.seatList}" var="seatList" varStatus="stat">
                                        	${seatList.seat_name}${seatList.seat_num}<c:if test="${not stat.last}">,</c:if>
                                        	</c:forEach>
                                        </p>
                                        <p>${myResvList.scrtime} ~ ${myResvList.src_endtime} (${myResvList.runningtime})</p>
                                    </div>
                                    <div>
                                    	<p><span>예매일자</span> : ${myResvList.resvdate}</p>
                                    </div>
                                    <div class="cancleBtn">
                                    	<form method="get" name="frm">
                                    		<input type="hidden" name="reservation_pk" value="${myResvList.reservation_pk}">
	                                		<button type="submit" class="btn btn-primary btn-sm movieCancleBtn">예매취소</button>
                                    	</form>
                                	</div>
                                </div>
                            </div>
                            <hr>
                        </li>
                    	</c:forEach>
                    </ul>
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