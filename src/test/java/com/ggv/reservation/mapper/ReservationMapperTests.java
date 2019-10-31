package com.ggv.reservation.mapper;

import static org.junit.Assert.assertNotNull;

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
import com.ggv.reservation.domain.ScreeningVO;
import com.ggv.reservation.domain.TicketingVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.r;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReservationMapperTests {
	@Setter
	@Autowired
	private ReservationMapper mapper2;
	
	@Test
	public void testExist() {
		assertNotNull(mapper2);
	}
	@Test
	public void testMovieTitle() {
		
		log.info(mapper2.movieTitle(1));
	}
	
	@Test
	public void testScrMovieTitleList() {
		mapper2.movieTitleList().forEach(log::info);
//		상영중인 영화 목록
	}

	@Test
	public void testScrTheaterList2() {
		mapper2.theaterListbyMovie_pk(1).forEach(log::info);
//		상영중인 극장 목록 (영화)
	}
	@Test
	public void testScrTheaterList2_2() {
		mapper2.theaterListbyMovie_pkLocation(1,"서울").forEach(log::info);
//		상영중인 극장 목록 (영화)
	}
	@Test
	public void testScrDateList4() {
		mapper2.dateListbyAll(2, "서울","강남").forEach(log::info);
//		상영일 목록 (영화 극장)
	}
	
	@Test
	public void testScrTimeList() {
		mapper2.timeList(2,"서울","강남","2019/10/01").forEach(log::info);
//		상영관,시간 목록
	}
	@Test
	public void testScrPk2() {
		mapper2.ticketList2(2,"서울","강남","2019/10/01","2관","09:00").forEach(log::info);
	}
	
	@Test
	public void testReservation() {
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setUserid("test");
		reservationVO.setScr_pk_no(61);
		
		mapper2.reservationInsert(reservationVO);
		log.info(reservationVO);
	}
	@Test
	public void testReservedseatInsert() {
		ReservedseatVO reservedseatVO = new ReservedseatVO();
		reservedseatVO.setSeat_pk_no(1);
		reservedseatVO.setScr_pk_no(61);
		reservedseatVO.setReservation_pk_no(30);
		mapper2.reservedseatInsert(reservedseatVO);
		log.info(reservedseatVO);
	}
	@Test
	public void testReservedseatList(){
		mapper2.reservedseatList().forEach(log::info);
	}
	
	@Test
	public void testReservedseatListforPk(){
		mapper2.reservedseatListforPk(297).forEach(log::info);
	}
	
	@Test
	public void testReservationList(){
		mapper2.reservationList().forEach(log::info);
	}
	@Test
	public void testReservedseatListforSeatScr(){
		mapper2.reservedseatListforSeatScr().forEach(log::info);
	}
	@Test
	public void testPaymentUpdate() {
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setReservation_pk(71);
				
		mapper2.paymentUpdate(reservationVO);
	}
	@Test
	public void testReservationDelete() {
		mapper2.reservationDelete(205);
	}
	@Test
	public void testReservedseatDelete() {
		mapper2.reservedseatDelete(205);
	}
	
	@Test
	public void testGetMyreservation() {
		List<MyResvVO> list = mapper2.getMyreservation("test0");
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(mapper2.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
	}
	@Test
	public void testGetMyreservationSeat() {
		mapper2.getMyreservationSeat(298);
	}
	
	@Test
	public void testGetPayment() {
		mapper2.getPayment();
	}
	
	@Test
	public void testGetCancled() {
		mapper2.getCancled("test0").forEach(log::info);
	}
	
	@Test
	public void testGetCancledByKakao() {
		mapper2.getCancledByKakao("jung4102@naver.com").forEach(log::info);
	}
	
	@Test
	public void testGetScrData() {
		mapper2.getScrData(84);
		
	}
}
