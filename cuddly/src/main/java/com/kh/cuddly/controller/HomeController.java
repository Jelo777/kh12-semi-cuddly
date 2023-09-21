package com.kh.cuddly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/cuddly")
@Controller
public class HomeController {
	
	@RequestMapping("")
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
}
