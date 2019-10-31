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
                    <div class="h4 mt-2">내가 본 영화</div>
                    <div>
                        <span>지난 5년 동안의 관람 영화를 확인할 수 있습니다.
                        </span>
                    </div>
                </div>
                <hr>
                <div class="container-fluid my-cancled">
                    <div class="my-cancled-list table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                                <tr>
                                    <th>영화명</th>
                                    <th>관람 GGV</th>
                                    <th>관람일시</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${myWatchedList}" var="myWatchedList">
                                <tr>
                                    <td class="align-middle font-weight-bold">${myWatchedList.m_title}</td>
                                    <td class="align-middle">GGV ${myWatchedList.t_address}</td>
                                    <td class="align-middle">
                                        ${myWatchedList.scrdate}
                                        <br>
                                        ${myWatchedList.scrtime} ~ ${myWatchedList.src_endtime}
                                        <br>
                                        <c:forEach items="${myWatchedList.seatList}" var="seatList" varStatus="stat">
                                       	${seatList.seat_name}${seatList.seat_num}<c:if test="${not stat.last}">,</c:if>
                                       	</c:forEach>
                                    </td>
                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
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