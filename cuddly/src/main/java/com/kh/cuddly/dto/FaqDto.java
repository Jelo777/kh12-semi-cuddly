package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FaqDto {
	private int faqNo;
	private String faqId;
	private String faqTitle;
	private String faqContent;
	private Date faqDate;
	private String faqCategory;
	
}
