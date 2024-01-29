package com.spring.javaProjectS9.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String pr;
	private String userInfor;
	private String userDel;
	private int post;
	private int follow;
	private int follower;
	
	private String IDPhotofName;
	private String IDPhotofSName;
}
