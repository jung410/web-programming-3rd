package com.ggv.review.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class ReviewPageDTO {
	private int reviewCnt;
	private Double score;
	private List<MyReviewVO> list;
}
