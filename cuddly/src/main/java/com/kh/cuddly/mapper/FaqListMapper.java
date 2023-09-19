package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.FaqDto;

public class FaqListMapper implements RowMapper<FaqDto>{

	@Override
	public FaqDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		FaqDto faqDto = new FaqDto();
		
		faqDto.setFaqCategory(rs.getString("faq_category"));
		faqDto.setFaqDate(rs.getDate("faq_date"));
		faqDto.setFaqNo(rs.getInt("faq_no"));
		faqDto.setFaqTitle(rs.getString("faq_title"));
		faqDto.setFaqId(rs.getString("faq_id"));
		
		
		return faqDto;
	}

}
