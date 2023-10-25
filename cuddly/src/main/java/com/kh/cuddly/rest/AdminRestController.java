package com.kh.cuddly.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.ProductOptionDto;
import com.kh.cuddly.dto.QnaDto;

@RestController
@RequestMapping("/rest/admin")
public class AdminRestController {

	@Autowired
	private QnaDao qnaDao;
	@Autowired
	private ProductOptionDao productOptionDao;
	
	
	@PostMapping("/qna/answer/update")
	public boolean update(@ModelAttribute QnaDto qnaDto, HttpSession session) {
		boolean update = qnaDao.updateByAnswer(qnaDto);
		if(update) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@PostMapping("/product/option/insert")//옵션추가
	public String edit(@ModelAttribute ProductOptionDto productOptionDto,
									@RequestParam int productNo) {
		if(productOptionDto.getProductOptionName().equals("")){//옵션명 입력창이 비었으면
			return "null";
		}
		boolean findName = productOptionDao.findOptionName(productOptionDto);//옵션입력창에 값이 이미 있으면
		if(findName) {
 			return "fail";
		}
		int productOptionNo = productOptionDao.sequence();

		productOptionDto.setProductOptionNo(productOptionNo);
		productOptionDto.setProductNo(productNo);
		productOptionDao.insert(productOptionDto);
		
		return "success";
	}
	
}
