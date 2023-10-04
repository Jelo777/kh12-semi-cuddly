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

import com.kh.cuddly.VO.FaqlistVO;
import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.AdminProductListDao;
import com.kh.cuddly.dao.AttachDao;
import com.kh.cuddly.dao.CreatorDao;
import com.kh.cuddly.dao.CreatorProductDao;
import com.kh.cuddly.dao.FaqDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersAdminDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.AdminProductListDto;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.dto.CreatorProductDto;
import com.kh.cuddly.dto.FaqDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MemberListDto;
import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrdersAdminDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ProductOptionDto;
import com.kh.cuddly.dto.QnaDto;
import com.kh.cuddly.error.NoTargetException;

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
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private FaqDao faqDao;

  @Autowired
	private OrdersDetailDao OrdersDetailDao;
	
	@Autowired
	private OrdersAdminDao ordersAdminDao;
	
	@Autowired
	private AdminProductListDao adminProductListDao;
	
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

		return "redirect:/cuddly/admin/product/list";
	}


	@GetMapping("/product/option")
	public String edit(@RequestParam int productNo, Model model) {
		ProductDto productDto = productDao.selectOne(productNo);
		model.addAttribute("productDto", productDto);
		
		CreatorDto creatorDto = creatorDao.selectOneByProductNo(productNo);//상품과 연결된 크리에이터 검색
		model.addAttribute("creatorDto", creatorDto);
		
		List<ProductOptionDto> list = productOptionDao.selectListByProductNo(productNo);//상품과 연결된 옵션 검색
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/product/option.jsp";
	}
	
	@PostMapping("/product/optionUpdate")//옵션수정
	public String editUpdate(@ModelAttribute ProductOptionDto productOptionDto,
			@RequestParam int productNo) {
		
		productOptionDao.update(productOptionDto);
		
		return "redirect:option?productNo="+productNo;
	}
	
	
	

	@RequestMapping("/product/list")//관리자페이지 상품목록
	public String list(@ModelAttribute(name = "vo") PaginationVO vo, Model model) {
		
		int count = adminProductListDao.countList(vo);
		vo.setCount(count);
		vo.setSize(8);
		
		List<AdminProductListDto> list = adminProductListDao.selectList(vo);
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
//		List<OrderDetailJoinDto> ordersList =  ordersDao.selectListOrders(memberId);
//		model.addAttribute("ordersList", ordersList);	
		List<OrdersAdminDto> ordersList = ordersAdminDao.selectList(memberId);
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
	
	
	@RequestMapping("/member/ordersDetailList")//회원이 구매한 내역의 상세구매내역
	public String ordersDetailList(@RequestParam int ordersNo, Model model) {
		
		List<OrderDetailJoinDto> ordersDetailList = OrdersDetailDao.detailList(ordersNo);
		model.addAttribute("ordersDetailList", ordersDetailList);
		
		return "/WEB-INF/views/admin/member/ordersDetailList.jsp";
	}
	

	@GetMapping("/creator/edit")
	public String creatorEdit(@RequestParam int creatorNo, Model model) {
		
		CreatorDto creatorDto = creatorDao.selectOne(creatorNo);
		model.addAttribute("creatorDto", creatorDto);
		
		return "/WEB-INF/views/admin/creator/edit.jsp";
	}
		
	@PostMapping("/creator/edit")
	public String creatorEdit(@RequestParam int creatorNo,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
		if(!attach.isEmpty()) {//등록파일이 있을때만
			creatorDao.deleteConnect(creatorNo);
			int attachNo = attachDao.sequence();
		
			String home = System.getProperty("user.home");
			File dir = new File(home, "upload");
			dir.mkdirs();
		
			File target = new File(dir, String.valueOf(attachNo));
			attach.transferTo(target);
		
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
		
			creatorDao.connect(attachNo, creatorNo);//크리에이터_이미지
		}
		return "redirect:/cuddly/product/creator";
	}
	
	
	@RequestMapping("/qna/list")
	public String qnaList(Model model) {
		List<QnaDto> list = qnaDao.selectList();
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/qna/list.jsp";
	}
	
}

