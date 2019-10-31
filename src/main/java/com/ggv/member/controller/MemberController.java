package com.ggv.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;
import com.ggv.member.service.MemberServiceImpl;
import com.ggv.member.service.MemberSha256;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
public class MemberController {
	@Setter
	@Autowired
	private MemberServiceImpl service;
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.setAttribute("loginStat", null);
		return "redirect:/"; 
	}
	
	@GetMapping("login")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("kakao")
	public String kakao(@RequestParam("code") String code, HttpSession session) {
		String accessToken = service.getAccessTokenKakao(code);
	    HashMap<String, Object> userInfo = service.getUserInfoByKakao(accessToken);
	    KakaoMemberVO kakaoMember = new KakaoMemberVO(userInfo.get("email").toString(), userInfo.get("email").toString(), userInfo.get("name").toString(), 1);
	    System.out.println("login Controller : " + userInfo);
	    if(accessToken != null && userInfo != null) {
	    	if(service.getKakaoMember(userInfo.get("email").toString()) == null){
	    		service.addKakaoMember(kakaoMember);
	    		session.setAttribute("loginStat", kakaoMember);
	    	} else if(userInfo.get("email").toString().equals(service.getKakaoMember(userInfo.get("email").toString()).getUserid())) {
	    		session.setAttribute("loginStat", kakaoMember);
	    	} 
	    }
		return "redirect:/";
	}
	
	@PostMapping("login")
	public String login(MemberVO membervo, HttpSession session, HttpServletResponse resp) {
		MemberVO member = service.getMember(new MemberVO(membervo.getUserid(), MemberSha256.encrypt(membervo.getPassword())));
		if(member == null) {
			service.addAlertScript("아이디 및 비밀번호를 확인해주세요.", resp);
			return "member/login";
		} else if(member.getAdmin() == 1) {
			return "redirect:/admin/sales";
		} else {
			session.setAttribute("loginStat", member);
			return "redirect:/";
		}
	}
	
	@GetMapping("join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("join")
	public String addMember(MemberVO memberVO) {
		if(memberVO.getAgree() == null) {
			memberVO.setAgree(0);
		}
		memberVO.setApiLogin(0);
		memberVO.setAdmin(0);
		// 비밀번호 암호화 (sha256)
		memberVO.setPassword(MemberSha256.encrypt(memberVO.getPassword()));
		service.addMember(memberVO);
		return "redirect:/user/login";
	}
	
	@GetMapping("findUser")
	public String findIDPW() {
		return "member/findIDPW";
	}
	
	@PostMapping("findUserid")
	public String postFindUserid(MemberVO member, HttpServletResponse resp) {
		service.getUserByNameEmail(member, resp);
		return "member/findIDPW";
	}
	
	@PostMapping("findPassword")
	public String postFindPassword(MemberVO member, HttpServletResponse resp) {
		service.getUserByUseridEmail(member, resp);
		return "member/findIDPW";
	}
	
	@GetMapping("idCheck")
	@ResponseBody
	public Integer idCheck(@RequestParam("userid")String userid) {
		return service.getCountMember(userid);
	}
	
	@GetMapping("emailCheck")
	@ResponseBody
	public Integer emailCheck(@RequestParam("email")String email, HttpSession session) {
		if(session.getAttribute("loginStat") == null) {
			return service.getCountMemberByEmail(email);
		} else if(!session.getAttribute("loginStat").getClass().getSimpleName().equals("KakaoMemberVO")) {
			MemberVO member = (MemberVO)session.getAttribute("loginStat");
			if(member.getEmail().equals(email)) {
				return 999;
			} else {
				return service.getCountMemberByEmail(email);
			}
		} else {
			return service.getCountMemberByEmail(email);
		}
	}
}
