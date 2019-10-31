package com.ggv.reservation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggv.member.mapper.MemberMapper;
import com.ggv.member.service.MemberServiceImpl;
import com.ggv.movie.domain.MovieVO;
import com.ggv.reservation.domain.MyResvSeatVO;
import com.ggv.reservation.domain.MyResvVO;
import com.ggv.reservation.domain.ReservationVO;
import com.ggv.reservation.domain.ReservedseatVO;
import com.ggv.reservation.domain.ScreeningVO;
import com.ggv.reservation.domain.SeatVO;
import com.ggv.reservation.domain.TicketingVO;
import com.ggv.reservation.mapper.ReservationMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ReservationServiceImpl implements ReservationService{

	@Setter
	@Autowired
	private ReservationMapper mapper;
	
	
	
	
	@Override
	public List<TicketingVO> theaterListbyMovie_pkLocation(Integer movie_pk, String location) {
		// TODO Auto-generated method stub
		return mapper.theaterListbyMovie_pkLocation(movie_pk, location);
	}

	@Override
	public List<TicketingVO> movieTitleList() {
		return mapper.movieTitleList();
	}

	@Override
	public List<TicketingVO> theaterListbyMovie_pk(Integer movie_pk) {
		// TODO Auto-generated method stub
		return mapper.theaterListbyMovie_pk(movie_pk);
	}



	@Override
	public List<TicketingVO> dateListbyAll(Integer movie_pk, String location, String t_address) {
		// TODO Auto-generated method stub
		return mapper.dateListbyAll(movie_pk, location, t_address);
	}

	@Override
	public List<TicketingVO> timeList(Integer movie_pk, String location, String t_address, String scr_date) {
		// TODO Auto-generated method stub
		return mapper.timeList(movie_pk, location, t_address, scr_date);
	}


	@Override
	public List<TicketingVO> ticketList2(Integer movie_pk, String location, String t_address, String scr_date,
			String aud_name ,String scr_time) {
		// TODO Auto-generated method stub
		return mapper.ticketList2(movie_pk, location, t_address, scr_date, aud_name, scr_time);
	}

	@Override
	public void reservationInsert(ReservationVO reservationVO) {
		// TODO Auto-generated method stub
		log.info("Reservationinsert "+reservationVO);
		mapper.reservationInsert(reservationVO);
	}

	@Override
	public void reservedseatInsert(ReservedseatVO reservedseatVO) {
		log.info("ReservedseatVO --"+reservedseatVO);
		/*int cnt = request.getparameters("aa").length();
		cnt = 5;
		for(5) {
			ReservedseatVO vo = new ReservedseatVO(1,request.getparameters("aa")[cnt],1,1);
			insert(vo);
		}
		ReservationVO rvo = new ReservationVO();
		 */
		mapper.reservedseatInsert(reservedseatVO);
		
		

	}
	
	@Override
	public TicketingVO movieTitle(Integer movie_pk) {
		log.info("MovieTitle");
		return mapper.movieTitle(movie_pk);
	}

	@Override
	public List<ReservationVO> reservationList() {
		// TODO Auto-generated method stub
		return mapper.reservationList();
	}
	@Override
	public List<ReservedseatVO> reservedseatList() {
		// TODO Auto-generated method stub
		return mapper.reservedseatList();
	}

	@Override
	public List<ReservedseatVO> reservedseatListforSeatScr() {
		// TODO Auto-generated method stub
		return mapper.reservedseatListforSeatScr();
	}

	@Override
	public void paymentUpdate(ReservationVO reservationVO) {
		// TODO Auto-generated method stub
		mapper.paymentUpdate(reservationVO);
	}

	@Override
	public void reservationInsertKakao(ReservationVO reservationVO) {
		// TODO Auto-generated method stub
		mapper.reservationInsertKakao(reservationVO);
	}

	@Override
	public boolean reservationDelete(Integer reservation_pk) {
		log.info(mapper.reservationDelete(reservation_pk));
		return false ;
	}

	@Override
	public boolean reservedseatDelete(Integer reservation_pk_no) {
		log.info(mapper.reservedseatDelete(reservation_pk_no));
		return false;
	}

	@Override
	public List<MyResvVO> getMyreservation(String userid) {
		// TODO Auto-generated method stub
		return mapper.getMyreservation(userid);
	}
	
	@Override
	public List<MyResvVO> getMyreservationByKakao(String kakaouserid) {
		// TODO Auto-generated method stub
		return mapper.getMyreservationByKakao(kakaouserid);
	}
	
	@Override
	public List<MyResvVO> getCancled(String userid) {
		// TODO Auto-generated method stub
		return mapper.getCancled(userid);
	}
	
	@Override
	public List<MyResvVO> getCancledByKakao(String kakaouserid) {
		// TODO Auto-generated method stub
		return mapper.getCancledByKakao(kakaouserid);
	}
	
	@Override
	public void cancleResv(Integer reservation_pk) {
		// TODO Auto-generated method stub
		mapper.cancleResv(reservation_pk);
	}
	
	@Override
	public List<MyResvVO> getWachedMovie(String userid) {
		// TODO Auto-generated method stub
		return mapper.getWachedMovie(userid);
	}

	@Override
	public List<MyResvVO> getWachedMovieByKakao(String kakaouserid) {
		// TODO Auto-generated method stub
		return mapper.getWachedMovieByKakao(kakaouserid);
	}
	
	@Override
	public List<MyResvSeatVO> getMyreservationSeat(Integer reservation_pk) {
		// TODO Auto-generated method stub
		return mapper.getMyreservationSeat(reservation_pk);
	}

	@Override
	public List<ReservationVO> getPayment() {
		// TODO Auto-generated method stub
		List<ReservationVO> list = mapper.getPayment();
		for(int i = 0; i < list.size(); i++) {
			mapper.reservedseatDelete(list.get(i).getReservation_pk());
			mapper.reservationDelete(list.get(i).getReservation_pk());
		}
		return mapper.getPayment();
	}

	@Override
	public TicketingVO getScrData(Integer scr_pk) {
		// TODO Auto-generated method stub
		
		return mapper.getScrData(scr_pk);
	}

	@Override
	public List<SeatVO> reservedseatListforPk(Integer reservation_pk_no) {
		// TODO Auto-generated method stub
		return mapper.reservedseatListforPk(reservation_pk_no);
	}

	@Override
	public void removeResvSeat(String userid) {
		// TODO Auto-generated method stub
		mapper.removeResvSeat(userid);
	}

	@Override
	public void removeResv(String userid) {
		// TODO Auto-generated method stub
		mapper.removeResv(userid);
	}

	@Override
	public void removeResvSeatByKakao(String userid) {
		// TODO Auto-generated method stub
		mapper.removeResvSeatByKakao(userid);
	}

	@Override
	public void removeResvByKakao(String userid) {
		// TODO Auto-generated method stub
		mapper.removeResvByKakao(userid);
	}
}
