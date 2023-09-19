package com.kh.cuddly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.dao.FaqDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dto.FaqDto;

@Controller
@RequestMapping("/cuddly/faq")
public class FaqController {
	
	@Autowired
	private FaqDao faqDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/write")
	private String write() {
		return "/WEB-INF/views/faq/write.jsp";
	}
	
	@PostMapping("/write")
	private String write(@ModelAttribute FaqDto faqDto) {
		int faqNo = faqDao.sequence();
		faqDto.setFaqNo(faqNo);
		
		faqDao.insert(faqDto);
		
		return "redirect:detail?faqNo="+faqNo;
	}

}