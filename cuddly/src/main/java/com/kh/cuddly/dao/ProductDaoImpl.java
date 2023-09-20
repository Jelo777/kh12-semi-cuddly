package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select product_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProductDto productDto) {
		String sql = "insert into product("
						+ "product_no, product_name, product_price"
						+ ")"
					+ "values(?,?,?)";
		Object[] data = {
							productDto.getProductNo(), productDto.getProductName(),
							productDto.getProductPrice()
						};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public void connectMain(int productNo, int attachNo) {
		String sql = "insert into product_main_image values(?, ?)";
		Object[] data = {attachNo, productNo};
		jdbcTemplate.update(sql, data);	
	}

	@Override
	public void connectDetail(int productNo, int attachNo) {
		String sql = "insert into product_detail_image values(?, ?)";
		Object[] data = {attachNo, productNo};
		jdbcTemplate.update(sql, data);			
	}
}
