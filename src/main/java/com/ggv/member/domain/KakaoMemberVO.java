package com.ggv.member.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("kakaoMember")
@AllArgsConstructor
@NoArgsConstructor
public class KakaoMemberVO {
	private String userid;
	private String email;
	private String address;
	private String address2;
	private String birthdate;
	private String name;
	private String phone;
	private Integer apiLogin;
	private Integer agree;
	
	public KakaoMemberVO(String userid, String email, String name, Integer apiLogin) {
		this.userid = userid;
		this.email = email;
		this.name = name;
		this.apiLogin = apiLogin;
	}
}