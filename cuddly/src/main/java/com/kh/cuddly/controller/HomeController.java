package com.kh.cuddly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("/cuddly")
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
}
