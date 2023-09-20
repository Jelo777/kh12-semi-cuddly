package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.mapper.CreatorMapper;

@Repository
public class CreatorDaoImpl implements CreatorDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	CreatorMapper creatorMapper;
	
	@Override
	public int sequence() {
		String sql = "select creator_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(CreatorDto creatorDto) {
		String sql = "insert into creator(creator_no, product_no, creator_name)"
					+ "values(?, ?, ?)";
		Object[] data = {creatorDto.getCreatorNo(), creatorDto.getProductNo(), creatorDto.getCreatorName()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean isNewCreator(String creatorName) {
		String sql = "select * from creator where instr(creator_name, ?) > 0";
		Object[] data = {creatorName};
		List<CreatorDto> list = jdbcTemplate.query(sql, creatorMapper, data); 
		return list.isEmpty() ? true : false;
	}
}
