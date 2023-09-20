package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.cuddly.dao.AttachDao;
import com.kh.cuddly.dao.CategoryDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CategoryDto;
import com.kh.cuddly.dto.ProductDto;

@Controller
@RequestMapping("/cuddly/admin")
public class AdminController {

	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private AttachDao attachDao;
	
	
	@GetMapping("/product/insert")
	public String insert() {
		return "/WEB-INF/views/admin/product/insert.jsp";
	}
	
	@PostMapping("/product/insert")
	public String insert(
								@ModelAttribute ProductDto productDto, 
								@ModelAttribute CategoryDto categoryDto,
								@RequestParam MultipartFile attachMain,
								@RequestParam MultipartFile attachDetail
									) throws IllegalStateException, IOException {

		int categoryNo = categoryDao.sequence();		
		categoryDto.setCategoryNo(categoryNo);
		categoryDao.insert(categoryDto);
		
		int productNo = productDao.sequence();
		productDto.setProductNo(productNo);
		productDao.insert(productDto);
		
		
		if(!attachMain.isEmpty()) {			
		int attachNo = attachDao.sequence();
		
		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		dir.mkdirs();
		
		File target = new File(dir, String.valueOf(attachNo));
		attachMain.transferTo(target);
		
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attachMain.getOriginalFilename());
		attachDto.setAttachSize(attachMain.getSize());
		attachDto.setAttachType(attachMain.getContentType());
		attachDao.insert(attachDto);
		
		productDao.connectMain(productNo, attachNo);
		
		}
		
		if(!attachDetail.isEmpty()) {			
			int attachNo = attachDao.sequence();
			
			String home = System.getProperty("user.home");
			File dir = new File(home, "upload");
			dir.mkdirs();
			
			File target = new File(dir, String.valueOf(attachNo));
			attachDetail.transferTo(target);
			
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attachDetail.getOriginalFilename());
			attachDto.setAttachSize(attachDetail.getSize());
			attachDto.setAttachType(attachDetail.getContentType());
			attachDao.insert(attachDto);
		
			productDao.connectDetail(productNo, attachNo);
			
			}
		return "redirect:insert";
	}
}
