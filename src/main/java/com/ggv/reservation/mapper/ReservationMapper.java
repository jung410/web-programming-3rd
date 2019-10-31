package com.ggv.reservation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggv.movie.domain.MovieVO;
import com.ggv.reservation.domain.MyResvSeatVO;
import com.ggv.reservation.domain.MyResvVO;
import com.ggv.reservation.domain.ReservationVO;
import com.ggv.reservation.domain.ReservedseatVO;
import com.ggv.reservation.domain.ScreeningVO;
import com.ggv.reservation.domain.SeatVO;
import com.ggv.reservation.domain.TicketingVO;

public interface ReservationMapper {
public List<MovieVO> movieView();
	
	public TicketingVO movieTitle(Integer movie_pk);
	public List<TicketingVO> movieTitleList();
	public List<TicketingVO> theaterListbyMovie_pk(Integer movie_pk);
	public List<TicketingVO> theaterListbyMovie_pkLocation(@Param("movie_pk")Integer movie_pk,@Param("location")String location);
	public List<TicketingVO> dateListbyAll(@Param("movie_pk") Integer movie_pk,@Param("location") String location,@Param("t_address") String t_address);
	public List<TicketingVO> timeList(@Param("movie_pk") Integer movie_pk,@Param("location") String location,@Param("t_address") String t_address,@Param("scr_date") String scr_date);
	public List<TicketingVO> ticketList2(@Param("movie_pk") Integer movie_pk,@Param("location") String location,@Param("t_address") String t_address,@Param("scr_date") String scr_date,@Param("aud_name") String aud_name,@Param("scr_time") String scr_time);
	public void reservationInsert(ReservationVO reservationVO);
	public void reservationInsertKakao(ReservationVO reservationVO);
	public void reservedseatInsert(ReservedseatVO reservedseatVO);
	public List<ReservationVO> reservationList();
	public List<ReservedseatVO> reservedseatList();
	
	public List<SeatVO> reservedseatListforPk(Integer reservation_pk_no);
	
	public List<ReservedseatVO> reservedseatListforSeatScr();
	public void paymentUpdate(ReservationVO reservationVO);
	public int reservationDelete(Integer reservation_pk);
	public int reservedseatDelete(Integer reservation_pk_no);
	
	public List<MyResvVO> getMyreservation(String userid);
	public List<MyResvVO> getMyreservationByKakao(String kakaouserid);
	public List<MyResvVO> getCancled(String userid);
	public List<MyResvVO> getCancledByKakao(String kakaouserid);
	public void cancleResv(Integer reservation_pk);
	public List<MyResvVO> getWachedMovie(String userid);
	public List<MyResvVO> getWachedMovieByKakao(String kakaouserid);
	public void removeResvSeat(String userid);
	public void removeResv(String userid);
	public void removeResvSeatByKakao(String userid);
	public void removeResvByKakao(String userid);
	
	public List<MyResvSeatVO> getMyreservationSeat(Integer reservation_pk);
	
	public List<ReservationVO> getPayment();
	
	public TicketingVO getScrData(Integer scr_pk);
}
