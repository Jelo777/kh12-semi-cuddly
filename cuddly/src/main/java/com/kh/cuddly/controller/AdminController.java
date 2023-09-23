package com.kh.cuddly.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

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

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.AttachDao;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.CreatorProductDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.CreatorProductDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MemberListDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductOptionDto;
import com.kh.springhome.error.NoTargetException;

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
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private OrdersDao ordersDao;
	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	@GetMapping("/product/insert")
	public String insert() {
		return "/WEB-INF/views/admin/product/insert.jsp";
	}
	
	@PostMapping("/product/insert")//상품등록
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
		CreatorDto findCreatorDto = creatorDao.selectOne(creatorName);
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
		
		if(!attachMain.isEmpty()) {//등록파일이 있을때만
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
		
			productDao.connectMain(productNo, attachNo);//대표이미지 등록
		
		}
		
		if(!attachDetail.isEmpty()) {//등록파일이 있을때만
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
		
			productDao.connectDetail(productNo, attachNo);//상세이미지 등록
			}

		return "/WEB-INF/views/admin/product/insert.jsp";
	}
	

	@ResponseBody
	@RequestMapping("/product/main") // 상품 메인 이미지
	public ResponseEntity<ByteArrayResource> productMainImage(@RequestParam int productNo) throws IOException {

		AttachDto attachDto = productDao.findProductMainImage(productNo);
		if (attachDto == null) {
			return ResponseEntity.notFound().build();
		}

		String home = System.getProperty("user.home");
		File dir = new File(home, "upload");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize()).header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						.attachment().filename(attachDto.getAttachName(), StandardCharsets.UTF_8).build().toString())
				.body(resource);
	}
	

	@GetMapping("/product/edit")
	public String edit(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		model.addAttribute("productDto", productDto);
		
		CreatorDto creatorDto = creatorDao.selectOneByProductNo(productNo);//상품과 연결된 크리에이터 검색
		model.addAttribute("creatorDto", creatorDto);
		
		List<ProductOptionDto> list = productOptionDao.selectListByProductNo(productNo);//상품과 연결된 옵션 검색
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/product/edit.jsp";
	}
	

	@PostMapping("/product/editUpdate")//옵션수정
	public String editUpdate(@ModelAttribute ProductOptionDto productOptionDto,
			@RequestParam int productNo) {
		
		productOptionDao.update(productOptionDto);
		
		return "redirect:edit?productNo="+productNo;
	}
	
	@PostMapping("/product/edit")//옵션추가
	@ResponseBody
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
	
	
	@RequestMapping("/product/list")//관리자페이지 상품목록
	public String list(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		
		int count = productDao.countList(vo);
		vo.setCount(count);
		vo.setSize(8);
		
		List<ProductDto> list = productDao.selectList(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/product/list.jsp";		
	}
	
	@RequestMapping("/member/list")//회원목록조회
	public String memberList(@ModelAttribute PaginationVO vo, Model model) {
		
		vo.setSize(15);
		
		int count = memberDao.countList(vo);
		vo.setCount(count);
		model.addAttribute("vo", vo);
		
		List<MemberListDto> list = memberDao.selectByPage(vo);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@GetMapping("/member/edit")//회원등급수정
	public String memberDetail(@RequestParam String memberId, Model model) {
		
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		
		//이 회원이 구매한 내역 첨부
		List<OrdersDto> ordersList = ordersDao.selectOneByMemberOrders(memberId);
		model.addAttribute("ordersList", ordersList);
		
		return "/WEB-INF/views/admin/member/edit.jsp";
	}
	
	@PostMapping("/member/edit")//회원등급수정
	public String memberEdit(@ModelAttribute MemberDto memberDto) {
		
		boolean result = memberDao.updateMemberLevel(memberDto);
		if(result) {
			return "redirect:edit?memberId="+memberDto.getMemberId();
		}
		else {
			return "redirect:error";
		}
	}
	
	
}
