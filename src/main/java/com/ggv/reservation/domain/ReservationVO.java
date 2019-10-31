package com.ggv.reservation.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Alias("reservation")
@AllArgsConstructor
@NoArgsConstructor
public class ReservationVO {
	private Integer reservation_pk;
	private String userid;
	private String kakaouserid;
	private Integer scr_pk_no;
	private Integer is_active;
	private Integer is_paid;
	private String reserve_date;
	private String cancle_date;
	private Integer payment;
	private String resv_num;
}
