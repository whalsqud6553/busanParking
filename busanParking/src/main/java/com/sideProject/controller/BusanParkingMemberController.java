package com.sideProject.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sideProject.model.BusanParkingMemberDTO;
import com.sideProject.service.BusanParkingMemberService;

@Controller
@RequestMapping("/member")
public class BusanParkingMemberController {
	
	@Autowired
	private BusanParkingMemberService busanParkingMemberService;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public ModelAndView join(BusanParkingMemberDTO dto) {
		ModelAndView mav = new ModelAndView("member/join_msg");
		int row = busanParkingMemberService.join(dto);
		
		mav.addObject("row", row);
		return mav;
	}

	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(BusanParkingMemberDTO dto, HttpSession session) {
		BusanParkingMemberDTO login = busanParkingMemberService.login(dto);
		if(login != null) {
			session.setAttribute("user", login);
		}
		else {
			return "member/login_msg";
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 아이디 중복여부 AJAX
	@GetMapping("/idDuplicationCheck")
	@ResponseBody	// ajax를 사용하기위한 어노테이션
	public Map<Object, Object> idCheck(String member_id) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		BusanParkingMemberDTO dto = busanParkingMemberService.idDuplicationCheck(member_id);
		// 중복된 아이디가 있다면 1
		if(dto != null) {
			map.put("row", 1);
		}
		// 중복된 아이디가 없다면 0
		else {
			map.put("row", 0);
		}
		return map;
	}
	
	// 닉네임 중복여부 AJAX
	@GetMapping("/nickDuplicationCheck")
	@ResponseBody
	public Map<Object, Object> nickCheck(String member_nick) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		BusanParkingMemberDTO dto = busanParkingMemberService.nickDuplicationCheck(member_nick);
		if(dto != null) {
			map.put("row", 1);
		}
		else {
			map.put("row", 0);
		}
		
		return map;
	}
}
