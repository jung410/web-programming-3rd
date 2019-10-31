package com.ggv.movie.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("director")
@AllArgsConstructor
@NoArgsConstructor
public class DirectorVO {
	private Integer director_pk;
	private String d_name;
	private Integer movie_pk;
}
