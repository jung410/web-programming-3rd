package com.ggv.admin.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("sales")
@AllArgsConstructor
@NoArgsConstructor
public class SalesVO {
	private String m_title;
	private Integer sales;
}
