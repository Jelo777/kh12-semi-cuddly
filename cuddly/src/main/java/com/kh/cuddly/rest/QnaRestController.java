package com.kh.cuddly.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.QnaDto;

@RestController
@RequestMapping("/cuddly/rest")
public class QnaRestController {
	
	@Autowired
	QnaDao qnaDao;
	
	
	@PostMapping("/qna/change")
	public boolean update(@ModelAttribute QnaDto qnaDto, int qnaNo) {
		
		qnaDto.setQnaNo(qnaNo);
		
		boolean update = qnaDao.update(qnaDto);
		
		if(update) {
			return true;
		}
		else {
			return false;
		}
	}
	
}
