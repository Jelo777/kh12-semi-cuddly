package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select product_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProductDto productDto) {
		String sql = "insert into product("
						+ "product_no, product_name, product_price, product_date"
						+ ")"
					+ "values(?,?,?,?)";
		Object[] data = {
							productDto.getProductNo(), productDto.getProductName(),
							productDto.getProductPrice(), productDto.getProductDate()
						};
		jdbcTemplate.update(sql, data);
	}
}
