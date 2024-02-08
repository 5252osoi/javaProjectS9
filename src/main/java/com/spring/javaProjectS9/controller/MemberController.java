package com.spring.javaProjectS9.controller;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS9.service.MemberService;
import com.spring.javaProjectS9.service.PostService;
import com.spring.javaProjectS9.vo.FollowVO;
import com.spring.javaProjectS9.vo.MemberVO;
import com.spring.javaProjectS9.vo.PostVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PostService postService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/join",method = RequestMethod.GET)
	public String joinGet() {
		return "member/join";
	}
	@RequestMapping(value = "/join",method = RequestMethod.POST)
	public String joinPost(MemberVO vo) {

		//비밀번호암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		int res=memberService.setMemberJoinOk(vo);
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck",method = RequestMethod.POST)
	public String  idCheckPost(String mid) {
		int res=0;
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo!=null) res=1;
		
		return res+"";
	}
	//팔로우
	@ResponseBody
	@RequestMapping(value ="/userFollow",method = RequestMethod.POST)
	public String  userFollowPost(String follower,String followee) {
		int res=0;
		//follower=로그인한유저 /followee=팔로우할유저
		System.out.println("로그인중 유저 : "+follower+", 팔로우 할 유저 : "+followee);
		res=memberService.setUserFollow(follower,followee);
		System.out.println("결과 : "+res);
		if(res!=0) {
			memberService.setUserFollowUpdate();
			memberService.setUserFolloweeUpdate();
		}
		return res+"";
	}
	//언팔로우
	@ResponseBody
	@RequestMapping(value ="/userUnFollow",method = RequestMethod.POST)
	public String  userUnFollowPost(String follower,String followee) {
		int res=0;
		//follower=로그인한유저 /followee=팔로우할유저
		res=memberService.setUserUnFollow(follower,followee);
		if(res!=0) {
			memberService.setUserFollowUpdate();
			memberService.setUserFolloweeUpdate();
		}
		return res+"";
	}
	
	@RequestMapping(value = "/userPage",method = RequestMethod.GET)
	public String userPageGet(Model model,HttpSession session, String mid) {
		String sMid = (String) session.getAttribute("sMid");
		MemberVO mvo = memberService.getMemberIdCheck(mid);
		List<PostVO> vos = postService.getUserPagePost(mid);
		List<FollowVO> fvos=memberService.getFollowCheck(sMid);
		model.addAttribute("mvo", mvo);
		model.addAttribute("vos",vos);
		model.addAttribute("fvos",fvos);
		return "member/userPage";
	}
	
	
}
