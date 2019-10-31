package com.ggv.admin.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("adminResv")
@AllArgsConstructor
@NoArgsConstructor
public class AdminResvVO {
	private String m_title;
	private String userid;
	private String kakaouserid;
	private String reserve_date;
	private Integer sales;
}
