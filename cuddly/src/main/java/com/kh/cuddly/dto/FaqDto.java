package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FaqDto {
	private int faqNo;
	private String memberId;
	private String faqTitle;
	private String faqContent;
	private Date faqDate;
	private String faqCategory;
	
}
