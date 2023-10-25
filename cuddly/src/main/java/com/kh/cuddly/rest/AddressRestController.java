package com.kh.cuddly.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dto.AddressDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/address")
public class AddressRestController {

	@Autowired
	private AddressDao addressDao;
	
	@PostMapping("/insert")
	public void insert(@ModelAttribute AddressDto addressDto, 
			HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		int addressNo = addressDao.sequence();
		addressDto.setAddressNo(addressNo);
		addressDto.setMemberId(memberId);
		
		//여기서addressDto는 내가 배송지 추가 페이지에서 입력한 값 + 시퀀스로 받아온 배송지번호,세션으로 가져온 멤버 아이디
		
		if(addressDto.getAddressDefault().equals("Y")) {//addressDto의 default값이 Y면
			addressDao.changeDefault(memberId);
		}
		
		addressDao.insert(addressDto); 
	}
	@PostMapping("/list")
	public List<AddressDto> list(HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		
		List<AddressDto> list=addressDao.selectList(memberId);
		return list;
	}
	@PostMapping("/delete")
	public void delete(@RequestParam int addressNo) {
		addressDao.delete(addressNo);
	}
	
//	@PostMapping("/edit")
//	public void edit(@ModelAttribute AddressDto addressDto, 
//					HttpSession sesstion) {
//		String memberId=(String)sesstion.getAttribute("name");
//		if(addressDto.getAddressDefault().equals("Y")) {//addressDto의 default값이 Y면
//			addressDao.changeDefault(memberId);
//		}
//		addressDao.update(addressDto);
//
//	}
	
}
