package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductListDto {
	private int productNo;
	private String productName;
	private int productPrice;
	private Date productDate;
	private String productItem;
	private String creatorName;
}
