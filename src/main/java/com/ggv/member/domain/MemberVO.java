package com.ggv.member.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("member")
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private String userid;
	private String password;
	private String email;
	private String address;
	private String address2;
	private String birthdate;
	private String name;
	private String phone;
	private Integer apiLogin;
	private Integer agree;
	private Integer admin;
	
	public MemberVO(String userid, String password) {
		this.userid = userid;
		this.password = password;
	}
}
