package com.spring.javaProjectS9.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS9.vo.PostLikeVO;
import com.spring.javaProjectS9.vo.PostReplyVO;
import com.spring.javaProjectS9.vo.PostVO;

public interface PostDAO {

	public List<PostVO> getPostList(@Param("startIdxNo")int startIdxNo, @Param("pageSize")int pageSize);

	public List<PostLikeVO> getCheckLike(@Param("startIdxNo")int startIdxNo, @Param("pageSize")int pageSize, @Param("sMid")String sMid);

	public List<PostReplyVO> getReplyList(@SuppressWarnings("rawtypes") @Param("hm") HashMap hm);

	public int setPostUpload(@Param("vo") PostVO vo);

	public int setPostDelete(@Param("idx") int idx);

	public int setPostEdit(@Param("idx") int idx,@Param("content") String content);

	public int setPostReplyInput(@Param("postIdx")int postIdx, @Param("mid")String mid, @Param("hostIp")String hostIp, @Param("content")String content);

	public int setPostReplyDelete(@Param("idx") int idx);

	public int setLikePlus(@Param("idx") int idx, @Param("mid") String mid);

	public int setLikeMinus(@Param("idx") int idx, @Param("mid") String mid);

	public List<PostVO> getUserModalInfo(@Param("mid") String mid);

	public int setPostAndReplyDelete(@Param("idx") int idx);

	public int setEditLikes();

	public List<PostVO> getUserPagePost(@Param("mid") String mid);

	public int setPostReplyCnt();

	public PostVO getShowPostInfo(@Param("idx") int idx);

	public List<PostReplyVO> getShowPostReply(@Param("idx") int idx);

	public PostLikeVO getShowPostLikeCheck(@Param("mid") String mid, @Param("idx") int idx);

	public int setLikeDelete(@Param("idx")int idx);

	

}
