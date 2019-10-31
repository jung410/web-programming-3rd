package com.ggv.movie.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("actor")
@AllArgsConstructor
@NoArgsConstructor
public class ActorVO {
	private Integer actor_pk;
	private Integer movie_pk;
	private String a_cast;
	private String actor_name;
	private String actor_img;

}
