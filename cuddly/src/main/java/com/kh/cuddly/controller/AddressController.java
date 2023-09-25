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
		
		//여기서addressDto는 내가 배송지 추가 페이지에서 입력한 값 + 시퀀스로 받아온 배송지번호,세션으로 가져온 멤버 아이디
		
		if(addressDto.getAddressDefault().equals("Y")) {//이 계정의 기본배송지가
			addressDao.changeDefault(memberId);
		}
		
		addressDao.insert(addressDto);
		return "redirect:/cuddly/address/list"; //일단 리스트가 없어서 메인으로
	}

	@RequestMapping("/list")
	public String list(Model model, HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		
		List<AddressDto> list=addressDao.selectList(memberId);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/address/list.jsp";
	}
	@GetMapping("/update")
	public String update(@RequestParam int addressNo, Model model) {
		AddressDto addressDto = addressDao.selectOneByNo(addressNo);
		model.addAttribute("addressDto", addressDto);
		return "/WEB-INF/views/address/update.jsp";
	}
	@PostMapping("/update")
	public String edit(AddressDto addressDto,HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		addressDto.setMemberId(memberId);//필요한가? 모르면 넣어
		if(addressDto.getAddressDefault().equals("Y")) {//이 계정의 기본배송지가
			addressDao.changeDefault(memberId);
		}
		addressDao.update(addressDto);
		return "redirect:list";
	}
	
	
}
