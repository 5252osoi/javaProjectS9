package com.spring.javaProjectS9.service;

import com.spring.javaProjectS9.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public int setMemberJoinOk(MemberVO vo);

}
