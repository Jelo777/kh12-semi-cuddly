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
	
}
