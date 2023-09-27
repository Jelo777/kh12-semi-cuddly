package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import com.kh.cuddly.dao.AttachDao;
import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.dto.ReviewInfoDto;



@Controller
@RequestMapping("/cuddly/review")
public class ReviewController {
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	AttachDao attachDao;
	
	
	@GetMapping("/write")
	public String write(int productNo,Model model) {
		
		ProductDto productDto = reviewDao.productInfo(productNo);
		
		
		
		model.addAttribute("productDto", productDto);
		model.addAttribute("productNo", productNo);
		
		return "/WEB-INF/views/review/insert.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto,
			HttpSession session,@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		
		String memberId = (String) session.getAttribute("name");
		
		int reviewNo = reviewDao.sequence();
		reviewDto.setMemberId(memberId);
		reviewDto.setReviewNo(reviewNo);
		reviewDao.insert(reviewDto);
		
		
		if(!attach.isEmpty()) {
			int attachNo = attachDao.sequence();
			
			//첨부파일 등록(파일이 있을 때만)
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			dir.mkdirs();
			File target = new File(dir,String.valueOf(attachNo));
			attach.transferTo(target);
			
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
			//연결(파일이 있을 때만)
			reviewDao.connect(reviewNo, attachNo);
		}
		
		
		return "redirect:/cuddly/review/memberList?memberId="+memberId;

	}
	
	@RequestMapping("/memberList")
	public String memberList(Model model,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		
		List<ReviewInfoDto> list = reviewDao.selectMemberList(memberId);
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/review/memberList.jsp";
		
	}
	
	@RequestMapping("/list")//아직 수정 전
	public String list(Model model,String memberId) {
		List<ReviewDto> list = reviewDao.memberList(memberId);
		
		model.addAttribute("list",list);
		
		return "/WEB-INF/views/review/list.jsp";
		
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int reviewNo,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		
		AttachDto attachDto = reviewDao.findImage(reviewNo);
		ReviewDto reviewDto= reviewDao.selectOne(reviewNo);
		
		//이미지 있는 경우 이미지 삭제 처리 추가
		if(reviewDto.isImage()) {
		String home=System.getProperty("user.home");
		File dir = new File(home,"upload");
		File target = new File(dir,String.valueOf(attachDto.getAttachNo()));
		target.delete();	//실제파일 삭제

		attachDao.delete(attachDto.getAttachNo());	//파일정보 삭제
		}
		reviewDao.delete(reviewNo);	//리뷰 + 이미지연결정보 삭제
		
		return "redirect:/cuddly/review/memberList?memberId="+memberId;
		
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int reviewNo, Model model) {
		
		ReviewDto reviewDto = reviewDao.selectOne(reviewNo);
		
		model.addAttribute("reviewDto", reviewDto);
		
		return "/WEB-INF/views/review/edit.jsp";
		
		
	}
	
	
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReviewDto reviewDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		//포켓몬스터 정보 변경
		reviewDao.update(reviewDto);
		
		if(!attach.isEmpty()) {//파일이 있으면
			//파일 삭제 - 기존 파일이 있을 경우에만 처리
			AttachDto attachDto = reviewDao.findImage(reviewDto.getReviewNo());
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			
			if(attachDto != null) {
			
				attachDao.delete(attachDto.getAttachNo());
			File target = new File(dir,String.valueOf(attachDto.getAttachNo()));
			target.delete();
			}
			
			//파일 추가 및 연결
			int attachNo = attachDao.sequence();
			
			
			File insertTarget = new File(dir,String.valueOf(attachNo));
			attach.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(attach.getOriginalFilename());
			insertDto.setAttachSize(attach.getSize());
			insertDto.setAttachType(attach.getContentType());
			attachDao.insert(insertDto);
			
			reviewDao.connect(reviewDto.getReviewNo(), attachNo);
		}
		
		
		return "redirect:/cuddly/review/memberList?="+reviewDto.getMemberId();
		
		
	}
	
	
	

}
