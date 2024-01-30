package com.spring.javaProjectS9.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS9.dao.MemberDAO;
import com.spring.javaProjectS9.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public List<MemberVO> getRecommendUser(String sMid) {
		return memberDAO.getRecommendUser(sMid);
	}

	@Override
	public List<MemberVO> getRanRecommendUser(String sMid) {
		return memberDAO.getRanRecommendUser(sMid);
	}

	@Override
	public int setPostCnt() {
		return memberDAO.setPostCnt();
	}

}
