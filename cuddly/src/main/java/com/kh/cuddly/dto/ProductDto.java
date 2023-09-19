package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductDto {
	private int productNo;
	private String productName;
	private int productPrice;
	private Date productDate;
}
