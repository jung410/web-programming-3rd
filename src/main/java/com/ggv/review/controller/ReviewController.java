package com.ggv.review.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;
import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.domain.ReviewPageDTO;
import com.ggv.review.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/review/*")
public class ReviewController {
	@Setter
	@Autowired
	private ReviewService reviewService;
	
	
	@GetMapping("list/{movie_pk}")
	public List<MyReviewVO> getList(@PathVariable Integer movie_pk, Model model) {
		model.addAttribute("getReviewList", reviewService.getList(movie_pk));
		log.info("reviewList...");
		return reviewService.getList(movie_pk);
	}
	
	@GetMapping("list/{movie_pk}/{page}")
	public ReviewPageDTO getList(
			@PathVariable("movie_pk") Integer movie_pk,
			@PathVariable("page") int page) {
		Criteria cri = new Criteria(page, 10);
		log.info("get Review List movie_pk : " + movie_pk);
		log.info("cri : " + cri);
		return reviewService.getListPage(cri, movie_pk);
	}
	
	@GetMapping("getMyReview/{movie_pk}")
	public List<MyReviewVO> getListMyReview(@PathVariable Integer movie_pk, String userid) {
		MyReviewVO myreview = new MyReviewVO();
		
		myreview.setMovie_pk(movie_pk);
		myreview.setUserid(userid);
		
		return reviewService.getListMyReview(myreview);
	}
	
	@GetMapping("get/{review_pk}")
	public MyReviewVO getReview(@PathVariable("review_pk") Integer review_pk) {
		log.info("getReview...");
		return reviewService.getReview(review_pk);
	}
	
	@PostMapping("insert")
	public String insert(@RequestBody MyReviewVO myreview, HttpSession session) {
		MemberVO vo = (MemberVO)session.getAttribute("loginStat");
		myreview.setUserid(vo.getUserid());
		reviewService.insert(myreview);
		log.info("insert : " + myreview);
		return "success";
	}
	
	@PutMapping("modify/{review_pk}")
	public String modify(@PathVariable("review_pk") Integer review_pk, @RequestBody MyReviewVO myreview) {
		log.info("modify : " + review_pk);
		reviewService.modify(myreview);
		return "success";
	}
	
	@DeleteMapping("/remove/{review_pk}")
	public String remove(@PathVariable("review_pk") Integer review_pk) {
		log.info("remove..." + review_pk);
		reviewService.remove(review_pk);
		return "success"; 
	}
}
