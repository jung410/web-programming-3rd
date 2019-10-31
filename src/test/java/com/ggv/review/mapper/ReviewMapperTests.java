package com.ggv.review.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ggv.review.domain.Criteria;
import com.ggv.review.domain.MyReviewVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReviewMapperTests {
	@Setter
	@Autowired
	private ReviewMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
		assertNotNull(mapper);
	}
	
	@Test
	public void testGetList() {
		/*log.info(mapper.getList(1));*/
		mapper.getReviewList(1).forEach(review -> log.info(review));
	}

	@Test
	public void testGetReview() {
		log.info(mapper.getReview(408));
	}
	
	@Test
	public void testInsert() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setMovie_pk(7);
		myreview.setM_title("제미니 맨");
		myreview.setReview_pk(412);
		myreview.setRv_title("테스트 리뷰제목");
		myreview.setRv_content("테스트 리뷰내용");
		myreview.setScore(7);
		myreview.setUserid("tester1");
		myreview.setRv_date("2019/10/29");
		
		mapper.insert(myreview);
		log.info(myreview);
	}
	
	@Test
	public void testInsertSelectKey() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setMovie_pk(2);
		myreview.setM_title("82년생 김지영");
		myreview.setReview_pk(77);
		myreview.setRv_title("테스트 리뷰 제목 select key");
		myreview.setRv_content("테스트 리뷰 내용 select key");
		myreview.setScore(8);
		myreview.setUserid("tester1");
		myreview.setRv_date("2019/10/21");
		
		mapper.insertSelectKey(myreview);
		log.info(myreview);
	}

	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(55));
	}
	
	@Test
	public void testUpdate() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setReview_pk(25);
		myreview.setRv_date("2019/10/21");
		myreview.setRv_content("수정된 리뷰 내용");
		myreview.setScore(5);
		myreview.setRv_title("수정된 리뷰 제목");
		
		int count = mapper.update(myreview);
		log.info("UPDATE COUNT : " + count);
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(3, 10);
		List<MyReviewVO> reviews = mapper.getListWithPaging(cri, 2);
		reviews.forEach(myreview -> log.info(myreview));
	}
	
	@Test
	public void testGetMyReviewList() {
		mapper.getMyReviewList("tester222");
	}
	
	@Test
	public void testGetMyReviewMainList() {
		mapper.getMyReviewMainList("tester222");
	}
	
	@Test
	public void testGetListMyReview() {
		MyReviewVO myreview = new MyReviewVO();
		myreview.setMovie_pk(1);
		myreview.setUserid("tester222");
		
		log.info(mapper.getListMyReview(myreview));
		
	}
}