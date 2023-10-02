package com.kh.cuddly.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.QnaDto;

@Controller
@RequestMapping("/cuddly/qna")
public class QnaController {
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping("/write")
	public String write(@ModelAttribute QnaDto qnaDto) {
		int qnaNo = qnaDao.sequence();
		qnaDto.setQnaNo(qnaNo);
		qnaDao.insert(qnaDto);
		return "redirect:/cuddly/product/detail?productNo="+qnaDto.getProductNo() + "#qnaList";
	}
	
//	@GetMapping("/change")
//	public String edit(HttpSession session, Model model, int qnaNo) {
//		
//		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
//		
//		model.addAttribute("qnaDto",qnaDto);
//		
//		return "/WEB-INF/views/qna/edit.jsp";
//		
//	}
	
	@RequestMapping("/change")
	public String edit(@ModelAttribute QnaDto qnaDto, int qnaNo) {
		
		qnaDto.setQnaNo(qnaNo);
		
		qnaDao.update(qnaDto);
		
		return "redirect:/cuddly/qna/memberList?memberId="+qnaDto.getMemberId();
		
	}
	
	@RequestMapping("/delete")
	public String delete(int qnaNo,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		
		qnaDao.delete(qnaNo);
		
		return "redirect:/cuddly/qna/memberList?memberId="+memberId;
		
	}
	
	@RequestMapping("/adminList")
	public String list(Model model) {
		List<QnaDto> list = qnaDao.selectList();
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/qna/list.jsp";
		
	}
	
	@RequestMapping("/memberList")
	public String memberList(Model model,HttpSession session,
			@ModelAttribute(name = "vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");
		
		int count = qnaDao.countList(vo,memberId);
		
		vo.setCount(count);
		vo.setSize(5);
		
		
		List<QnaDto> list = qnaDao.memberList(memberId,vo);
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/qna/memberList.jsp";
		
	}
	
}
