package com.ggv.reservation.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("theater")
public class TheaterVO {
	private Integer theater_pk;
	private String location;
	private String t_address;
}
