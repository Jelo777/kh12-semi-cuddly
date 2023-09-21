package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CreatorProductDto;

@Repository
public class CreatorProductDaoImpl implements CreatorProductDao{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(CreatorProductDto creatorProductDto) {
		String sql = "insert into creator_product(creator_no, product_no)"
					+ " values(?, ?)";
		Object[] data = {creatorProductDto.getCreatorNo(), creatorProductDto.getProductNo()};
		jdbcTemplate.update(sql, data);
	}
}
