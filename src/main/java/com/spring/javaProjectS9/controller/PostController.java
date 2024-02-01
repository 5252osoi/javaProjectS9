package com.spring.javaProjectS9.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javaProjectS9.service.MemberService;
import com.spring.javaProjectS9.service.PostService;
import com.spring.javaProjectS9.vo.FollowVO;
import com.spring.javaProjectS9.vo.MemberVO;
import com.spring.javaProjectS9.vo.PostLikeVO;
import com.spring.javaProjectS9.vo.PostReplyVO;
import com.spring.javaProjectS9.vo.PostVO;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	PostService postService;
	
	
	
	//메인화면출력
	@RequestMapping(value = "/main",method = RequestMethod.GET)
	public String postMainGet(Model model,String mid,HttpSession session,
			@RequestParam(name = "curPage",defaultValue = "1",required = false)int curPage,
			@RequestParam(name = "pageSize",defaultValue = "5",required = false)int pageSize
			) {
		int startIdxNo=(curPage-1)*pageSize;
		String sMid = (String) session.getAttribute("sMid");
		
		//로그인후 메인화면 출력할때 보여야하는 내용
		//게시글리스트 5개
		List<PostVO> vos = postService.getPostList(startIdxNo,pageSize);
		
		//로그인한사람의 팔로우목록
		List<FollowVO> fvos=memberService.getFollowCheck(sMid);
		
		//게시글에 좋아요 여부 체크
		List<PostLikeVO> lVos = postService.getCheckLike(startIdxNo,pageSize,sMid);
		
		//게시글에 달린 댓글
		//각 게시글의 idx 가져오기 (해당 idx에 딸린 댓글 가져오기위함)
		int[] postIdxArr = new int[vos.size()];
		for(int i=0; i<vos.size(); i++) {
			postIdxArr[i]=vos.get(i).getIdx();
		}
		//게시글의 수가 1~5개 사이일 때 글에 딸린 댓글을 가져옴
		if(postIdxArr.length >= 1 && postIdxArr.length <= 5) {
			
			List<PostReplyVO> rVos=postService.getReplyList(postIdxArr);
			model.addAttribute("rVos",rVos);
		}
		
		//우측바추천인목록
		List<MemberVO> mVos = memberService.getRecommendUser(sMid);
		//상단바추천인목록
		List<MemberVO> rmVos = memberService.getRanRecommendUser(sMid);
		
		
		model.addAttribute("vos",vos);
		model.addAttribute("fvos",fvos);
		model.addAttribute("mVos",mVos);
		model.addAttribute("rmVos",rmVos);
		model.addAttribute("lVos",lVos);
		model.addAttribute("curPage",curPage);
		model.addAttribute("startIdxNo",startIdxNo);
		
		return "post/main";
	}
	
	//스크롤시의 페이지로딩
	@ResponseBody
	@RequestMapping(value = "/scrollPage",method = RequestMethod.POST)
	public ModelAndView scrollPagePost(Model model,String mid,HttpSession session,
			@RequestParam(name = "curPage",defaultValue = "1",required = false)int curPage,
			@RequestParam(name = "pageSize",defaultValue = "5",required = false)int pageSize
			) {
		int startIdxNo=(curPage-1)*pageSize;
		String sMid = (String) session.getAttribute("sMid");
		//게시글리스트 5개
		List<PostVO> vos = postService.getPostList(startIdxNo,pageSize);
		//게시글에 좋아요 여부 체크
		List<PostLikeVO> lVos = postService.getCheckLike(startIdxNo,pageSize,sMid);
		
		//게시글에 달린 댓글
		//각 게시글의 idx 가져오기 (해당 idx에 딸린 댓글 가져오기위함)
		int[] postIdxArr = new int[vos.size()];
		for(int i=0; i<vos.size(); i++) {
			postIdxArr[i]=vos.get(i).getIdx();
		}
		//게시글의 수가 1~5개 사이일 때 글에 딸린 댓글을 가져옴
		if(postIdxArr.length >= 1 && postIdxArr.length <= 5) {
			List<PostReplyVO> rVos=postService.getReplyList(postIdxArr);
			model.addAttribute("rVos",rVos);
		}
		model.addAttribute("vos",vos);
		model.addAttribute("lVos",lVos);
		model.addAttribute("curPage",curPage);
		model.addAttribute("startIdxNo",startIdxNo);
		
		//ModelAndView에 담아서 return
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/post/scrollPage");
		
		return mav;
	}
	
	//업로드
	@RequestMapping(value = "/postUpload",method = RequestMethod.POST)
	public String postUploadPost(
			@ModelAttribute PostVO vo, 
			@RequestParam("files") List<MultipartFile> files, 
			RedirectAttributes redirectAttributes ) {
		
		int res = 0;
		
		//파일 넘어오는지 확인할거임
		if(!files.isEmpty()) {
			System.out.println("포스트업로드-파일이 있음");
		}
		
		try {
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String dir = request.getSession().getServletContext().getRealPath("/resources/data/post/");
			//경로확인하기
			System.out.println("포스트업로드-경로확인 : "+dir);
			
			Path path = Path.of(dir);
			if(Files.notExists(path)) {
				Files.createDirectories(path);
			}
			List<String> originalFileNames = new ArrayList<>();
            List<String> systemFileNames = new ArrayList<>();
			
			
			 for (MultipartFile file : files) {
                if (!file.isEmpty()) {
					// 각각 파일 저장
					String originalFileName = file.getOriginalFilename();
                    String systemFileName = (UUID.randomUUID().toString()).substring(0,8) + originalFileName;
                    Path dest = path.resolve(systemFileName);
                    Files.copy(file.getInputStream(), dest);
                    
                    //리스트에 파일정보추가
                    originalFileNames.add(originalFileName);
                    systemFileNames.add(systemFileName);
				}
			}
            // 리스트를 문자열로 변환하여 VO에 저장
            vo.setFName(String.join("/", originalFileNames));
            vo.setFSName(String.join("/", systemFileNames));
			
			System.out.println("원본파일명들 : " + vo.getFName());
			System.out.println("저장되는파일명들 : " + vo.getFSName());
			res=postService.setPostUpload(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(res!=0) {
			res = memberService.setPostCnt();
		}
		
		if(res!=0) return "redirect:/message/postUploadOk";
		else return "redirect:/message/postUploadNo";
	}
	
	//포스트삭제
	@ResponseBody
	@RequestMapping(value = "/postDelete",method = RequestMethod.POST)
	public String postDelete(int idx ) {

		System.out.println("넘어온 idx(포스트삭제) : " +idx);

		int res=0;
		res = postService.setPostAndReplyDelete(idx);
		if (res!=0) {
			//해당 포스트에 달려있는 댓글도 모두 삭제
			res = postService.setPostDelete(idx);
		}
		
		return res+"";
	}
	//포스트수정
	@RequestMapping(value = "/postEdit",method = RequestMethod.POST)
	public String postEditPost(int idx, String content) {
		System.out.println("넘어온 idx(포스트수정) : " + idx);
		int res=0;
		res = postService.setPostEdit(idx,content);
		
		return res+"";
	}
	//리플작성
	@ResponseBody
	@RequestMapping(value = "/postReplyInput",method = RequestMethod.POST)
	public String postReplyInputPost(int postIdx,String hostIp, String content,HttpSession session) {
		int res=0;
		String mid = (String) session.getAttribute("sMid");
		System.out.println("(댓글작성)게시글번호 : "+postIdx+" / 댓글내용 : " +content );
		res = postService.setPostReplyInput(postIdx,mid,hostIp,content);
		if(res!=0) {
			res=postService.setPostReplyCnt();
		}
		return res+"";
	}
	//리플삭제
	@ResponseBody
	@RequestMapping(value = "/postReplyDelete",method = RequestMethod.POST)
	public String postReplyDeletePost(int idx,String mid) {
		int res=0;
		System.out.println("댓글idx : "+idx );
		res = postService.setPostReplyDelete(idx);
		if(res!=0) {
			res=postService.setPostReplyCnt();
		}
		return res+"";
	}
	//좋아요버튼
	@ResponseBody
	@RequestMapping(value = "/likePlus",method = RequestMethod.POST)
	public String likePlusPost(int idx,String mid) {
		int res=0;
		res=postService.setLikePlus(idx,mid);
		if(res!=0) {
			res=postService.setEditLikes();
		}
		return res+"";
	}
	//좋아요버튼 다시입력
	@ResponseBody
	@RequestMapping(value = "/likeMinus",method = RequestMethod.POST)
	public String likeMinusPost(int idx,String mid) {
		int res=0;
		res=postService.setLikeMinus(idx,mid);
		if(res!=0) {
			res=postService.setEditLikes();
		}
		return res+"";
	}
	
	//hover로 모달창출력
	@ResponseBody
	@RequestMapping(value ="/userModalInfo",method = RequestMethod.POST)
	public ModelAndView userModalInfoPost(Model model, String mid) {
		
		MemberVO mvo = memberService.getMemberIdCheck(mid);
		
		//mid로 검색한뒤 최근게시글을 3개까지 가져옴(첫 이미지만 3개씀)
		List<PostVO> pvos = postService.getUserModalInfo(mid);
		List<FollowVO> fvos=memberService.getFollowCheck(mid);
		//modelAndView에 담아서 보낸다음 .html로 출력하는방식
		model.addAttribute("mvo",mvo);
		model.addAttribute("pvos",pvos);
		model.addAttribute("fvos",fvos);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/post/userModalInfo");
		return mav;
	}
	@ResponseBody
	@RequestMapping(value = "/showPostInfo",method = RequestMethod.POST)
	public ModelAndView showPostInfoPost(Model model, HttpSession session ,int idx) {
		String mid = (String) session.getAttribute("sMid");
		System.out.println("idx 받아온값 (showPostInfo) : " + idx);
		PostVO vo = postService.getShowPostInfo(idx);
		List<PostReplyVO> rvos = postService.getShowPostReply(idx);
		PostLikeVO lvo = postService.getShowPostLikeCheck(mid,idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("rVos",rvos);
		model.addAttribute("lVo",lvo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/post/showPostInfo");
		mav.addObject("vo",vo);
		mav.addObject("rVos",rvos);
		mav.addObject("lVo",lvo);
		
		return mav;
	}
	
}
