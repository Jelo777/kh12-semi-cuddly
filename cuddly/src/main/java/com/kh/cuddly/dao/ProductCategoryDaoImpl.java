package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductCategoryDto;

@Repository
public class ProductCategoryDaoImpl implements ProductCategoryDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(ProductCategoryDto productCategoryDto) {
		String sql = "insert into product_category(category_no, product_no)"
					+ "values(?, ?)";
		Object[] data = {productCategoryDto.getCategoryNo(), productCategoryDto.getProductNo()};
		jdbcTemplate.update(sql, data);
	}
}
