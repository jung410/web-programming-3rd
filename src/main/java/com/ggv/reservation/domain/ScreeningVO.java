package com.ggv.reservation.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("screening")
public class ScreeningVO {
	private Integer scr_pk;
	private String scr_date;
	private String scr_time;
	private Integer theater_pk_no;
	private Integer aud_pk_no;
	private Integer movie_pk_no;
}
