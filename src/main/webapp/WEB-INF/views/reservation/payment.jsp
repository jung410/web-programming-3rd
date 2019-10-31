<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>GGV :: 영화결제</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/Ticketing.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="/js/payment.js"></script>

</head>

<body class="py-4 mt-5">
	<jsp:include page="../includes/header.jsp" />

	<main>


	<form method="post">

		<div class="container text-white">

			<div class="row top-col">
				<div class="col-12 themed-grid-col">결제수단</div>
			</div>
			<div class="row body-col ">
				<!-- <div class="col-1"></div> -->
				<div class="p-2 pl-2  mx-auto ">
					<div class="border-bottom p-2">
						<h2>신용카드</h2>
					</div>
					<div class="border-bottom p-2">
						<div class="row">
							<div class="col-md-3 d-inline">
								<label class=" d-inline">카드목록</label>
							</div>
							<div class="col-md-3 pl-2">

								<select class="form-control">
									<option>국민 은행</option>
									<option>기업 은행</option>
									<option>우리 은행</option>
									<option>농협 은행</option>
								</select>
							</div>
						</div>
					</div>
					<div class="border-bottom p-2">
						<div class="row">
							<div class="col-md-3 w-75">
								<p>카드번호</p>
							</div>
							<div class="col-md-7 ml-2">
								<div class="row">

									<div class="col-3 p-0">
										<input type="text" id="cardno1"
											class="form-control w-75 d-inline " maxlength="4">
									</div>
									<div class="col-3 p-0">
										<input type="text" id="cardno2"
											class="form-control w-75 d-inline" maxlength="4">
									</div>
									<div class="col-3 p-0">
										<input type="text" id="cardno3"
											class="form-control w-75 d-inline" maxlength="4">
									</div>
									<div class="col-3 p-0">
										<input type="text" id="cardno4"
											class="form-control w-75 d-inline" maxlength="4">
									</div>
									
								</div>
							</div>
						</div>
					</div>
					<div class="border-bottom p-2">
						<div class="row">
							<div class="col-md-3 w-75">
								<p>유효기한</p>
							</div>
							<div class="col-md-7 ml-2">
								<div class="row">

									<div class="col-4 p-0">
										<input type="text" class="form-control w-50 mr-1 d-inline"
											id="month" maxlength="2">
										<h6 class="d-inline">월</h6>
									</div>
									<div class="col-4 p-0">
										<input type="text" class="form-control w-50 mr-1 d-inline"
											id="year" maxlength="2">
										<h6 class="d-inline">년</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="border-bottom p-2">
						<div class="row  ">
							<div class="col-md-3 w-75">
								<p>비밀번호</p>
							</div>
							<div class="col-md-2 p-0 ml-2">
								<input type="password" id="cardpw"
									class="form-control w-50 mr-1 d-inline"  maxlength="2">
								<h3 class="d-inline">* *</h3>
							</div>
						</div>
					</div>
					<div class="border-bottom p-2">
						<div class="row ">
							<div class="col-md-3 w-75">
								<p>생년월일</p>
							</div>
							<div class="col-md-7 ml-2">
								<div class="row">

									<div class="col-6 p-0">
										<input type="text" id="birth"
											class="form-control w-75 mr-3 d-inline"  maxlength="6">
										<h4 class="d-inline">-</h4>
									</div>
									<div class="col-6 p-0">
										<h3 class="d-inline">* * * * * * *</h3>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="col-1"></div> -->
			</div>

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
								<div class="col-5">
									<img class="w-100 h-100 text-center" src="/${scrData.mainpost_img }" alt="">
								</div>
								<div class="col-7">
									<p class="mt-5">${scrData.m_title }</p>
								</div>
							</div>
						</div>
						<div class="col-7 themed-grid-col border-0">
							<table class="ml-1 mt-3 mb-2"  >
								<tr>
									<th>극장</th>
									<td>:</td>
									<td>GGV ${scrData.location} ${scrData.t_address}</td>
								</tr>
								<tr>
									<th>일시</th>
									<td>:</td>
									<td>${scrData.scr_date}/ ${scrData.scr_time}</td>
								</tr>
								<tr>
									<th>상영관</th>
									<td>:</td>
									<td>${scrData.aud_name}</td>
								</tr>
								<tr>
									<th>좌석 번호</th>
									<td>:</td>
									<td>
										<c:forEach items="${seatPk}" var="seat">
											${seat.seat_name}${seat.seat_num}
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="col-md-2 themed-grid-col p-1 ">
					<div class="hiddenValue">
						<input type="hidden" value="${param.reservationPk}"
							name="reservationPk">
					</div>
					<button type="submit" class="btn  btn-danger w-100  nextBtn">결제 완료</button>
					<!-- <button type="submit" class="btn btn-danger w-100 h-75" >결제하기</button> -->
					<input type="button" class="btn  btn-danger w-100  mt-1 cancleBtn"
						onclick="history.go(-3);" value="결제취소">
				</div>
			</div>
		</div>
	</form>

	<!-- /container --> </main>
	<jsp:include page="../includes/footer.jsp" />
</body>

</html>
