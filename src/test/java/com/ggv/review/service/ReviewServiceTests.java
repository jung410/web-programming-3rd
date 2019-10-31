package com.ggv.review.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.review.domain.MyReviewVO;
import com.ggv.review.domain.ReviewVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReviewServiceTests {
	@Setter
	@Autowired
	private ReviewService service;
	
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		service.getList(3).forEach(review->log.info(review));
	}
	
	@Test
	public void testGetReview() {
		log.info(service.getReview(44));
	}
	
	@Test
	public void testInsert() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setMovie_pk(2);
//		myreview.setReview_pk(1);
		myreview.setRv_title("테스트");
		myreview.setRv_content("테스트");
		myreview.setScore(1);
		myreview.setUserid("tester");
		myreview.setRv_date("2019/10/25");
		
		service.insert(myreview);
		log.info("testInsert(생성된 리뷰 번호) : " + myreview.getReview_pk());
	}
	
	@Test
	public void testUpdate() {
		MyReviewVO myreview = service.getReview(188);
		if(myreview == null) {
			return;
		}
		myreview.setRv_title("제목 수정 테스트");
		myreview.setRv_content("내용 수정 테스트");
		myreview.setScore(1);
		log.info("modify result : " + service.modify(myreview));
	}
	
	@Test
	public void testDelete() {
		log.info("remove result : " + service.remove(44));
	}
	
	@Test
	public void testGetMyReviewList() {
		service.getMyReviewList("tester222");
	}
	
	@Test
	public void testGetMyReviewMainList() {
		service.getMyReviewMainList("tester222");
	}
	
	@Test
	public void testGetListMyReview() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setMovie_pk(1);
		myreview.setUserid("tester222");
		
		log.info(service.getListMyReview(myreview));
	}
}
