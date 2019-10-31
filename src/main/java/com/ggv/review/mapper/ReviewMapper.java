package com.ggv.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.domain.ReviewVO;

public interface ReviewMapper {
	public List<MyReviewVO> getReviewList(Integer movie_pk);
	
	public List<MyReviewVO> getListMyReview(MyReviewVO myreview);
	
	public MyReviewVO getReview(Integer review_pk);

	public int getCountReview(Integer review_pk);

	public void insert(MyReviewVO myreview);
	
	public void insertSelectKey(MyReviewVO myreview);

	public int delete(Integer review_pk);
	
	public int update(MyReviewVO MyReviewVO);
	
	// 페이징
	public List<MyReviewVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("movie_pk") Integer movie_pk);
	
	// 별점
	public int getCountByMovie_pk(Integer movie_pk);

	public double getScoreByMovie_pk(Integer movie_pk);	

	public List<MyReviewVO> getMyReviewList(String userid);
	
	public MyReviewVO getMyReview(Integer review_pk);
	
	public List<MyReviewVO> getMyReviewMainList(String userid);
	
	public void removeReview(String userid);
}
