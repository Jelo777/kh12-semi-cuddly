package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.cuddly.dto.CreatorDto;

public class CreatorDaoImpl implements CreatorDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select creator_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(CreatorDto creatorDto) {
		String sql = "insert into creator(creator_no, product_no, creator_name)"
					+ "values(?, ?, ?)";
		Object[] data = {creatorDto};
	}
}
