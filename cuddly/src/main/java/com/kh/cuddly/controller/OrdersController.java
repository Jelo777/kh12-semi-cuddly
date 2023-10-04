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

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dao.AddressDao;
import com.kh.cuddly.dao.CartDao;
import com.kh.cuddly.dao.MemberDao;
import com.kh.cuddly.dao.OrdersDao;
import com.kh.cuddly.dao.OrdersDetailDao;
import com.kh.cuddly.dao.ProductDao;
import com.kh.cuddly.dao.ProductOptionDao;
import com.kh.cuddly.dao.QnaDao;
import com.kh.cuddly.dao.ReviewDao;
import com.kh.cuddly.dto.AddressDto;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MultiCartInsert;
import com.kh.cuddly.dto.MultiOrders;
import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrderDetailJoinDto2;
import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;
import com.kh.cuddly.dto.ProductOptionDto;





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
	
	@Autowired 
	QnaDao qnaDao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	ProductOptionDao productOptionDao;
	
	
	


	
	
	@GetMapping("/insert")
	public String insert(HttpSession session, Model model, @RequestParam int[] cartNo) {
	    String memberId = (String) session.getAttribute("name");
	    MemberDto memberDto = memberDao.selectOne(memberId);
	    model.addAttribute("memberDto", memberDto);

	    List<OrdersProductDto> dtoList = new ArrayList<>();
	    
	    int total = 0;

	    for (int No : cartNo) {
	        OrdersProductDto ordersProductDto = ordersDao.viewProduct(No);
//	        int price = ordersProductDto.getProductPrice();
//	        int count = ordersProductDto.getCartCount();
//	        
//	        int productTotal = price * count; 
	        
//	        total += productTotal; 
	        total += ordersProductDto.getCartPrice();
	        
	        dtoList.add(ordersProductDto); 
	    }

		AddressDto addressDto = addressDao.selectOne(memberId);
		List<AddressDto> list=addressDao.selectList(memberId);
		
//		boolean NoAddr = addressDto==null;
//		
//		
//		model.addAttribute("NoAddr", NoAddr);
		model.addAttribute("addressDto", addressDto);
		model.addAttribute("list",list);
		
	    
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
	        HttpSession session, @RequestParam int addrNo, @RequestParam String addrComent,
	        @ModelAttribute MultiOrders details,
	        @RequestParam int[] cartNo) {

	    int ordersNo = ordersDao.sequence();
	    String memberId = (String) session.getAttribute("name");
	    String memberLevel = (String) session.getAttribute("level");
	    
	    ordersDto.setOrdersNo(ordersNo);
	    ordersDto.setAddressNo(addrNo);
	    ordersDto.setMemberId(memberId);

	    addressDao.updateComenet(addrNo,addrComent);
	    
	    ordersDao.insert(ordersDto);

	    List<OrdersDetailDto> list = details.getDetails();
	    

	    for (OrdersDetailDto detail : list) {
	        int ordersDetailNo = ordersDetailDao.sequence();
	        detail.setOrdersDetailNo(ordersDetailNo);
	        detail.setOrdersNo(ordersNo);

			int price = cartDao.price(detail.getOptionNo());
			if(memberLevel.equals("골드")) {
				price = (int) (price*0.9);
			}
			else if(memberLevel.equals("실버")) {
				price = (int) (price*0.95);
			}
			                                                                      
			int count = detail.getOrdersDetailCount();
			int total = price * count;
			
			detail.setOrdersDetailPrice(total);
			
			//재고 처리
			ProductOptionDto productOptionDto = productOptionDao.selectOne(detail.getOptionNo());
			int originStock = productOptionDto.getProductOptionStock();
			int remainStock = originStock - count;
			productOptionDto.setProductOptionStock(remainStock);
			productOptionDao.update(productOptionDto);
			
			
		    //회원 누적금액 업데이트
			MemberDto memberDto = memberDao.selectOne(memberId);
		    int beforeMemberTotalPrice = memberDto.getMemberTotalprice();
		    int resultPrice = beforeMemberTotalPrice+total;
		    memberDto.setMemberTotalprice(resultPrice);
		    
		    if(!memberDto.getMemberLevel().equals("관리자")) {
		    	if(resultPrice>=50000) {
		    		memberDto.setMemberLevel("실버");
		    	}
		    	if(resultPrice>=100000) {
		    		memberDto.setMemberLevel("골드");
		    	}
		    }
		    
		    memberDao.updateMemberLevel(memberDto);
		    memberDao.updateMemberTotalPrice(memberDto);
	        
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
	        @RequestParam(name = "action", required = false) String action,int productNo) {
		String memberId = (String) session.getAttribute("name");
		String memberLevel = (String) session.getAttribute("level");

		if(memberId==null) {
			return "redirect:/cuddly/member/login";
		}
		
		else {
	    List<CartDto> list = cartList.getCartList();
	    StringBuilder cartNoParams = new StringBuilder();

	    for (CartDto insert : list) {
	        int cartNo = cartDao.sequence();
	        insert.setCartNo(cartNo);
	        insert.setMemberId(memberId);

	        int originPrice = cartDao.price(insert.getOptionNo());
	        int price;
	        if(memberLevel.equals("골드")) {
	        	price = (int) (originPrice * 0.9);
	        }
	        else if(memberLevel.equals("실버")) {
	        	price = (int) (originPrice * 0.95);
	        }
	        else {
	        	price = originPrice;
	        }
	        
	        int totalPrice = insert.getCartCount() * price;

	        insert.setCartPrice(totalPrice);

	        cartDao.insert(insert);

	        cartNoParams.append("cartNo=").append(cartNo).append("&");
	    }

	    if ("order".equals(action)) {
	        return "redirect:/cuddly/orders/insert?" + cartNoParams.toString();
	    } else if ("cart".equals(action)) {
	        return "redirect:/cuddly/orders/cartList?memberId="+memberId;
	    } else if("cancel".equals(action)) {
	    	
	    	return "redirect:/cuddly/product/detail?productNo=" + productNo;
	    }
	    
	    else {
	        return "redirect:/cuddly/orders/insert?" + cartNoParams.toString();
	    }
		}
	}
	
	
	@RequestMapping("/delete")
	public String cartDelete(int[] cartNo,HttpSession session){
		
		String memberId = (String) session.getAttribute("name");
		
		for(int deleteNo : cartNo) {
		
		
		cartDao.cartDelete(deleteNo);
		
		}
		
		 return "redirect:/cuddly/orders/cartList?memberId"+memberId;
	}
	
	
	@RequestMapping("/detail")
	public String list(HttpSession session,int ordersNo, Model model) {
	    
	    List<OrderDetailJoinDto> list  = ordersDetailDao.detailList(ordersNo);
	    
	    int total=0;
	    
	    for(OrderDetailJoinDto dto : list) {
			
			
			dto.setReviewEx(reviewDao.checkReviewExistence(dto.getMemberId(), dto.getProductNo()));
			total = dto.getOrdersPrice();
		}
	    
	    
	    model.addAttribute("ordersDetailDto", list);
	    model.addAttribute("total", total);
	    
    
	    return "/WEB-INF/views/orders/detail.jsp";
	}

	
	@RequestMapping("/cartList")
	public String cartList(Model model,HttpSession session,@ModelAttribute(name = "vo") PaginationVO vo) {
		
		String memberId = (String) session.getAttribute("name");
		if(memberId==null) {
			return "redirect:/cuddly/member/login";
		}
		
		int count = cartDao.countList(vo,memberId);
		
		vo.setCount(count);
		vo.setSize(5);
		
		List<OrdersProductDto> cartList = cartDao.selectCartList(vo,memberId);
		model.addAttribute("cartList", cartList);
		return "/WEB-INF/views/cart/list.jsp";
	}
	
	
	@RequestMapping("/list")
	public String orderList(Model model,@ModelAttribute(name = "vo") PaginationVO vo,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");

		int count = ordersDao.countList(vo,memberId);
		
		vo.setCount(count);
		vo.setSize(5);
		
		List<OrderDetailJoinDto2> list = ordersDao.selectListOrders2(vo,memberId);
		
		
		for(OrderDetailJoinDto2 dto : list) {
			dto.setReviewEx(reviewDao.checkReviewExistence(memberId, dto.getProductNo()));
		}
		
		
		
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
