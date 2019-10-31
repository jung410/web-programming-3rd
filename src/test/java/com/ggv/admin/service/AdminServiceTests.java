package com.ggv.admin.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.member.mapper.MemberMapperTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AdminServiceTests {
	@Setter
	@Autowired
	private AdminServiceImpl adminServiceImpl;
	
	@Test
	public void testExist() {
		log.info(adminServiceImpl);
		assertNotNull(adminServiceImpl);
	}
	
	@Test
	public void testGetSalesByMovie() {
		adminServiceImpl.getSalesByMovie().forEach(log::info);
	}
}
