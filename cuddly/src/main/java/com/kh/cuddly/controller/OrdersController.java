package com.kh.cuddly.controller;



import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.AddressDto;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;





@Controller
@RequestMapping("/cuddly/orders")
public class OrdersController {
	
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	OrdersDetailDao ordersDetailDao;
	
	@Autowired
	CartDao cartDao;
	
	@Autowired
	OrdersDao ordersDao;
	
	@Autowired
	MemberDao memberdao;
	
  @Autowired
	MemberDao memberDao;
	
	@Autowired
	AddressDao addressDao;
	
	@Autowired QnaDao qnaDao;
	
	
	


	
	
	@GetMapping("/insert")
	public String insert(HttpSession session, Model model, @RequestParam int[] ordersNo) {
	    String memberId = (String) session.getAttribute("name");
	    MemberDto memberDto = memberDao.selectOne(memberId);
	    model.addAttribute("memberDto", memberDto);

	    List<OrdersProductDto> dtoList = new ArrayList<>();
	    
	    int total = 0;

	    for (int orderNo : ordersNo) {
	        OrdersProductDto ordersProductDto = ordersDao.viewProduct(orderNo);
	        
	        int price = ordersProductDto.getProductPrice();
	        int count = ordersProductDto.getProductOptionStock();
	        
	        int productTotal = price * count; // 상품별 가격
	        total += productTotal; // 총 가격 누적
	        
	        dtoList.add(ordersProductDto); 
	    }

		AddressDto addressDto = addressDao.selectOne(memberId);
		model.addAttribute("addressDto", addressDto);
	    
	    model.addAttribute("ordersProductDto", dtoList);
	    model.addAttribute("total", total);
	    
	    
	   
	    return "/WEB-INF/views/orders/insert.jsp";
	}

	
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute OrdersDto ordersDto,
			HttpSession session) {
		int ordersNo = ordersDao.sequence();
		int ordersDetailNo = ordersDetailDao.sequence();
		
		OrdersDetailDto ordersDetailDto;
		
		String memberId = (String) session.getAttribute("name");
		ordersDto.setOrdersNo(ordersNo);
		ordersDto.setMemberId(memberId);
		ordersDao.insert(ordersDto);
		
		
		return "redirect:/cuddly";
	}
	
	
	
	@GetMapping("/list")
	public String list() {
		return "/WEB-INF/views/orders/list.jsp";
	}
	
	
	@PostMapping("/list")
	public String list(@ModelAttribute OrdersDto ordersDto, HttpSession session) {
	    String memberId = (String) session.getAttribute("name");
	    ordersDto.setMemberId(memberId);
	    return "redirect:/cuddly";
	}

	
	@RequestMapping("/cartlist")
	public String list(Model model) {
		List<CartDto> cartList = cartDao.selectCartList();
		model.addAttribute("cartList", cartList);
		return "/WEB-INF/views/orders/cartlist.jsp";
	}
	
	
	@GetMapping("/addrInsert")
	public String insert() {
		
		return "/WEB-INF/views/orders/addrInsert.jsp";
	}
	@PostMapping("/addrInsert")
	public String insert(@ModelAttribute AddressDto addressDto, 
			HttpSession session) {
		String memberId=(String)session.getAttribute("name");
		int addressNo = addressDao.sequence();
		addressDto.setAddressNo(addressNo);
		addressDto.setMemberId(memberId);
		
		//여기서addressDto는 내가 배송지 추가 페이지에서 입력한 값 + 시퀀스로 받아온 배송지번호,세션으로 가져온 멤버 아이디
		
		if(addressDto.getAddressDefault().equals("Y")) {//이 계정의 기본배송지가
			addressDao.changeDefault(memberId);
		}
		
		addressDao.insert(addressDto);
		
		
		return "redirect:/cuddly"; 
		
		
	}
	
	
}
