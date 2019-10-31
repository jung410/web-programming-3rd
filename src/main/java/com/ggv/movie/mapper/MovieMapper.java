package com.ggv.movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.ggv.movie.domain.ActorVO;
import com.ggv.movie.domain.MovieVO;
import com.ggv.movie.domain.StillcutVO;

public interface MovieMapper {
	public List<MovieVO> getList(@Param("movieChart") String movieChart);
	
	public MovieVO getMovie(MovieVO movie);
	
	public MovieVO getMovieInfo(Integer movie_pk);
	
	public List<ActorVO> getActorList(Integer movie_pk);
	
	public List<StillcutVO> getStillcutList(Integer movie_pk);
	
	public int getCountMovie(Integer movie_pk);

	public boolean isUpcomming(Integer movie_pk);
	
}



