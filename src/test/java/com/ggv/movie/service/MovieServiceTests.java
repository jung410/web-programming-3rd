package com.ggv.movie.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.movie.domain.MovieVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MovieServiceTests {
	@Setter
	@Autowired
	private MovieServiceImpl movieServiceImpl;
	
	@Test
	public void testExist() {
		log.info(movieServiceImpl);
		assertNotNull(movieServiceImpl);
	}

	@Test
	public void testGetMovieList() {
//		log.info(movieServiceImpl.getList("upComing"));
		log.info(movieServiceImpl.getList("movieChart"));
	}

	@Test
	public void testGetMovie() {
		log.info(movieServiceImpl.getMovieInfo(1));

	}
}
