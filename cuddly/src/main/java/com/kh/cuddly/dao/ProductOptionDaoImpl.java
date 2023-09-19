package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductOptionDto;

@Repository
public class ProductOptionDaoImpl implements ProductOptionDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(ProductOptionDto productOptionDto) {
		String sql = "insert into product_option("
					+ "product_option_no, product_no, product_option_name, product_option_stock"
					+ ") "
					+ "values(product_option_seq.nextval, ?, ?, ?)";
		Object[] data = {productOptionDto.getProductNo(), productOptionDto.getProductOptionName(),
							productOptionDto.getProductOptionStock()};
		jdbcTemplate.update(sql, data);
	}
}