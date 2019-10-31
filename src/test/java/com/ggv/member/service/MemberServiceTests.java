package com.ggv.member.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.member.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberServiceTests {
	@Setter 
	@Autowired
	private MemberServiceImpl memberServiceImpl;
	
	@Test
	public void testExist() {
		log.info(memberServiceImpl);
		assertNotNull(memberServiceImpl);
	}
	
	@Test
	public void testGetMemberList() {
		log.info(memberServiceImpl.getMemberList());
	}
	
	@Test
	public void testGetMember() {
		memberServiceImpl.getMember(new MemberVO("test2", MemberSha256.encrypt("123123")));
	}
	
	@Test
	public void testGetCountMember() {
		memberServiceImpl.getCountMember("test2");
	}
	
	@Test
	public void testGetCountMemberByEmail() {
		memberServiceImpl.getCountMemberByEmail("jung4102@naver.com");
	}
	
	@Test
	public void testSendEmail() {
		memberServiceImpl.sendEmail(new MemberVO("정민영", "1234", "jung4102@naver.com", "asdf","asdf", "19/04/10", "정민영", "010", 1, 1, 1), "userid");
	}
}
