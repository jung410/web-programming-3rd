package com.ggv.review.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("reply")
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {
	private Integer reply_pk;
	private String userid;
	private String re_date;
	private String re_content;
	private Integer review_pk_no;
	
}
