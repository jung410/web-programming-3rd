package com.ggv.reservation.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("auditorium")
public class AuditoriumVO {
	private Integer aud_pk;
	private String aud_name;
	private Integer seat_num;
	private Integer theater_pk_no;
}
