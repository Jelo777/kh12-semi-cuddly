package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewDto {
	
	private int reviewNo;
	private int productNo;
	private String memberId;
	private int reviewGrade;
	private String reviewContent;
	private Date reviewDate;
	private boolean image;//이미지유무 = DB 미포함
	
}
