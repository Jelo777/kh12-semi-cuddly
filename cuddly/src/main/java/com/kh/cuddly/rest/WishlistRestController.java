package com.kh.cuddly.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.cuddly.VO.WishlistVO;
import com.kh.cuddly.dao.WishlistDao;
import com.kh.cuddly.dto.WishlistDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/wishlist")
public class WishlistRestController {

	@Autowired
	private WishlistDao wishlistDao;
	
	@RequestMapping("/check")
	public WishlistVO check(@ModelAttribute WishlistDto wishlistDto,
							HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		wishlistDto.setMemberId(memberId);
		boolean isCheck = wishlistDao.check(wishlistDto);
		int count = wishlistDao.count(wishlistDto.getProductNo());
		
		WishlistVO vo = new WishlistVO();
		vo.setCheck(isCheck);
		vo.setCount(count);
		
		return vo;
	}
	
	@RequestMapping("/action")
	public WishlistVO action(@ModelAttribute WishlistDto wishlistDto, 
							HttpSession session) {
		String memberId = (String)session.getAttribute("name");
		wishlistDto.setMemberId(memberId);
		
		boolean isCheck = wishlistDao.check(wishlistDto);
		
		if(isCheck) {//체크되어 있다면
			wishlistDao.delete(wishlistDto);//체크해제
		}
		else {//아니라면
			wishlistDao.insert(wishlistDto);//체크 설정
		}
		
		int count = wishlistDao.count(wishlistDto.getProductNo());
		
		WishlistVO vo = new WishlistVO();
		vo.setCheck(!isCheck);
		vo.setCount(count);
		return vo;
	}
	
}
