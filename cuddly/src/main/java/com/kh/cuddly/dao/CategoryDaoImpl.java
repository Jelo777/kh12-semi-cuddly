package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(String categoryName) {
		String sql = "insert into category("
						+ "category_no, category_name"
						+ ")"
					+ "values(category_seq.nextval, ?)";
		Object[] data = {categoryName};
		jdbcTemplate.update(sql, data);
	}
}
