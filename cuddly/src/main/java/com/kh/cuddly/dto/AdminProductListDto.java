package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminProductListDto {
	private int optionCount;
	private int soldoutCount;
	private int  productNo;
	private String productName;
	private Date productDate;
	private String creatorName;

}
