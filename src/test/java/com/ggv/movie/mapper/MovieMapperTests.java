package com.ggv.movie.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.member.domain.MemberVO;
import com.ggv.movie.domain.ActorVO;
import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.domain.StillcutVO;
import com.ggv.movie.service.MovieService;
import com.ggv.movie.service.MovieServiceImpl;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MovieMapperTests {
	@Setter
	@Autowired
	private MovieMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
		assertNotNull(mapper);
	}
	
	@Test
	public void testGetMovieList() {
//		log.info(mapper.getList("upComing"));
		log.info(mapper.getList("movieChart"));
	}

	@Test
	public void testGetMovie() {
		MovieVO movie = mapper.getMovieInfo(1);
		log.info(movie);
		
		List<ActorVO> actorlist = mapper.getActorList(1);
		List<StillcutVO> stillcutlist = mapper.getStillcutList(1);
		log.info(actorlist);
		
		movie.setActorlist(actorlist);
		movie.setStillcutlist(stillcutlist);
		log.info(movie);
	}
	
	@Test
	public void testInsert() {
		MovieVO movie = new MovieVO();
		movie.setM_title("테스트 제목");
		movie.setPlot("테스트 줄거리");
		log.info(movie);
	}
	
	@Test
	public void testGetActorList() {
		log.info(mapper.getActorList(1));
	}
	
	@Test
	public void testGetStillcutList() {
		log.info(mapper.getStillcutList(1));
	}
}