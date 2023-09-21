package com.kh.cuddly.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
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
	
	//이메일로 아이디,비밀번호 찾기
	@Autowired
	private JavaMailSender sender;
	
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
			return "redirect:changeFinish";
		}
		else {
			return "redirect:change?error";
		}
	}
	@RequestMapping("/changeFinish")
	public String changeFinish() {
		return "/WEB-INF/views/member/changeFinish.jsp";
	}
	
	@GetMapping("/exit")
	public String exit() {
		return "/WEB-INF/views/member/exit.jsp";
	}
	@PostMapping("/exit")
	public String exit(HttpSession session, @RequestParam String memberPw) {
		String memberId=(String)session.getAttribute("name");
		MemberDto memberDto =memberDao.selectOne(memberId);
		if(memberDto.getMemberPw().equals(memberPw)) {
			
			memberDao.delete(memberId);
			session.removeAttribute("name");
			return "redirect:exitFinish";
		}
		else {
			return "redirect:exit?error";
		}
	}
	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "/WEB-INF/views/member/exitFinish.jsp";
	}
	
	@GetMapping("/findId")
	public String findId() {
		return "/WEB-INF/views/member/findId.jsp";
	}
	
	@PostMapping("/findId")
	public String findId(@RequestParam String memberEmail) {
		MemberDto memberDto =memberDao.selectOneByEmail(memberEmail);
		if(memberDto !=null) {
			SimpleMailMessage message =new SimpleMailMessage();
			message.setTo(memberEmail);
			message.setSubject("아이디 찾기 결과");
			message.setText("아이디는 [" + memberDto.getMemberId() +"] 입니다~ 네 찾아드렸어요");
			sender.send(message);
			return "redirect:findIdFinish";
		}
		else {
			return "redirect:findId?error";
		}
	}
	@RequestMapping("/findIdFinish")
	public String findIdFinish() {
		return "/WEB-INF/views/member/findIdFinish.jsp";
	}
	
	
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}
	@PostMapping("/findPw")
	public String findPw(@RequestParam String memberEmail) {
		MemberDto memberDto =memberDao.selectOneByEmail(memberEmail);
		if(memberDto !=null) {
			SimpleMailMessage message =new SimpleMailMessage();
			message.setTo(memberEmail);
			message.setSubject("비밀번호 찾기 결과");
			message.setText("비밀번호는 [" + memberDto.getMemberPw() +"] 입니다~ 네 찾아드렸어요");
			sender.send(message);
			return "redirect:findPwFinish";
		}
		else {
			return "redirect:findPw?error";
		}
		
	}
	@RequestMapping("/findPwFinish")
	public String findPwFinish() {
		return "/WEB-INF/views/member/findPwFinish.jsp";
	}
	
	
	
	
	
	
	
	
	
	
}
