package com.ggv.review.service;

import java.util.List;

import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.domain.ReviewPageDTO;
import com.ggv.review.domain.ReviewVO;

public interface ReviewService {
	public List<MyReviewVO> getList(Integer movie_pk);
	
	public List<MyReviewVO> getListMyReview(MyReviewVO myreview);
	
	public MyReviewVO getReview(Integer review_pk);

	public int getCountReview(Integer review_pk);

	public void insert(MyReviewVO myreview);
	
	public void insertSelectKey(MyReviewVO myreview);

	public boolean remove(Integer review_pk);
	
	public boolean modify(MyReviewVO MyReviewVO);
	
	public ReviewPageDTO getListPage(Criteria cri, Integer review_pk);

	public List<MyReviewVO> getMyReviewList(String userid);
	
	public MyReviewVO getMyReview(Integer review_pk);
	
	public List<MyReviewVO> getMyReviewMainList(String userid);
	
	public void removeReview(String userid);
}