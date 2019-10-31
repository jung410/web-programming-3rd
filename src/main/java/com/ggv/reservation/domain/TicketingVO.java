package com.ggv.reservation.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("ticketing")
public class TicketingVO {
	private Integer scr_pk;
	private Integer movie_pk;
	private Integer theater_pk;
	private Integer aud_pk;
	private String m_title;
	private String location;
	private String t_address;
	private String aud_name;
	private String scr_date;
	private String scr_time;
	private String mainpost_img;
} 
