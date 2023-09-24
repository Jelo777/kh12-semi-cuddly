package com.kh.cuddly.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.QnaDto;

@RestController
@RequestMapping("/cuddly/admin/rest")
public class AdminRestController {

	@Autowired
	private QnaDao qnaDao;
	
	@PostMapping("qna/answer/update")
	public boolean update(@ModelAttribute QnaDto qnaDto, HttpSession session) {
		boolean update = qnaDao.updateByAnswer(qnaDto);
		if(update) {
			return true;
		}
		else {
			return false;
		}
	}
}
