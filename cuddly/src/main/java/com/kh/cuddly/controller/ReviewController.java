package com.kh.cuddly.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.ReviewDto;



@Controller
@RequestMapping("/cuddly/review")
public class ReviewController {
	
	@Autowired
	ReviewDao reviewDao;
	
	@GetMapping("/write")
	public String write() {
		
		return "/WEB-INF/views/review/insert.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto,
			HttpSession session) {
		
		
		
		reviewDao.insert(reviewDto);
		
		
		return "redirect:/cuddly/review/write";

	}

}
