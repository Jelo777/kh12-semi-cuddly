package com.kh.cuddly.rest;

import java.text.DecimalFormat;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.dao.CertDao;

@CrossOrigin
@RestController
@RequestMapping("/cuddly/rest/cert")
public class CertRestController {

	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
		
		//[1] 인증번호 생성
		Random r= new Random();
		int number =r.nextInt(1000000);
		DecimalFormat fm = new DecimalFormat("000000");
		String certNumber =fm.format(number);
		//[2] 이메일 발송
		SimpleMailMessage message =new SimpleMailMessage();
	}
	
	
}












