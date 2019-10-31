package com.ggv.admin.mapper;

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
public class AdminMapperTests {
	@Setter
	@Autowired
	private AdminMapper adminmapper;
	
	@Test
	public void testExist() {
		assertNotNull(adminmapper);
	}
	
	@Test
	public void testGetSalesByMovie() {
		adminmapper.getSalesByMovie().forEach(log::info);
	}
	
	@Test
	public void testGetTotalSales() {
		log.info(adminmapper.getTotalSales());
	}
}
