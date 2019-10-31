package com.ggv.reservation.domain;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("myresv")
@AllArgsConstructor
@NoArgsConstructor
public class MyResvVO {
	private Integer movie_pk;
	private Integer reservation_pk;
	private String resv_num;
	private String m_title;
	private String mainpost_img;
	private String watchgrade;
	private String runningtime;
	private String resvdate;
	private String scrdate;
	private String scrtime;
	private String src_endtime;
	private String aud_name;
	private String t_address; 
	private String cancle_date;
	
	private List<MyResvSeatVO> seatList;
}
