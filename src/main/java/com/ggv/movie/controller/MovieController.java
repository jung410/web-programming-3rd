package com.ggv.movie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ggv.movie.domain.ActorVO;
import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.domain.StillcutVO;
import com.ggv.movie.service.MovieService;
import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.ReviewPageDTO;
import com.ggv.review.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie/*")
public class MovieController {
	@Setter
	@Autowired
	private MovieService service;
	
	@GetMapping("/movieChart")
	public String movieChart() {
		log.info("movieChart...");
		return "movie/movieChart";
	}
	
	// 2019.10.24 작성
	// 데이터 관련 비동기 : 현재상영작, 개봉예정작 리스트 구분 위해 사용
	// http://localhost:8080/movie/onoff?stat=movieChart
	// http://localhost:8080/movie/onoff?stat=upComing
	@GetMapping("/onoff") 
	public @ResponseBody List<MovieVO> movieChart2(String stat) {
		log.info("movieChart...");
		return service.getList(stat);
	}
	
	@GetMapping("movieDetail/{movie_pk}")
	public String movieInfo(@PathVariable("movie_pk") Integer movie_pk, Model model) {
		
//////////////////////////////////////////////////////////////////////////////////		
			
		MovieVO movie = service.getMovieInfo(movie_pk);
		System.err.println(movie);

		List<ActorVO> actorlist = service.getActorList(movie_pk);
		List<StillcutVO> stillcutlist = service.getStillcutList(movie_pk);
		
		movie.setActorlist(actorlist);
		movie.setStillcutlist(stillcutlist);
		
////////////////////////////////////////////////////////////////////////////////

		System.err.println(movie);
		
		model.addAttribute("getMovieInfo", movie);
		model.addAttribute("isUpcomming", service.isUpcomming(movie_pk));
		
		log.info("movieDetail..." + movie);
		return "movie/movieDetail";
	}
}

