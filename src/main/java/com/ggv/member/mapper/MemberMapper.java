package com.ggv.member.mapper;

import java.util.List;

import com.ggv.member.domain.KakaoMemberVO;
import com.ggv.member.domain.MemberVO;

public interface MemberMapper {
	public List<MemberVO> getMemberList();
	
	public MemberVO getMember(MemberVO member);
	
	public void addMember(MemberVO member);
	
	public void modifyMember(MemberVO member);
	
	public void removeMember(MemberVO member);
	
	public int getCountMember(String userid);
	
	public MemberVO getUserByNameEmail(MemberVO member);
	
	public MemberVO getUserByUseridEmail(MemberVO member);
	
	public void modifyMemberPassword(MemberVO member);
	
	public int getCountMemberByEmail(String email);
	
	public KakaoMemberVO getKakaoMember(String userid);
	
	public void modifyKakaoMember(KakaoMemberVO kakaoMember);
	
	public void addKakaoMember(KakaoMemberVO kakaoMember);
	
	public List<KakaoMemberVO> getKakaoMemberList();
}
