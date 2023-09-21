package com.kh.cuddly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.ProductDto;

@Controller
@RequestMapping("/cuddly/product")
public class ProductController {
	
	@Autowired
	ProductDao productDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		int count = productDao.countList(vo);
		vo.setCount(count);
		vo.setSize(8);
		
		List<ProductDto> list = productDao.selectList(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/product/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		float reviewAvg = 4.9F;
				
		model.addAttribute("productDto", productDto);
		model.addAttribute("reviewAvg", reviewAvg);
		
		return "/WEB-INF/views/product/detail.jsp";
	}
	
	
}
