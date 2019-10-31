package com.ggv.review.domain;

import lombok.Getter;
import lombok.ToString;

@Getter @ToString
public class PageDTO {
	private final static int PAGES_PER_LIST = 10;
	
	private Criteria cri;
	private int total;
	
	private int startPage;
	private int endPage;
	
	private boolean prev;
	private boolean next;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		endPage = (int)(Math.ceil(cri.getPageNum() / (double)PAGES_PER_LIST)) * PAGES_PER_LIST;
		startPage = endPage - PAGES_PER_LIST + 1; 
		
		int realEnd = (int)(Math.ceil(total / (double)cri.getAmount()));
		
		if(realEnd < endPage) {
			endPage = realEnd;
		}
		
		prev = startPage > 1;
		next = endPage < realEnd;
		
	}
	
}
