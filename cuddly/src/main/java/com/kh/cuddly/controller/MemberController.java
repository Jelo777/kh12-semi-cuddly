package com.kh.cuddly.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dto.MemberDto;

@Controller
@RequestMapping("/cuddly/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish";
	}
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto,
								HttpSession session) {
		//[1]사용자가 입력한 아이디로 데이터베이스에서 조회
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		if(findDto == null) {
			return "redirect:login?error";
		}
		
		boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
		
		if(isCorrectPw) {
			
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			return "redirect:/cuddly";
		}
		else {
			return "redirect:login?error";
		}	
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		session.removeAttribute("level");
		return "redirect:/cuddly";
	}
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		//[1]세션에서 아이디 가져오기
		String memberId =(String)session.getAttribute("name");
		if(memberId ==null) {
			return "redirect:login";
		}
		//[2] 가져온 아이디로 회원 정보 조회
		MemberDto memberDto =memberDao.selectOne(memberId);
		//[3] 조회한 정보를 모델에 첨부한다
		model.addAttribute("memberDto",memberDto);
		return "/WEB-INF/views/member/mypage.jsp";
		
	}
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	@PostMapping("/password")
	public String password(HttpSession session,
									@RequestParam String originPw,
									@RequestParam String changePw) {
		String memberId=(String)session.getAttribute("name");
		MemberDto memberDto =memberDao.selectOne(memberId);
		
		if(memberDto.getMemberPw().equals(originPw)){
			memberDao.updateMemberPw(memberId, changePw);
			return "redirect:passwordFinish";
		}
		else {
			return "redirect:password?error";
		}
	}
	
	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
		return "/WEB-INF/views/member/passwordFinish.jsp";
	}
	
	//개인정보 변경
	@GetMapping("/change")
	public String change(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/change.jsp";
	}
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto inputDto, 
									HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		MemberDto findDto =memberDao.selectOne(memberId);
		if(inputDto.getMemberPw().equals(findDto.getMemberPw())) {
			inputDto.setMemberId(memberId);
			memberDao.updateMemberInfo(inputDto);
			return "redirect:mypage";
		}
		else {
			return "redirect:change?error";
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
