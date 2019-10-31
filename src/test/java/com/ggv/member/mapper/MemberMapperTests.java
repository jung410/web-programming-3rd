package com.ggv.member.mapper;

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
public class MemberMapperTests {
	@Setter
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testExist() {
		assertNotNull(mapper);
	}
	
	@Test
	public void testGetList() {
		log.info(mapper.getMemberList());
	}
	
	@Test
	public void testGetMember() {
		log.info(mapper.getMember(new MemberVO("tester", "1234")));
	}
	
	@Test
	public void testAddMember() {
		MemberVO member = new MemberVO("정민영", "1234", "jung", "asdf","asdf", "19/04/10", "정민영", "010", 1, 1, 1);
		mapper.addMember(member);
		testGetList();
	}
	
	@Test
	public void testModifyMember() {
		MemberVO member = new MemberVO("정민영", "1234", "jung", "asdf","asdf", "19/04/10", "정민영", "010", 1, 1, 1);
		mapper.modifyMember(member);
		testGetList();
	}
	
	@Test
	public void testGetCountMember() {
		log.info(mapper.getCountMember("test2"));
	}
	
	@Test
	public void testGetKakaoMember() {
		log.info(mapper.getKakaoMember("jung4102@naver.com"));
	}
	
	@Test
	public void testGetKakaoMemberList() {
		log.info(mapper.getKakaoMemberList());
	}
}
