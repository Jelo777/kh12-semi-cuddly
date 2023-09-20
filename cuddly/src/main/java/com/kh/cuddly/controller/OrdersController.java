package com.kh.cuddly.controller;





import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.dto.OrdersDto;





@Controller
@RequestMapping("/cuddly/orders")
public class OrdersController {
	
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	OrdersDetailDao ordersDetailDao;
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	OrdersDao ordersDao;
	
	
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/orders/insert.jsp";
	}
	
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute OrdersDto ordersDto, HttpSession session) {
		int ordersNo = ordersDao.sequence();
		String memberId = (String) session.getAttribute("name");
		
		ordersDto.setOrdersNo(ordersNo);
		ordersDto.setMemberId(memberId);
		ordersDao.insert(ordersDto);
		return "redirect:주문관리페이지";
	}
	

	
	@GetMapping("/list")
	public String list() {
		return "/WEB-INF/views/orders/list.jsp";
	}
	
	
	@PostMapping("/list")
	public String list(@ModelAttribute OrdersDto ordersDto, HttpSession session) {
	    String memberId = (String) session.getAttribute("name");
	    ordersDto.setMemberId(memberId);
	    return "redirect:/cuddly";
	}

	
	
	
	@RequestMapping("/detail")
	public String ordersDetail(@RequestParam int ordersDetailNo, Model model) {
		OrdersDetailDto ordersDetailDto = ordersDetailDao.selectOne(ordersDetailNo);
		model.addAttribute("ordersDetailDto", ordersDetailDto);
		return "/WEB-INF/views/orders/detail.jsp";
	}
	
	
//	@PostMapping("/placeOrder")
//	public String placeOrder(@RequestParam String memberId, @RequestParam int addressNo,
//	                         @RequestParam int ordersPrice, @RequestParam String ordersPayment) {
//	    OrdersDto ordersDto = new OrdersDto();
//	    ordersDto.setMemberId(memberId);
//	    ordersDto.setAddressNo(addressNo);
//	    ordersDto.setOrdersPrice(ordersPrice);
//	    ordersDto.setOrdersPayment(ordersPayment);
//	    
//	    ordersDao.insert(ordersDto);
//
//	    return "redirect:/cuddly/orders/list";
//	}

	
	@RequestMapping("/cartlist")
	public String list(Model model) {
		List<CartDto> cartList = cartDao.selectCartList();
		model.addAttribute("cartList", cartList);
		return "/WEB-INF/views/orders/cartlist.jsp";
	}
	
	
}
