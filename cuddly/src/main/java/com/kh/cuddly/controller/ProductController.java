package com.kh.cuddly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.VO.ProductListVO;
import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.CreatorProductDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductListDto;
import com.kh.cuddly.dto.ProductOptionDto;
import com.kh.cuddly.dto.QnaDto;
import com.kh.cuddly.dto.ReviewDto;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductDao productDao;
	@Autowired
	CreatorDao creatorDao;
	@Autowired
	CreatorProductDao creatorProductDao;
	@Autowired
	ProductOptionDao productOptionDao;
	@Autowired
	ReviewDao reviewDao;
	@Autowired
	CartDao cartDao;
	@Autowired
	QnaDao qnaDao;
	
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		CreatorDto creatorDto = creatorDao.selectOneByProductNo(productNo);
		String creatorName = creatorDto.getCreatorName();
		List<ProductOptionDto> optionList = productOptionDao.selectListByProductNo(productNo); 
		float reviewAvg = reviewDao.reviewAvg(productNo);
		List<ReviewDto> reviewList = reviewDao.selectListByProduct(productNo);
		List<QnaDto> qnaList = qnaDao.selectList(productNo);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("optionList", optionList);
		model.addAttribute("creatorName", creatorName);
		model.addAttribute("productDto", productDto);
		model.addAttribute("reviewAvg", reviewAvg);
		
		return "/WEB-INF/views/product/detail.jsp";
	}
	
	
	@RequestMapping("/creator")
	public String creators(Model model) {
		List<CreatorDto> list = creatorDao.selectListJoinImage();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/product/creator.jsp";
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") ProductListVO vo, 
						Model model) {
		
		if(vo.isCreator()) {
			vo.setCount(productDao.countList(vo));
			CreatorDto creatorDto = creatorDao.selectOne(vo.getCreator());
			List<ProductListDto> list = productDao.selectListByCreator(vo);
			model.addAttribute("creatorDto", creatorDto);
			model.addAttribute("list", list);
		}
		else if(vo.isItem()) {
			vo.setCount(productDao.countList(vo));
			List<ProductListDto> list = productDao.selectListByProductItem(vo);
			model.addAttribute("list", list);
		}
		else {
			vo.setCount(productDao.countList(vo));
			List<ProductListDto> list = productDao.selectList(vo);
			model.addAttribute("list", list);
		}
		
		return "/WEB-INF/views/product/list.jsp";
	}
	
	
}