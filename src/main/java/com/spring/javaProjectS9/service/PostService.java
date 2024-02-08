package com.spring.javaProjectS9.service;

import java.util.List;

import com.spring.javaProjectS9.vo.PostLikeVO;
import com.spring.javaProjectS9.vo.PostReplyVO;
import com.spring.javaProjectS9.vo.PostVO;

public interface PostService {

	public List<PostVO> getPostList(int startIdxNo, int pageSize);

	public List<PostLikeVO> getCheckLike(int startIdxNo, int pageSize, String sMid);

	public List<PostReplyVO> getReplyList(int[] postIdxArr);

	public int setPostUpload(PostVO vo);

	public int setPostDelete(int idx);

	public int setPostEdit(int idx, String content);

	public int setPostReplyInput(int postIdx, String mid, String hostIp, String content);

	public int setPostReplyDelete(int idx);

	public int setLikePlus(int idx, String mid);

	public int setLikeMinus(int idx, String mid);

	public List<PostVO> getUserModalInfo(String mid);

	public int setPostAndReplyDelete(int idx);

	public int setEditLikes();

	public List<PostVO> getUserPagePost(String mid);

	public int setPostReplyCnt();

	public PostVO getShowPostInfo(int idx);

	public List<PostReplyVO> getShowPostReply(int idx);

	public PostLikeVO getShowPostLikeCheck(String mid, int idx);

	public int setLikeDelete(int idx);

}
