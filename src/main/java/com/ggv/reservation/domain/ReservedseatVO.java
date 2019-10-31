package com.ggv.reservation.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("reservedseat")
public class ReservedseatVO {
	private Integer reservedseat_pk;
	private Integer seat_pk_no;
	private Integer scr_pk_no;
	private Integer reservation_pk_no;
}
