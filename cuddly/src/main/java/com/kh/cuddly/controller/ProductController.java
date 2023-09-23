package com.kh.cuddly.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.CreatorProductDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductOptionDto;

@Controller
@RequestMapping("/cuddly/product")
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
	
	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		int count = productDao.countList(vo);
		vo.setCount(count);
		vo.setSize(8);
		
		if(vo.getCreatorName() != null) {
			model.addAttribute("creator",vo.getCreatorName());
		}
		
		List<ProductDto> list = productDao.selectList(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/product/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		CreatorDto creatorDto = creatorDao.selectOneByProductNo(productNo);
		String creatorName = creatorDto.getCreatorName();
		List<ProductOptionDto> optionList = productOptionDao.selectListByProductNo(productNo); 
		float reviewAvg = reviewDao.reviewAvg(productNo);
		
		
		model.addAttribute("optionList", optionList);
		model.addAttribute("creatorName", creatorName);
		model.addAttribute("productDto", productDto);
		model.addAttribute("reviewAvg", reviewAvg);
		
		return "/WEB-INF/views/product/detail.jsp";
	}
	
	@RequestMapping("/cartInsert")
	public String cartInsert(@ModelAttribute CartDto cartDto, HttpSession session, int productNo) {
		
		String memberId = (String) session.getAttribute("name");
		int cartNo = cartDao.sequence();
		cartDto.setCartNo(cartNo);
		cartDto.setMemberId(memberId);
		
		ProductDto productDto=productDao.selectOne(productNo);
		
		int price=  productDto.getProductPrice();
		
		int totalPrice = cartDto.getCartCount() * price;
		
		cartDto.setCartPrice(totalPrice);
		
		cartDao.insert(cartDto);
		
		return "redirect:/cuddly/orders/insert?cartNo="+cartDto.getCartNo();
		
		
	}
	
	
	@RequestMapping("/creator")
	public String creators(Model model) {
		List<CreatorDto> list = creatorDao.selectList();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/product/creator.jsp";
	}
	
	
}
