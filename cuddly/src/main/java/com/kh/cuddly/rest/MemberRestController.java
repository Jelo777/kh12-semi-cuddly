package com.kh.cuddly.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dto.MemberDto;

@CrossOrigin
@RestController
@RequestMapping("/cuddly/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto=memberDao.selectOne(memberId);
		if(memberDto ==null) {//아이디가 없으면
			return "Y";
		}
		else {//있으면
			return "N";
		}
	}

}
