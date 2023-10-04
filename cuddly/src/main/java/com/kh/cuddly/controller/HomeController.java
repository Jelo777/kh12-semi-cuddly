package com.kh.cuddly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.cuddly.VO.ProductListVO;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.ProductListDto;

@RequestMapping("/cuddly")
@Controller
public class HomeController {
	
	@Autowired
	ProductDao productDao;
	@Autowired
	CreatorDao creatorDao;
	
	@RequestMapping("")
	public String home(Model model,@ModelAttribute(name = "vo") ProductListVO vo,
					@ModelAttribute(name = "vo2") ProductListVO vo2
					) {
		List<ProductListDto> sortByNew = productDao.selectList(vo);
		
		vo2.setTarget("wishlist_count");
		List<ProductListDto> sortByBest = productDao.selectList(vo2);
		model.addAttribute("sortByNew", sortByNew);
		model.addAttribute("sortByBest", sortByBest);
		return "/WEB-INF/views/home.jsp";
	}
	
	@RequestMapping("/search")
	public String search(@ModelAttribute(name = "vo") ProductListVO vo, Model model) {
		
		int count = productDao.countList(vo);
		String keyword = vo.getKeyword();
		vo.setCount(count);
		List<ProductListDto> productList = productDao.selectList(vo);
		List<CreatorDto> creatorList = creatorDao.selectList(keyword);
		
		if(productList.size()==0) productList = null;
		if(creatorList.size()==0) creatorList = null;
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("productList", productList);
		model.addAttribute("creatorList", creatorList);
		return "/WEB-INF/views/search.jsp";
	}
}
