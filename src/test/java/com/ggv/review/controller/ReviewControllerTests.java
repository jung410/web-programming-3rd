package com.ggv.review.controller;

import java.io.IOException;
import java.sql.SQLException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class ReviewControllerTests {
	@Setter
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testReviewList() throws Exception, IOException, SQLException {
		log.info(
			mockMvc.perform(MockMvcRequestBuilders.get("/review/list/2"))
			.andReturn()
			.getModelAndView()
			.getModelMap());
	}
	
	@Test
	public void testInsert() throws Exception, IOException, SQLException {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/review/insert")
				.param("movie_pk", "2")
				.param("rv_title", "테스트 새 리뷰 제목")
				.param("rv_content", "테스트 새 리뷰 내용")
				.param("score", "6")
				.param("userid", "tester")
				.param("rv_date", "2019/10/21")
			).andReturn().getModelAndView().getViewName();
			log.info(resultPage);				
	}
	
	@Test
	public void testGetReview() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/review/getReview").param("review_pk", "77"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc
			.perform(MockMvcRequestBuilders.post("/review/modify")
				.param("movie_pk", "1")
				.param("review_pk", "77")
				.param("rv_date", "2019/10/21")
				.param("rv_content", "수정된 테스트 새 리뷰 내용")
				.param("score", "9")
				.param("rv_title", "수정된 테스트 새 리뷰 제목")
				.param("userid", "tester"))
			.andReturn().getModelAndView().getViewName();
		
			log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/review/remove")
						.param("review_pk", "77"))
						.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
}
