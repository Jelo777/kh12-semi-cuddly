package com.kh.cuddly.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.VO.FaqlistVO;
import com.kh.cuddly.dao.FaqDao;
import com.kh.cuddly.dto.FaqDto;
import com.kh.cuddly.error.NoResultException;



@Controller
@RequestMapping("/cuddly/faq")
public class FaqController {
	
	@Autowired
	private FaqDao faqDao;
	

	// 작성
	@GetMapping("/write")
	private String write() {
		return "/WEB-INF/views/faq/write.jsp";
	}
	
	@PostMapping("/write")
	private String write(@ModelAttribute FaqDto faqDto) {
		int faqNo = faqDao.sequence();
		faqDto.setFaqNo(faqNo);
		
		
		faqDao.insert(faqDto);
		return "redirect:detail?faqNo="+faqNo;
	}
	

	

	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") FaqlistVO vo,
	                    Model model) {
    
		int count = faqDao.countList(vo);
		vo.setCount(count);	    
	    List<FaqDto> list = faqDao.selectListByPage(vo);
	//    List<FaqDto> countlist = faqDao.countList(FaqListVO vo);
	    model.addAttribute("list", list);
	    
	    return "/WEB-INF/views/faq/list.jsp";
	}


	
	
	// 상세 
	@RequestMapping("/detail")
	public String detail(@RequestParam int faqNo, Model model) {
		FaqDto faqDto = faqDao.selectOne(faqNo);
		model.addAttribute("faqDto", faqDto);
		return "/WEB-INF/views/faq/detail.jsp";
	}
	
	
	
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int faqNo) {
		boolean result = faqDao.delete(faqNo);
		if(result) {
			return "redirect:list";
		}
		else {
			return "redirect:에러";
		}
	}
	
	
	
	@GetMapping("/edit")
	public String edit(@RequestParam int faqNo, Model model) {
		FaqDto faqDto = faqDao.selectOne(faqNo);
		model.addAttribute("faqDto", faqDto);
		return "/WEB-INF/views/faq/edit.jsp";
	}
	
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute FaqDto faqDto) {
		boolean result = faqDao.update(faqDto);
		if(result) {
			return "redirect:detail?faqNo=" + faqDto.getFaqNo();
		}
		else {
			throw new NoResultException("존재하지 않는 글");
		}
	}
}