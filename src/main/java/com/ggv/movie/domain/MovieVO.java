package com.ggv.movie.domain;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("movie")
@AllArgsConstructor
@NoArgsConstructor
public class MovieVO {
	private Integer movie_pk;
	private String m_title;
	private String m_title_eng;
	private String mainpost_img;
	private String plot;
	private String runningtime;
	private String genre;
	private String watchgrade;
	private String opendate;
	private String director;
	private Double score_avg; // 평론가 평점
	private Double reservation_rate;
	private String trailer;
	
	private List<ActorVO> actorlist;
	private List<StillcutVO> stillcutlist;
}
