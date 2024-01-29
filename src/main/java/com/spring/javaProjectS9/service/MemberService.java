package com.spring.javaProjectS9.service;

import java.util.List;

import com.spring.javaProjectS9.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public int setMemberJoinOk(MemberVO vo);

	public List<MemberVO> getRecommendUser(String sMid);

	public List<MemberVO> getRanRecommendUser(String sMid);

}
