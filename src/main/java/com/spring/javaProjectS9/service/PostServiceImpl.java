package com.spring.javaProjectS9.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS9.dao.PostDAO;
import com.spring.javaProjectS9.vo.PostLikeVO;
import com.spring.javaProjectS9.vo.PostReplyVO;
import com.spring.javaProjectS9.vo.PostVO;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	PostDAO postDAO;

	@Override
	public List<PostVO> getPostList(int startIdxNo, int pageSize) {
		return postDAO.getPostList(startIdxNo, pageSize);
	}

	@Override
	public List<PostLikeVO> getCheckLike(int startIdxNo, int pageSize, String sMid) {
		return postDAO.getCheckLike(startIdxNo,pageSize,sMid);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<PostReplyVO> getReplyList(int[] postIdxArr) {
	    
		HashMap hm = new HashMap();
		hm.put("idxType", postIdxArr);
	    return postDAO.getReplyList(hm);
	}

	@Override
	public int setPostUpload(PostVO vo) {
		return postDAO.setPostUpload(vo);
	}

	@Override
	public int setPostDelete(int idx) {
		return postDAO.setPostDelete(idx);
	}

	@Override
	public int setPostEdit(int idx, String content) {
		return postDAO.setPostEdit(idx,content);
	}

	@Override
	public int setPostReplyInput(int postIdx, String mid, String hostIp, String content) {
		return postDAO.setPostReplyInput(postIdx,mid,hostIp,content);
	}

	@Override
	public int setPostReplyDelete(int idx) {
		return postDAO.setPostReplyDelete(idx);
	}

	@Override
	public int setLikePlus(int idx, String mid) {
		return postDAO.setLikePlus(idx,mid);
	}

	@Override
	public int setLikeMinus(int idx, String mid) {
		return postDAO.setLikeMinus(idx,mid);
	}

	@Override
	public List<PostVO> getUserModalInfo(String mid) {
		return postDAO.getUserModalInfo(mid);
	}
	
}
