package com.ggv.member.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;

public interface MemberService {
	public List<MemberVO> getMemberList();
	
	public MemberVO getMember(MemberVO member);
	
	public void addMember(MemberVO member);
	
	public void modifyMember(MemberVO member);
	
	public void removeMember(MemberVO member);
	
	public int getCountMember(String userid);
	
	public int getCountMemberByEmail(String email);
	
	public void addAlertScript(String str, HttpServletResponse resp);
	
	public MemberVO getUserByNameEmail(MemberVO member, HttpServletResponse resp);
	
	public MemberVO getUserByUseridEmail(MemberVO member, HttpServletResponse resp);
	
	public void sendEmail(MemberVO member, String cat);
	
	public void modifyMemberPassword(MemberVO member);
	
	public String getAccessTokenKakao(String authorizecode);
	
	public HashMap<String, Object> getUserInfoByKakao(String accessToken);
	
	// kakao member
	public KakaoMemberVO getKakaoMember(String userid);
	
	public void modifyKakaoMember(KakaoMemberVO kakaoMember);
	
	public void addKakaoMember(KakaoMemberVO kakaoMember);
}
