package com.spring.javaProjectS9.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS9.vo.FollowVO;
import com.spring.javaProjectS9.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public int setMemberJoinOk(@Param("vo")MemberVO vo);

	public List<MemberVO> getRecommendUser(@Param("sMid") String sMid);

	public List<MemberVO> getRanRecommendUser(@Param("sMid") String sMid);

	public int setPostCnt();

	public int setUserFollow(@Param("follower")String follower, @Param("followee") String followee);
	
	public int setUserUnFollow(@Param("follower")String follower, @Param("followee") String followee);

	public int setUserFollowUpdate();

	public int setUserFolloweeUpdate();

	public List<FollowVO> getFollowCheck(@Param("mid") String mid);

	
}
