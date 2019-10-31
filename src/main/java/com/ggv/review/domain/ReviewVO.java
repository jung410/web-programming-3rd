package com.ggv.review.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("review")
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private Integer movie_pk;
	private Integer review_pk;
	private String rv_title;
	private String rv_content;
	private Integer score;
	private String userid;
	private String kakaouserid;
	private String rv_date;
	
}
