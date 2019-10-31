package com.ggv.movie.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("stillcut")
@AllArgsConstructor
@NoArgsConstructor
public class StillcutVO {
	private Integer stillcut_pk;
	private String stillcut_img;
	private Integer movie_pk;
}
