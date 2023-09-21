package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.cuddly.dao.AttachDao;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.CreatorProductDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.CreatorProductDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductOptionDto;

@Controller
@RequestMapping("/cuddly/admin")
public class AdminController {

	@Autowired
	private CreatorDao creatorDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private CreatorProductDao creatorProductDao;
	
	@Autowired
	private ProductOptionDao productOptionDao;
	
	
	@GetMapping("/product/insert")
	public String insert() {
		return "/WEB-INF/views/admin/product/insert.jsp";
	}
	
	@PostMapping("/product/insert")
	public String insert(
								@ModelAttribute ProductDto productDto, 
								@RequestParam String creatorName,
								@RequestParam MultipartFile attachMain,
								@RequestParam MultipartFile attachDetail
									) throws IllegalStateException, IOException {

		int productNo = productDao.sequence();
		productDto.setProductNo(productNo);
		productDao.insert(productDto);
		
		//입력한 크리에이터 이름으로 크리에이터 조회
		CreatorDto findCreatorDto = creatorDao.selectOneByName(creatorName);
		CreatorProductDto creatorProductDto = new CreatorProductDto();
		
		
		if(findCreatorDto==null) {//조회된 크리에이터가 null = 신규 크리에이터
			CreatorDto creatorDto = new CreatorDto();
			int creatorNo = creatorDao.sequence();		
			creatorDto.setCreatorNo(creatorNo);
			creatorDto.setCreatorName(creatorName);
			creatorDao.insert(creatorDto);//크리에이터 등록
			
			//크리에이터상품 등록
			creatorProductDto.setCreatorNo(creatorNo);
			creatorProductDto.setProductNo(productNo);
			creatorProductDao.insert(creatorProductDto);
		}
		else {//크리에이터가 이미 존재할때
			int creatorNo = findCreatorDto.getCreatorNo();//기존 크리에이터번호 꺼내기
			creatorProductDto.setCreatorNo(creatorNo);
			creatorProductDto.setProductNo(productNo);
			creatorProductDao.insert(creatorProductDto);
		}
		
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
	
	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> image(@RequestParam int productNo) throws IOException{
		
		AttachDto attachDto = productDao.findImage(productNo);
		if(attachDto == null) {
			return ResponseEntity.notFound().build();
		}
		
		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
							.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
							.build().toString()
						)
			.body(resource);
		
	}
	
	@GetMapping("/product/edit")
	public String edit(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		model.addAttribute("productDto", productDto);
		
		CreatorDto creatorDto = creatorDao.selectOne(productNo);
		model.addAttribute("creatorDto", creatorDto);
		
		return "/WEB-INF/views/admin/product/edit.jsp";
	}
	
	@PostMapping("/product/edit")
	public String edit(@ModelAttribute ProductOptionDto productOptionDto,
									@RequestParam int productNo
									) {
		
		int productOptionNo = productOptionDao.sequence();
		
		productOptionDto.setProductOptionNo(productOptionNo);
		productOptionDto.setProductNo(productNo);
//		productOptionDto.setProductOptionName(productOptionName);
//		productOptionDto.setProductOptionStock(productOptionStock);
		productOptionDao.insert(productOptionDto);
		
		return "redirect:edit?productNo="+productNo;
	}
	
	
	
}
