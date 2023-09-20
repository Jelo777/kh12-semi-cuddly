package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CategoryDto;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	@Override
	public int sequence() {
		String sql = "select category_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(CategoryDto categoryDto) {
		String sql = "insert into category("
						+ "category_no, category_name"
						+ ")"
					+ "values(?, ?)";
		Object[] data = {categoryDto.getCategoryNo(), categoryDto.getCategoryName()};
		jdbcTemplate.update(sql, data);
	}



}
