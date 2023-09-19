package com.kh.cuddly.dto;

import lombok.Data;

@Data
public class ProductOptionDto {
	private int productOptionNo;
	private int productNo;
	private String productOptionName;
	private int productOptionStock;
}
