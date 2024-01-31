package com.spring.javaProjectS9.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import lombok.Data;

@Data
public class PostVO {

	private int idx;
	private String mid;
	private String FName;
	private String FSName;
	private int FSize;
	private String content;
	private String hostIp;
	private String openSw;
	private int likes;
	private int reply;
	private String WDate;
	
	private String date_diff;
	private String hour_diff;
	/*
	public String getEncodedFName() {
		try {
			return URLEncoder.encode(this.FName, StandardCharsets.UTF_8.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return this.FName; // 인코딩 실패 시 기존 값 반환
		}
	}
	public String getEncodedFSName() {
		try {
			return URLEncoder.encode(this.FSName, StandardCharsets.UTF_8.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return this.FSName; // 인코딩 실패 시 기존 값 반환
		}
	}
	*/
}
