package com.ggv.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggv.movie.domain.ActorVO;
import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.domain.StillcutVO;
import com.ggv.movie.mapper.MovieMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MovieServiceImpl implements MovieService {
	@Autowired
	private MovieMapper mapper;
	
	@Override
	public List<MovieVO> getList(String movieChart) {
		return mapper.getList(movieChart);
	}

	@Override
	public MovieVO getMovie(MovieVO movie) {
		return mapper.getMovie(movie);
	}
	
	@Override
	public MovieVO getMovieInfo(Integer movie_pk) {
		return mapper.getMovieInfo(movie_pk);
	}
	
	@Override
	public List<ActorVO> getActorList(Integer movie_pk) {
		return mapper.getActorList(movie_pk);
	}

	@Override
	public List<StillcutVO> getStillcutList(Integer movie_pk) {
		return mapper.getStillcutList(movie_pk);
	}

	@Override
	public int getCountMovie(Integer m_title) {
		return mapper.getCountMovie(m_title);
	}

	@Override
	public boolean isUpcomming(Integer movie_pk) {
		// TODO Auto-generated method stub
		return mapper.isUpcomming(movie_pk);
	}
	
	
}
