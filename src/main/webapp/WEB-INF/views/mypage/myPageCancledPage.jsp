<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                    <div class="h4 mt-2">MY 취소 내역</div>
                    <div>
                        <span>상영일 기준 지난 7일 동안의 취소 내역을 표시합니다.
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
                                    <th>예매 GGV</th>
                                    <th>관람일시</th>
                                    <th>취소일</th>
                                    <th>결제한 금액</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${myCancledList}" var="myCancledList">
                                <tr>
                                    <td class="align-middle font-weight-bold">${myCancledList.m_title}</td>
                                    <td class="align-middle">GGV ${myCancledList.t_address}</td>
                                    <td class="align-middle">
                                        ${myCancledList.scrdate}
                                        <br>
                                        ${myCancledList.scrtime} ~ ${myCancledList.src_endtime}
                                        <br>
                                        <c:forEach items="${myCancledList.seatList}" var="seatList" varStatus="stat">
                                       	${seatList.seat_name}${seatList.seat_num}<c:if test="${not stat.last}">,</c:if>
                                       	</c:forEach>
                                    </td>
                                    <td class="align-middle">${myCancledList.cancle_date}</td>
                                    <td class="align-middle">
                                    	<c:forEach items="${myCancledList.seatList}" var="seatList" varStatus="stat">
                                    	<c:if test="${stat.last}"><fmt:formatNumber type="number" maxFractionDigits="3" value="${stat.count * 10000}"/>원</c:if> 
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