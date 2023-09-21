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

import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dto.AddressDto;

@Controller
@RequestMapping("/cuddly/address")
public class AddressController {
	
	@Autowired
	AddressDao addressDao;
	
	@GetMapping("/insert")
	public String insert() {
		
		return "/WEB-INF/views/address/mypageInsert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute AddressDto addressDto, 
			HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		int addressNo = addressDao.sequence();
		addressDto.setAddressNo(addressNo);
		addressDto.setMemberId(memberId);
		
		if(addressDto.getAddressDefault().equals("Y")) {
			addressDao.changeDefault();
		}
		addressDao.insert(addressDto);
		return "redirect:/cuddly"; //일단 리스트가 없어서 메인으로
	}

	@RequestMapping("/list")
	public String list(Model model) {
		List<AddressDto> list=addressDao.selectList();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/address/list.jsp";
	}
	
	
}
