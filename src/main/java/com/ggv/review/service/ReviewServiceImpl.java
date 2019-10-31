package com.ggv.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.domain.ReviewPageDTO;
import com.ggv.review.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService {
	@Setter
	@Autowired
	private ReviewMapper mapper;

	@Override
	public List<MyReviewVO> getList(Integer movie_pk) {
		log.info("review getList....");
		return mapper.getReviewList(movie_pk);
	}

	@Override
	public MyReviewVO getReview(Integer review_pk) {
		log.info("getReview..." + review_pk);
		return mapper.getReview(review_pk);
	}

	@Override
	public int getCountReview(Integer review_pk) {
		return mapper.getCountReview(review_pk);
	}

	@Override
	public void insert(MyReviewVO myreview) {
		log.info("insert..." + myreview);
		mapper.insert(myreview);
	}
	
	@Override
	public void insertSelectKey(MyReviewVO myreview) {
		mapper.insertSelectKey(myreview);
	}
	
	@Override
	public boolean modify(MyReviewVO myreview) {
		log.info("modify..." + myreview);
		return mapper.update(myreview) == 1;
	}

	@Override
	public boolean remove(Integer review_pk) {
		log.info("remove..." + review_pk);
		return mapper.delete(review_pk) == 1;
	}

	// 2019.10.24 작성
	// 리뷰 별점 처리 위해 사용
	@Override
	public ReviewPageDTO getListPage(Criteria cri, Integer movie_pk) {
		return new ReviewPageDTO(
			mapper.getCountByMovie_pk(movie_pk),
			mapper.getScoreByMovie_pk(movie_pk),
			mapper.getListWithPaging(cri, movie_pk));
	}

	@Override
	public List<MyReviewVO> getMyReviewList(String userid) {
		return mapper.getMyReviewList(userid);
	}

	@Override
	public MyReviewVO getMyReview(Integer review_pk) {
		return mapper.getMyReview(review_pk);
	}

	@Override
	public List<MyReviewVO> getMyReviewMainList(String userid) {
		return mapper.getMyReviewMainList(userid);
	}

	@Override
	public List<MyReviewVO> getListMyReview(MyReviewVO myreview) {
		return mapper.getListMyReview(myreview);
	}

	@Override
	public void removeReview(String userid) {
		mapper.removeReview(userid);
	}
}
