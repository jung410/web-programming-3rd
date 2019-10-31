package com.ggv.movie.service;

import java.util.List;

import com.ggv.movie.domain.ActorVO;
import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.domain.StillcutVO;

public interface MovieService {
	public List<MovieVO> getList(String movieChart);
	
	public MovieVO getMovie(MovieVO movie);
	
	public MovieVO getMovieInfo(Integer movie_pk);
	
	public List<ActorVO> getActorList(Integer movie_pk);
	
	public List<StillcutVO> getStillcutList(Integer movie_pk);
	
	public int getCountMovie(Integer movie_pk);
	
	public boolean isUpcomming(Integer movie_pk);
	
	
}

