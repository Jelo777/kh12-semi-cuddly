package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaDto {
	
	private int qnaNo;
	private int productNo;
	private String memberId;
	private String qnaContent;
	private Date qnaDate;
	private String qnaAnswer;
	
	

}
