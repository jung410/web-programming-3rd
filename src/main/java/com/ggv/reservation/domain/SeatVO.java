package com.ggv.reservation.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("seat")
public class SeatVO {
	private Integer seat_pk;
	private String seat_name;
	private Integer aud_pk_no;
	private Integer seat_num;
}
