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

import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.QnaDto;

@Controller
@RequestMapping("/cuddly/qna")
public class QnaController {
	
	@Autowired
	QnaDao qnaDao;
	
	@GetMapping("/write")
	public String write() {
		
		return "/WEB-INF/views/qna/insert.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute QnaDto qnaDto,
			HttpSession session) {
		
		int qnaNo = qnaDao.sequence();
		
		qnaDto.setQnaNo(qnaNo);
		
		qnaDao.insert(qnaDto);
		
		return "redirect:/cuddly/qna/write";

	}
	
	@GetMapping("/change")
	public String edit(HttpSession session, Model model, int qnaNo) {
		
		QnaDto qnaDto = qnaDao.selectOne(qnaNo);
		
		model.addAttribute("qnaDto",qnaDto);
		
		return "/WEB-INF/views/qna/edit.jsp";
		
	}
	
	@PostMapping("/change")
	public String edit(@ModelAttribute QnaDto qnaDto, int qnaNo) {
		
		qnaDto.setQnaNo(qnaNo);
		
		qnaDao.update(qnaDto);
		
		return "redirect:/cuddly/qna/change?qnaNo="+qnaNo;
		
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<QnaDto> list = qnaDao.selectList();
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/qna/list.jsp";
		
	}
	
}
