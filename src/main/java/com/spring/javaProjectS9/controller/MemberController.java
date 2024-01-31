package com.spring.javaProjectS9.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS9.service.MemberService;
import com.spring.javaProjectS9.service.PostService;
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

	@ResponseBody
	@RequestMapping(value ="/userFollow",method = RequestMethod.POST)
	public String  userFollowPost(String follower,String followee) {
		int res=0;
		//follower=로그인한유저 /followee=팔로우할유저
		res=memberService.setUserFollow(follower,followee);
		if(res!=0) {
			res=memberService.setUserFollowUpdate();
			if(res!=0) {
				res=memberService.setUserFolloweeUpdate();
			}
		}
		return res+"";
	}
	
	@RequestMapping(value = "/userPage",method = RequestMethod.GET)
	public String userPageGet(Model model, String mid) {
		
		MemberVO mvo = memberService.getMemberIdCheck(mid);
		List<PostVO> vos = postService.getUserPagePost(mid);
		
		model.addAttribute("mvo", mvo);
		model.addAttribute("vos",vos);
		
		return "member/userPage";
	}
	
	
}
