package com.kh.cuddly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductOptionDto;

@Controller
@RequestMapping("/cuddly/product")
public class ProductController {
	
	@Autowired
	ProductDao productDao;
	@Autowired
	ProductOptionDao productOptionDao;
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/product/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(
						@ModelAttribute ProductDto productDto,
						@ModelAttribute ProductOptionDto productOptionDto
						) {
		int productNo = productDao.sequence();

		productOptionDto.setProductNo(productNo);
		productDto.setProductNo(productNo);
		
		
		productDao.insert(productDto);
		productOptionDao.insert(productOptionDto);
		return "redirect:상품관리페이지";
	}
	
}
