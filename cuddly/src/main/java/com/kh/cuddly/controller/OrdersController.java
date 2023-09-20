package com.kh.cuddly.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dto.OrdersDto;




@Controller
@RequestMapping("/cuddly/orders")
public class OrdersController {
	
	@Autowired
	OrdersDao ordersDao;
	
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
	
}
