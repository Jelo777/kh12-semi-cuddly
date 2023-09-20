package com.kh.cuddly.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.cuddly.dao.WishlistDao;
import com.kh.cuddly.dto.WishlistDto;

@Controller
@RequestMapping("/cuddly/wishlist")
public class WishlistController {

    @Autowired
    private WishlistDao wishlistDao;

    @GetMapping("/insert")
    public String insert() {
        return "/WEB-INF/views/wishlist/insert.jsp";
    }

    @PostMapping("/insert")
    public String insert(WishlistDto wishlistDto) {
        wishlistDao.insert(wishlistDto);
        return "redirect:/cuddly/wishlist/list";
    }

    @GetMapping("/list")
    public String list(Model model) {
        List<WishlistDto> wishlist = wishlistDao.selectList();
        model.addAttribute("wishlist", wishlist);
        return "/WEB-INF/views/wishlist/list.jsp";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam int wishlistNo, Model model) {
        WishlistDto wishlistDto = wishlistDao.selectOne(wishlistNo);
        model.addAttribute("wishlistDto", wishlistDto);
        return "/WEB-INF/views/wishlist/detail.jsp";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam int wishlistNo) {
        wishlistDao.delete(wishlistNo);
        return "redirect:/cuddly/wishlist/list";
    }
}

