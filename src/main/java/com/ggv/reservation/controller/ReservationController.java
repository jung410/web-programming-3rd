package com.ggv.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;
import com.ggv.member.service.MemberService;
import com.ggv.movie.service.MovieService;
import com.ggv.reservation.domain.ReservationVO;
import com.ggv.reservation.domain.ReservedseatVO;
import com.ggv.reservation.domain.TicketingVO;
import com.ggv.reservation.service.ReservationService;
import com.sun.org.glassfish.gmbal.ParameterNames;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/reservation")
public class ReservationController {
	@Setter
	@Autowired
	private MovieService mov;
	@Setter
	@Autowired
	private ReservationService res;
	@Setter
	@Autowired
	private MemberService member;
	
	@GetMapping("/ticketing")
	public String ticketing(Model model, HttpSession session, HttpServletResponse resp) {
		log.info("ticketing..");
		/*model.addAttribute("movie", res.movieTitle(movie_pk));*/
		res.getPayment();
		if(session.getAttribute("loginStat") == null ) {
			member.addAlertScript("로그인 후 이용 가능합니다.", resp);
		}
		
		model.addAttribute("movie", res.movieTitleList());
		return "reservation/ticketing";
	}
	
	@GetMapping("/seatReservation")
	public String seatReservationGet(@RequestParam("scr_pk") Integer scr_pk, Model model, HttpSession session) {
		log.info("seatReservation..." + scr_pk);

		model.addAttribute("reservedseatList",res.reservedseatList());
		model.addAttribute("reservationList",res.reservationList());
		/*model.addAttribute("scr_pk", scr_pk);*/
		model.addAttribute("scrData", res.getScrData(scr_pk));
		
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setScr_pk_no(scr_pk);
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO KmemberVO = (KakaoMemberVO)session.getAttribute("loginStat");
			reservationVO.setKakaouserid(KmemberVO.getUserid());
			reservationVO.setResv_num("099-" + (int)(Math.random()*9998+1) + "-" + (int)(Math.random()*9998+1) + "-" + (int)(Math.random()*8+1));
			res.reservationInsertKakao(reservationVO);
		} else {
			MemberVO memberVO = (MemberVO)session.getAttribute("loginStat");
			reservationVO.setUserid(memberVO.getUserid());
			reservationVO.setResv_num("099-" + (int)(Math.random()*9998+1) + "-" + (int)(Math.random()*9998+1) + "-" + (int)(Math.random()*8+1));
			res.reservationInsert(reservationVO);
		}
		
		log.info(reservationVO);
		log.info(reservationVO.getReservation_pk());
		model.addAttribute("reservationPk",reservationVO.getReservation_pk());
		
		return "reservation/seatReservation";
	}
	@PostMapping("/seatReservation")
	public String seatReservationPost(Integer scr_pk, RedirectAttributes rttr,
			ReservedseatVO reservedseatVO,Model model,@RequestParam("seat_pk_no") Integer[] seat_pk_no) {
		log.info("seatReservationPost :_________---- " + reservedseatVO);
		log.info(seat_pk_no.length);
		log.info(seat_pk_no[0]);
		log.info("asdfjlaksjdfasdlkfjaksjdlfjalskdj"+scr_pk);
		
		
		for(int i = 0 ; i < seat_pk_no.length ; i++) {
			log.info("반복문" + seat_pk_no[i]);
			log.info(reservedseatVO.getReservation_pk_no());
			log.info(reservedseatVO.getScr_pk_no());
			log.info(reservedseatVO.getReservation_pk_no());
			reservedseatVO.setSeat_pk_no(seat_pk_no[i]);
			res.reservedseatInsert(reservedseatVO);
		}
		rttr.addAttribute("reservationPk", reservedseatVO.getReservation_pk_no());
		rttr.addAttribute("reservationPk", reservedseatVO.getReservation_pk_no());
		rttr.addAttribute("scr_pk", scr_pk);
/*		rttr.addAttribute("scrData",  res.getScrData(reservedseatVO.getReservation_pk_no()));*/
		
		
		return "redirect:/reservation/payment";
	}
	
	@GetMapping("/payment")
	public void paymentGet(Model model,ReservationVO reservationVO,
			@RequestParam("reservationPk") Integer reservationPk,@RequestParam("scr_pk") Integer scr_pk
			/*@RequestParam("scrData") List<> scrData,*/
		) {
		log.info("payment");
		log.info("잘 들어왔냐? ::: "+scr_pk);
		model.addAttribute("seatPk", res.reservedseatListforPk(reservationPk));
		model.addAttribute("scrData", res.getScrData(scr_pk));
	}
		/*model.addAttribute("reservationPk",reservationVO.getReservation_pk());*/
		/*
		ReservationVO reservationVO = new ReservationVO();
 		model.addAttribute("reservationPk",reservationVO.getReservation_pk());
		log.info("payment에서 pk" + reservationVO.getReservation_pk() );
		 */
	@PostMapping("/payment")
	public String paymentPost(ReservationVO reservationVO, Integer reservationPk) {
		
		
		reservationVO.setReservation_pk(reservationPk);
		
		res.paymentUpdate(reservationVO);
		
		res.getPayment();
		
//		return null;
		return "redirect:/myPage/myPageResv";
	}
}
