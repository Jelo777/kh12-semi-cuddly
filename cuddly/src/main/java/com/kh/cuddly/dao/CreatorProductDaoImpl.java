package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CreatorProductDto;
import com.kh.cuddly.mapper.CreatorProductMapper;

@Repository
public class CreatorProductDaoImpl implements CreatorProductDao{

	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	CreatorProductMapper creatorProductMapper;
	
	@Override
	public void insert(CreatorProductDto creatorProductDto) {
		String sql = "insert into creator_product(creator_no, product_no)"
					+ " values(?, ?)";
		Object[] data = {creatorProductDto.getCreatorNo(), creatorProductDto.getProductNo()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public CreatorProductDto selectOne(int productNo) {
		String sql = "select * from creator_product where product_no = ?";
		Object[] data = {productNo};
		List<CreatorProductDto> list = jdbcTemplate.query(sql, creatorProductMapper, data);
		return list.isEmpty()? null : list.get(0);
	}
}
