package com.ggv.mypage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.runners.Parameterized.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;
import com.ggv.member.service.MemberService;
import com.ggv.member.service.MemberSha256;
import com.ggv.reservation.domain.MyResvVO;
import com.ggv.reservation.service.ReservationService;
import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/myPage/*")
public class myPageController {
	@Setter @Autowired
	private MemberService memberservice;
	@Setter @Autowired
	private ReviewService reviewservice;
	@Setter @Autowired
	private ReservationService resvservice;
	
	@GetMapping("/myPageMain")
	public String myPageMain(HttpSession session, Model model) {
		// 예매 내역 관련 내용
		List<MyResvVO> list = new ArrayList<MyResvVO>();
		
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO kmember = (KakaoMemberVO)session.getAttribute("loginStat");
			list = resvservice.getMyreservationByKakao(kmember.getUserid());
			
			List<MyReviewVO> myreviewmain = reviewservice.getMyReviewMainList(kmember.getUserid());
			model.addAttribute("getMyReviewMainList", myreviewmain);
		} else {
			MemberVO member = (MemberVO)session.getAttribute("loginStat");
			list = resvservice.getMyreservation(member.getUserid());
			
			List<MyReviewVO> myreviewmain = reviewservice.getMyReviewMainList(member.getUserid());
			model.addAttribute("getMyReviewMainList", myreviewmain);
		}
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(resvservice.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
		model.addAttribute("myResvList", list);
		
		return "mypage/myPageMain";
	}
	
	@GetMapping("/myPageCancled")
	public String myPageCancled(HttpSession session, Model model) {
		List<MyResvVO> list = new ArrayList<MyResvVO>();
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO kmember = (KakaoMemberVO)session.getAttribute("loginStat");
			list = resvservice.getCancledByKakao(kmember.getUserid());
		} else {
			MemberVO member = (MemberVO)session.getAttribute("loginStat");
			list = resvservice.getCancled(member.getUserid());
		}
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(resvservice.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
		model.addAttribute("myCancledList", list);
		return "mypage/myPageCancledPage";
	}
	
	@GetMapping("/myPageModify")
	public String myPageModify(Model model, HttpSession session) {
		System.out.println(session.getAttribute("loginStat").getClass().getSimpleName());
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO kmember = (KakaoMemberVO)session.getAttribute("loginStat");
			model.addAttribute("loginStat", memberservice.getKakaoMember(kmember.getUserid()));
		} else {
			model.addAttribute("loginStat", memberservice.getMember((MemberVO)session.getAttribute("loginStat")));
		}
		//System.out.println(session.getAttribute("loginStat").toString().indexOf("apiLogin"));
		//if(model.addAttribute("loginStat", memberservice.getMember((MemberVO)session.getAttribute("loginStat"))))
		//model.addAttribute("loginStat", memberservice.getMember((MemberVO)session.getAttribute("loginStat")));
		return "mypage/myPageModifyPage";
	}
	
	@PostMapping("/myPageModify")
	public String PostMyPageModify(MemberVO member, Model model, HttpSession session) {
		// 이메일 동의 여부 확인하고
		if(member.getAgree() == null) {
			member.setAgree(0);
		} else {
			member.setAgree(1);
		}
		// 비밀번호 암호화 하고
		String encryPassword = MemberSha256.encrypt(member.getPassword());
		member.setPassword(encryPassword);
		memberservice.modifyMember(member);

		session.removeAttribute("loginStat");
		MemberVO membervo = memberservice.getMember(member);
		session.setAttribute("loginStat", membervo);
		return "redirect:myPageModify";
	}
	
	@PostMapping("/myPageKakaoModify")
	public String PostMyKakaoPageModify(KakaoMemberVO member, Model model, HttpSession session) {
		// 이메일 동의 여부 확인하고
		if(member.getAgree() == null) {
			member.setAgree(0);
		} else {
			member.setAgree(1);
		}
		memberservice.modifyKakaoMember(member);
		
		session.removeAttribute("loginStat");
		KakaoMemberVO membervo = memberservice.getKakaoMember(member.getUserid());
		session.setAttribute("loginStat", membervo);
		
		return "redirect:myPageModify";
	}
	
	@GetMapping("/myPageRemove")
	public String myPageRemove() {
		return "mypage/myPageRemovePage";
	}
	
	@PostMapping("/myPageRemove")
	@Transactional
	public String PostMyPageRemove(MemberVO member, HttpSession session, HttpServletResponse resp) {
		member.setPassword(MemberSha256.encrypt(member.getPassword()));
		// 현재 나의 password와 입력한 password가 동일 하다면
		if(memberservice.getMember((MemberVO)session.getAttribute("loginStat")).getPassword().equals(member.getPassword())) {
			// 회원 탈퇴를 진행하고
			// 아직 회원탈퇴 하면 안될듯.
			// PK로 묶여있어서 다른 TABLE의 묶여있는 row들 삭제 먼저 하고
			// 얘 지워야 가능함.(2019-10-20)
			reviewservice.removeReview(member.getUserid());
			resvservice.removeResvSeat(member.getUserid());
			resvservice.removeResv(member.getUserid());
			memberservice.removeMember(member);
			return "redirect:/user/logout";
		} else { // 동일하지 않다면
			memberservice.addAlertScript("비밀번호가 틀렸습니다. 다시 확인해주세요.", resp);
			return "mypage/myPageRemovePage"; 
		}
	}
	
	@GetMapping("/myPageResv")
	public String myPageResv(HttpSession session, Model model, Integer reservation_pk) {
		// ---------------------------------------------------------
		// reservation_pk를 이용하여 예매 취소를 진행한다.
		resvservice.cancleResv(reservation_pk);
		// ---------------------------------------------------------
		
		// ---------------------------------------------------------
		// 현재 로그인 방식에 따라 예매 내역 목록을 가져온다.
		List<MyResvVO> list = new ArrayList<MyResvVO>();
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO kmember = (KakaoMemberVO)session.getAttribute("loginStat");
			list = resvservice.getMyreservationByKakao(kmember.getUserid());
		} else {
			MemberVO member = (MemberVO)session.getAttribute("loginStat");
			list = resvservice.getMyreservation(member.getUserid());
		}
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(resvservice.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
		model.addAttribute("myResvList", list);
		return "mypage/myPageResvPage";
	}
	
	@GetMapping("/myPageReview")
	public String myPageReview() {
		return "mypage/myPageReviewPage";
	}
	
	@GetMapping("/getMyReviewList")
	@ResponseBody
	public List<MyReviewVO> getMyReviewList(String userid) {
		log.info("get Review List userid : " + userid);
		return reviewservice.getMyReviewList(userid);
	}
	
	@GetMapping("/myPageReview/get/{review_pk}")
	@ResponseBody
	public MyReviewVO getMyReview(@PathVariable("review_pk") Integer review_pk) {
		return reviewservice.getMyReview(review_pk);
	}
	
	@GetMapping("/myPageWatched")
	public String myPageWatched(HttpSession session, Model model) {
		List<MyResvVO> list = new ArrayList<MyResvVO>();
		if(session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			KakaoMemberVO kmember = (KakaoMemberVO)session.getAttribute("loginStat");
			list = resvservice.getWachedMovieByKakao(kmember.getUserid());
		} else {
			MemberVO member = (MemberVO)session.getAttribute("loginStat");
			list = resvservice.getWachedMovie(member.getUserid());
		}
		for(int i = 0 ; i < list.size() ; i++) {
			list.get(i).setSeatList(resvservice.getMyreservationSeat(list.get(i).getReservation_pk()));
		}
		list.forEach(log::info);
		model.addAttribute("myWatchedList", list);
		return "mypage/myPageWatchedPage";
	}
}
