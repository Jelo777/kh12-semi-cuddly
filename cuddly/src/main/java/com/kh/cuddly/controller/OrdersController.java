package com.kh.cuddly.controller;





import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.dto.OrdersDto;




@Controller
@RequestMapping("/cuddly/orders")
public class OrdersController {
	
	
	@Autowired
	OrdersDao ordersDao;
	
	@Autowired
	OrdersDetailDao ordersDetailDao;
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	MemberDao memberDao;
	
	
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/orders/insert.jsp";
	}
	
	@PostMapping("/insert")
	public String insert(OrdersDto ordersDto) {
		int ordersNo = ordersDao.sequence();
		ordersDto.setOrdersNo(ordersNo);
		ordersDao.insert(ordersDto);
		return "redirect:주문관리페이지";
	}
	
	

	@RequestMapping("/detail")
	public String ordersDetail(@RequestParam("ordersNo") int ordersNo, Model model) {
		OrdersDto ordersDto = ordersDao.selectOne(ordersNo);
		model.addAttribute("ordersDto", ordersDto);
		
		MemberDto memberDto = memberDao.selectOne(ordersDto.getMemberId());
		model.addAttribute("memberDto", memberDto);
		
		return "/WEB-INF/views/orders/detail.jsp";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		List<CartDto> cartList = cartDao.selectCartList();
		model.addAttribute("cartList", cartList);
		return "/WEB-INF/views/cart/list.jsp";
	}
}
