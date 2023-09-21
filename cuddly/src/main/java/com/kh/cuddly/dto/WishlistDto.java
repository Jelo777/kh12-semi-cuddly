package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class WishlistDto {
	private int wishlistNo; // 찜번호
	private int productNo;
	private String memberId;
	private Date wishlistDate; // 추가날짜
}
