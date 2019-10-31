package com.ggv.reservation.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.reservation.domain.MyResvSeatVO;
import com.ggv.reservation.domain.MyResvVO;
import com.ggv.reservation.domain.ReservationVO;
import com.ggv.reservation.domain.ReservedseatVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReservationServiceTests {
	@Setter
	@Autowired
	private ReservationServiceImpl res;
	
	@Test
	public void testMovieTitle() {
		log.info(res.movieTitle(1));
	}
	@Test
	public void testScrMovieTitleList() {
		log.info(res.movieTitleList());
	}
	@Test
	public void testScrTheaterList2() {
		res.theaterListbyMovie_pk(2).forEach(log::info);
//		상영중인 극장 목록 (영화)
	}
	@Test
	public void testScrTheaterList22() {
		res.theaterListbyMovie_pkLocation(2, "서울").forEach(log::info);
//		상영중인 극장 목록 (영화)
	}
	@Test
	public void testScrDateList4() {
		res.dateListbyAll(2, "서울","건대").forEach(log::info);
//		상영일 목록 (영화 극장)
	}
	
	@Test
	public void testScrTimeList() {
		res.timeList(2,"서울","건대","2019/10/25").forEach(log::info);
		
//		상영관,시간 목록
	}
	@Test
	public void testScrPk2() {
		res.ticketList2(2,"서울","건대","2019/10/25","1관","09:00").forEach(log::info);
	}
	@Test
	public void testReservationInsert() {
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setUserid("test");
		reservationVO.setScr_pk_no(43);
		
		res.reservationInsert(reservationVO);
		
		log.info("testReservationInsert(생성된 pk번호) : "+reservationVO.getReservation_pk());
	}
	@Test
	public void testReservationInsert2() {
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setKakaouserid("jung4102@naver.com");
		reservationVO.setScr_pk_no(43);
		
		res.reservationInsertKakao(reservationVO);		
		log.info("testReservationInsert(생성된 pk번호) : "+reservationVO.getReservation_pk());
	}
	@Test
	public void testReservedseatInsert() {
		ReservedseatVO reservedseatVO = new ReservedseatVO();
		reservedseatVO.setSeat_pk_no(21);
		reservedseatVO.setScr_pk_no(43);
		reservedseatVO.setReservation_pk_no(209);
		
		res.reservedseatInsert(reservedseatVO);
		
		log.info("testReservationInsert(생성된 pk번호) : "+reservedseatVO.getReservedseat_pk());
	}
	@Test
	public void testReservedseatInsert1() {
		ReservedseatVO reservedseatVO = new ReservedseatVO();
		reservedseatVO.setSeat_pk_no(2);
		reservedseatVO.setScr_pk_no(61);
		reservedseatVO.setReservation_pk_no(30);
		
		res.reservedseatInsert(reservedseatVO);
		
		log.info("testReservationInsert(생성된 pk번호) : "+reservedseatVO.getReservedseat_pk());
	}
	
	@Test
	public void testPaymentUpdate() {
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setReservation_pk(209);
		res.paymentUpdate(reservationVO);
		
	}
	@Test
	public void testReservationList(){
		log.info(res.reservationList());
	}
	@Test
	public void testReservedseatList(){
		log.info(res.reservedseatList());
	}
	@Test
	public void testReservedseatListforSeatScr(){
		log.info(res.reservedseatListforSeatScr());
	}
	@Test
	public void testReservationDelete() {
		log.info(res.reservationDelete(204));
	}
	@Test
	public void testReservedseatDelete() {
		log.info(res.reservedseatDelete(206));
	}
	@Test
	public void testGetMyreservation() {
		List<MyResvVO> list = res.getMyreservation("test0");
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(res.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
	}
	@Test
	public void testGetMyreservationSeat() {
		res.getMyreservationSeat(298);
	}
	@Test
	public void testgetPayment() {
		res.getPayment().forEach(log::info);
	}
	
	@Test
	public void testDeletePayment() {
		List<ReservationVO> list = res.getPayment();
		for(int i = 0; i < list.size(); i++) {
			res.reservedseatDelete(list.get(i).getReservation_pk());
			res.reservationDelete(list.get(i).getReservation_pk());
		}
		res.getPayment().forEach(log::info);
	}
	
	@Test
	public void testGetScrData() {
		log.info(res.getScrData(81));
	}
	
	@Test
	public void testReservedseatListforPk() {
		res.reservedseatListforPk(297).forEach(log::info);
	}
}