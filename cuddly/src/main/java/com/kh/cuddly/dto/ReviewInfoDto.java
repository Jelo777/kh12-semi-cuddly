package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewInfoDto {
	
	private int reviewNo;
	private int productNo;
	private String memberId;
	private int reviewGrade;
	private String reviewContent;
	private Date reviewDate;
	private int attachNo;
	private String productName;
	private int productPrice;
	private String creatorName;
	private boolean image;//이미지유무 = DB 미포함
	

}
