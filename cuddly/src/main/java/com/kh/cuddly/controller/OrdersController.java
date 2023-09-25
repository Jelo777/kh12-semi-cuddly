package com.kh.cuddly.controller;



import java.util.ArrayList;
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

import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dto.AddressDto;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MultiCartInsert;
import com.kh.cuddly.dto.MultiOrders;
import com.kh.cuddly.dto.OrderDetailJoinDto;
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
	public String insert(HttpSession session, Model model, @RequestParam int[] cartNo) {
	    String memberId = (String) session.getAttribute("name");
	    MemberDto memberDto = memberDao.selectOne(memberId);
	    model.addAttribute("memberDto", memberDto);

	    List<OrdersProductDto> dtoList = new ArrayList<>();
	    
	    int total = 0;

	    for (int No : cartNo) {
	        OrdersProductDto ordersProductDto = ordersDao.viewProduct(No);
	        
	        int price = ordersProductDto.getProductPrice();
	        int count = ordersProductDto.getCartCount();
	        
	        int productTotal = price * count; 
	        total += productTotal; 
	        
	        dtoList.add(ordersProductDto); 
	    }

		AddressDto addressDto = addressDao.selectOne(memberId);
		model.addAttribute("addressDto", addressDto);
	    
	    model.addAttribute("ordersProductDto", dtoList);
	    model.addAttribute("total", total);
	    
	    
	   
	    return "/WEB-INF/views/orders/insert.jsp";
	}

	
	
//	@PostMapping("/insert")
//	public String insert(@ModelAttribute OrdersDto ordersDto,
//			HttpSession session,
//			@ModelAttribute MultiOrders details) {
//		
//		int ordersNo = ordersDao.sequence();
//		String memberId = (String) session.getAttribute("name");
//		ordersDto.setOrdersNo(ordersNo);
//		ordersDto.setMemberId(memberId);
//		
//		ordersDao.insert(ordersDto);
//		
//		
//		
//		List<OrdersDetailDto> list = details.getDetails();
//
//		ordersDetailDao.insert(list.get(0));
//		
////		for(OrdersDetailDto detail : ordersDetailDtoList) {
////			
////			
////		int ordersDetailNo = ordersDetailDao.sequence();
////		detail.setOrdersDetailNo(ordersDetailNo);
////		detail.setOrdersNo(ordersNo);
////		
////		int price = cartDao.price(detail.getOptionNo());
////		int count = detail.getOrdersDetailCount();
////		
////		int total = price * count;
////		
////		detail.setOrdersDetailPrice(total);
////		
////		ordersDetailDao.insert(detail);
////		
////		}
//		
//		
//		return "redirect:/cuddly/orders/detail?ordersNo="+ordersNo;
//	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute OrdersDto ordersDto,
	        HttpSession session,
	        @ModelAttribute MultiOrders details,
	        @RequestParam int[] cartNo) {

	    int ordersNo = ordersDao.sequence();
	    String memberId = (String) session.getAttribute("name");
	    ordersDto.setOrdersNo(ordersNo);
	    ordersDto.setMemberId(memberId);

	    ordersDao.insert(ordersDto);

	    List<OrdersDetailDto> list = details.getDetails();

	    for (OrdersDetailDto detail : list) {
	        int ordersDetailNo = ordersDetailDao.sequence();
	        detail.setOrdersDetailNo(ordersDetailNo);
	        detail.setOrdersNo(ordersNo);
	        
		int price = cartDao.price(detail.getOptionNo());
		int count = detail.getOrdersDetailCount();
		
		int total = price * count;
		
		detail.setOrdersDetailPrice(total);
	        
	        
	        ordersDetailDao.insert(detail);	    
	    }
	    
	    for(int deleteNo : cartNo) {
	    	
	    	cartDao.cartDelete(deleteNo);
	    	
	    }
	    
	    
	    

	    return "redirect:/cuddly/orders/detail?ordersNo=" + ordersNo;
	}
	
	@RequestMapping("/cartInsert")
	public String cartInsert(HttpSession session,
	        @ModelAttribute MultiCartInsert cartList,
	        @RequestParam(name = "action", required = false) String action) {

	    List<CartDto> list = cartList.getCartList();
	    String memberId = (String) session.getAttribute("name");
	    StringBuilder cartNoParams = new StringBuilder();

	    for (CartDto insert : list) {
	        int cartNo = cartDao.sequence();
	        insert.setCartNo(cartNo);
	        insert.setMemberId(memberId);

	        int price = cartDao.price(insert.getOptionNo());

	        int totalPrice = insert.getCartCount() * price;

	        insert.setCartPrice(totalPrice);

	        cartDao.insert(insert);

	        cartNoParams.append("cartNo=").append(cartNo).append("&");
	    }

	    if ("order".equals(action)) {
	        return "redirect:/cuddly/orders/insert?" + cartNoParams.toString();
	    } else if ("cart".equals(action)) {
	        return "redirect:/cuddly/orders/cartList?memberId="+memberId;
	    } else {
	        return "redirect:/cuddly/orders/insert?" + cartNoParams.toString();
	    }
	}


	

	
	
	@RequestMapping("/detail")
	public String list(HttpSession session,int ordersNo, Model model) {
	    
	    List<OrderDetailJoinDto> list  = ordersDetailDao.detailList(ordersNo);
	    
	    model.addAttribute("ordersDetailDto", list);
	    
    
	    return "/WEB-INF/views/orders/detail.jsp";
	}

	
	@RequestMapping("/cartList")
	public String cartList(Model model,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		
		List<OrdersProductDto> cartList = cartDao.selectCartList(memberId);
		model.addAttribute("cartList", cartList);
		return "/WEB-INF/views/cart/list.jsp";
	}
	
	
	@RequestMapping("/list")
	public String orderList(Model model,String memberId) {
		
		List<OrderDetailJoinDto> list = ordersDao.selectListOrders(memberId);
			
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/orders/list.jsp";
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
