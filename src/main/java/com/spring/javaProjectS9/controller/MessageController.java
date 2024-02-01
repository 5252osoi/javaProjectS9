package com.spring.javaProjectS9.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	@RequestMapping(value = "/message/{msgFlag}",method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag,String mid, Model model, 
			@RequestParam(name="temp", defaultValue="",required=false) String temp,
			@RequestParam(name="idx", defaultValue="0",required=false) int idx) {
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되셨습니다.");
			model.addAttribute("url", "post/main");
		} else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "/");
		} else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 완료");
			model.addAttribute("url", "/");
		} else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입실패");
			model.addAttribute("url", "member/join");
		} else if(msgFlag.equals("needLogin")) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/");
		} else if(msgFlag.equals("postUploadOk")) {
			model.addAttribute("msg", "포스트작성완료");
			model.addAttribute("url", "post/main");
		} else if(msgFlag.equals("postUploadNo")) {
			model.addAttribute("msg", "포스트작성실패");
			model.addAttribute("url", "post/main");
		}
		
		return "include/message";
	}
	
}
