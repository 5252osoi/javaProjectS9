package com.spring.javaProjectS9.vo;

import lombok.Data;

@Data
public class PostReplyVO {
	private int idx;
	private int postIdx;
	private String mid;
	private String hostIp;
	private String content;
	private String WDate;
	private int likes;
}
