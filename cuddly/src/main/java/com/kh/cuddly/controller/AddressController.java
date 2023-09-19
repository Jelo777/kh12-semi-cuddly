package com.kh.cuddly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dto.AddressDto;

@Controller
@RequestMapping("/cuddly/address")
public class AddressController {
	
	@Autowired
	AddressDao addressDao;
	
	@GetMapping("/insert")
	public String insert() {
		
		return "/WEB-INF/views/address/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute AddressDto addressDto) {
		
		int addressNo = addressDao.sequence();
		addressDto.setAddressNo(addressNo);
		addressDao.insert(addressDto);
		return "redirect:insertFinish";
	}
	@RequestMapping("/insertFinish")
	public String insertFinish() {
		return "/WEB-INF/views/address/insertFinish.jsp";
	}
	
	
	
}
