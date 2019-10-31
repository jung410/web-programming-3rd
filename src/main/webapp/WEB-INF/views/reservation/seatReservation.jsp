<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>GGV :: 좌석예약</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet" href="/css/seatReservation.css">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
$(function () {
	var param = "${param.scr_pk}"	

	var result = new Array();
	var result2 = new Array();

	<c:forEach items="${reservedseatList}" var="reservedseatList">
		var json = new Object();
		json.scrPk="${reservedseatList.scr_pk_no}";
		json.seatPk="${reservedseatList.seat_pk_no}";
		json.resPk = "${reservedseatList.reservation_pk_no}";
		result.push(json);
	</c:forEach>
	
	<c:forEach items="${reservationList}" var="reservationList">
		var jsonB = new Object();
		jsonB.paid = "${reservationList.is_paid}"
		jsonB.payment="${reservationList.payment}";
		jsonB.scrPk1 = "${reservationList.scr_pk_no}";
		jsonB.resPk1 = "${reservationList.reservation_pk}";
		
		result2.push(jsonB);
	</c:forEach>
	
	for(var i in result2){
		if(result2[i].scrPk1 == param){
			if(result2[i].paid == 1 || result2[i].paid == "1"){
			for(var j in result){
				if(result2[i].scrPk1 == result[j].scrPk){
					
					if(result2[i].resPk1 == result[j].resPk){
							$("input[value="+result[j].seatPk+"]").attr( "disabled", true );
							$("input[value="+result[j].seatPk+"]").parent().removeClass( "btn-outline-primary" );
						}
					}
				}	
			}	
		}
	}	
	
	$("#selcnt").change(function () {
		$(".nextBtn").attr( 'disabled', true );
	})

})
</script>
</head>
<body class="py-4 mt-5">
	<jsp:include page="../includes/header.jsp" />

	<main>
	<form method="post">
	<input type="hidden" name="scr_pk_no" value="${param.scr_pk}">
	<input type="hidden" name="reservation_pk_no" value="${reservationPk}">
	<input type="hidden" name="reservation_pk_no" value="${reservationPk}">
	
	<div class="container text-white">
		<div class="row top-col text-center">
			<div class="col-12 themed-grid-col">인원 / 좌석</div>
		</div>
		<div class="row body-col">
			<div class="col-md-6 themed-grid-col pt-4 d-inline">
				<label class="pl-2 pr-1 d-inline">인원</label> 
				<select id="selcnt">
					<!-- <option value="0">0명</option>s -->
					<option value="1" selected="selected">1명</option>
					<option value="2">2명</option>
					<option value="3">3명</option>
					<option value="4">4명</option>
					<option value="5">5명</option>
					<option value="6">6명</option>
					<option value="7">7명</option>
					<option value="8">8명</option>
				</select>
			</div>
			<div class="col-md-6 themed-grid-col pt-3">
				<table class="ml-2">
					<tr>
						<th>극장</th>
						<td class="pr-2">:</td>
						<td>GGV 
							 ${scrData.location} ${scrData.t_address} / 상영관 : ${scrData.aud_name}</td>
					</tr>
					<tr>
						<th>일시</th>
						<td>:</td>
						<td>${scrData.scr_date} / ${scrData.scr_time}</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row mb-3 body-col d-block" style="overflow-x: auto;">
			<div class="themed-grid-col border-0" id="style-1">
				<br>
				<div class="row body-col">
					<!-- <div class="col-2 hiddenbar"></div> -->
					<div class="mx-auto border-0 ">
						<div class="screen-size mx-auto text-center ml-4">SCREEN</div>
						<!-- <a class="list-group-item-dark list-group-item-action text-center  list-group-item" data-toggle="list">SCREEN</a> -->
						<br>
						<div class="row ml-2">
							<!-- <div class="col-1"></div> -->
							<div class="col-2 text-center pt-4">
								<label>A</label><br> 
								<label class="mt-2">B</label><br>
								<label class="mt-2">C</label><br> 
								<label class="mt-2">D</label><br>
								<label class="mt-2">E</label><br>
							</div>
							<div class="col-10 heights pt-3 pb-4 list-group groups d-inline border-0" role="tablist" aria-orientation="vertical">
								<script src="/js/seatReservation.js"></script>
							</div>
						</div>
					</div>
				</div>
			</div>
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
								<img class="w-100 text-center" src="/${scrData.mainpost_img }" alt="">
							</div>
							<div class="col-7">
								<p class="mt-5">${scrData.m_title }</p>
							</div>
						</div>
					</div>
			
					<div class="col-7 themed-grid-col border-0">
						<table class="ml-1 mt-3">
							<tr>
								<th>극장</th>
								<td>:</td>
								<td>GGV ${scrData.location} ${scrData.t_address}</td>
							</tr>
							<tr>
								<th>일시</th>
								<td>:</td>
								<td>${scrData.scr_date} / ${scrData.scr_time}</td>
							</tr>
							<tr>
								<th>상영관</th>
								<td>:</td>
								<td>${scrData.aud_name}</td>
							</tr>
						</table>
					</div>
				
				</div>
			</div>
				
			<div class="col-md-2 themed-grid-col p-1 button-h">
				<button type="submit" class="btn  btn-danger w-100  nextBtn" disabled="disabled">결제하기</button>
			<!-- <input type="button" class="btn btn-danger w-100 h-75" value="결제하기" onclick="location.href='/reservation/payment'"> --> 
				<input type="button" class="btn  btn-danger w-100  mt-1 cancleBtn" onclick="history.go(-2);" value="예매취소">
			</div>
		</div>
	</div>
	</form>
	<!-- /container --> 
	</main>
	<jsp:include page="../includes/footer.jsp" />
</body>

</html>
