package com.kh.cuddly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.ProductDto;

@RequestMapping("/cuddly")
@Controller
public class HomeController {
	
	@Autowired
	ProductDao productDao;
	@Autowired
	CreatorDao creatorDao;
	
	@RequestMapping("")
	public String home() {
		return "/WEB-INF/views/home.jsp";
	}
	
	@RequestMapping("/search")
	public String search(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		
		int count = productDao.countList(vo);
		String keyword = vo.getKeyword();
		vo.setCount(count);
		vo.setSize(8);
		List<ProductDto> productList = productDao.selectList(vo);
		List<CreatorDto> creatorList = creatorDao.selectList(keyword);
		
		if(productList.size()==0) productList = null;
		if(creatorList.size()==0) creatorList = null;
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("productList", productList);
		model.addAttribute("creatorList", creatorList);
		return "/WEB-INF/views/search.jsp";
	}
}
