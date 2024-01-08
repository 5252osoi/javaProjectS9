package com.spring.javaProjectS9.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS9.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public int setMemberJoinOk(@Param("vo")MemberVO vo);

	
}
