package com.ggv.reservation.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.ggv.reservation.domain.TicketingVO;
import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ReservationControllerTests {
	@Setter @Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mvc;
	
	@Before
	public void init() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	@Test
	public void testTicketingbyMovie_pk() throws Exception {
		TicketingVO ticketingVO = new TicketingVO();
		ticketingVO.setMovie_pk(42);
		ticketingVO.setLocation("서울");
		ticketingVO.setT_address("건대");
		ticketingVO.setScr_date("2019-11-02");
		ticketingVO.setScr_time("09:00");
		

		String jsonStr = new Gson().toJson(ticketingVO);
		
		log.info(jsonStr);
		
		mvc.perform(post("/reservation/ticketing")
				.contentType(MediaType.APPLICATION_JSON)
				.content(jsonStr))
				.andExpect(status().is(200));
		
		
	}
	
		
	
}
