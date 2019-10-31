package com.ggv.reservation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.service.MovieService;
import com.ggv.reservation.domain.ReservationVO;
import com.ggv.reservation.domain.ReservedseatVO;
import com.ggv.reservation.domain.TicketingVO;
import com.ggv.reservation.service.ReservationService;
import com.ggv.reservation.service.ReservationServiceImpl;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/reservation")
public class RestReservationController {
	@Setter
	@Autowired
	private MovieService mov;
	@Setter
	@Autowired
	private ReservationService res;
	
	
	/*@GetMapping("/ticketing")
	public ResponseEntity<List<TicketingVO>> movieTitleList() {
		log.info("movieTitleList ------------------------");
		return new ResponseEntity<List<TicketingVO>>(
				res.movieTitleList(),HttpStatus.OK);
	}*/
	
	@GetMapping("/ticketing/{movie_pk}")
	public ResponseEntity<List<TicketingVO>> theaterListbyMovie_pk(
			@PathVariable("movie_pk") Integer movie_pk) {
		log.info("theaterListbyMovie_pk ------------------------" + movie_pk);
		return new ResponseEntity<List<TicketingVO>>(
				res.theaterListbyMovie_pk(movie_pk),HttpStatus.OK);
	}
	
	@GetMapping("/ticketing/{movie_pk}/{location}")
	public ResponseEntity<List<TicketingVO>> theaterListbyMovie_pkLocation(
			@PathVariable("movie_pk") Integer movie_pk, @PathVariable("location") String location) {
		log.info("theaterListbyMovie_pkLocation ------------------------");
		return new ResponseEntity<List<TicketingVO>>(
				res.theaterListbyMovie_pkLocation(movie_pk, location),HttpStatus.OK);
	}
	@GetMapping("/ticketing/{movie_pk}/{location}/{t_address}")
	public ResponseEntity<List<TicketingVO>> dateListbyAll(
			@PathVariable("movie_pk") Integer movie_pk, @PathVariable("location") String location
			,@PathVariable("t_address") String t_address) {
		log.info("dateListbyAll ------------------------");
		return new ResponseEntity<List<TicketingVO>>(
				res.dateListbyAll(movie_pk, location,t_address),HttpStatus.OK);
	}
	
	@GetMapping("/ticketing/{movie_pk}/{location}/{t_address}/{scr_date}")
	public ResponseEntity<List<TicketingVO>> timeList(
			@PathVariable("movie_pk") Integer movie_pk, @PathVariable("location") String location
			,@PathVariable("t_address") String t_address,@PathVariable("scr_date") String scr_date) {
		log.info("timeList ------------------------");
		return new ResponseEntity<List<TicketingVO>>(
				res.timeList(movie_pk, location, t_address, scr_date),HttpStatus.OK);
	}
	
	@GetMapping("/ticketing/{movie_pk}/{location}/{t_address}/{scr_date}/{aud_name}/{scr_time}")
	public ResponseEntity<List<TicketingVO>> ticketList2(
			@PathVariable("movie_pk") Integer movie_pk, @PathVariable("location") String location
			,@PathVariable("t_address") String t_address,@PathVariable("scr_date") String scr_date
			,@PathVariable("aud_name") String aud_name,@PathVariable("scr_time") String scr_time) {
		log.info("ticketList2 ------------------------");
		return new ResponseEntity<List<TicketingVO>>(
				res.ticketList2(movie_pk, location, t_address, scr_date, aud_name ,scr_time),HttpStatus.OK);
	}
	
	
	
}
