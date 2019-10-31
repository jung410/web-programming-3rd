package com.ggv.reservation.domain;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("myresvseat")
@AllArgsConstructor
@NoArgsConstructor
public class MyResvSeatVO {
	private Integer reservation_pk;
	private String seat_name;
	private Integer seat_num;
}
