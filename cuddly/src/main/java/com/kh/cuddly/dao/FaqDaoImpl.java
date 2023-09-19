package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.FaqDto;

@Repository
public class FaqDaoImpl implements FaqDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	@Override
	public void insert(FaqDto faqDto) {
		
		String sql = "insert into faq"
				+ "(faq_no,faq_id,faq_title,faq_content,faq_category) "
				+ "values(?,?,?,?,?)";
		
		Object[] data = {faqDto.getFaqNo(),faqDto.getFaqId(),faqDto.getFaqTitle(),faqDto.getFaqContent(),faqDto.getFaqCategory()};
		
		jdbcTemplate.update(sql,data);
	}

	@Override
	public int sequence() {
		
		String sql = "select notice_seq.nextval from dual";
		
		return jdbcTemplate.queryForObject(sql, int.class);
		
		
	}
	
	
	
	

}
