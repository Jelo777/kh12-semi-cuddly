package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.QnaDto;

public class QnaMapper implements RowMapper<QnaDto>{

	@Override
	public QnaDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		QnaDto qnaDto = new QnaDto();
		
		qnaDto.setMemberId(rs.getString("member_id"));
		qnaDto.setProductNo(rs.getInt("product_no"));
		qnaDto.setQnaAnswer(rs.getString("qna_answer"));
		qnaDto.setQnaContent(rs.getString("qna_content"));
		qnaDto.setQnaDate(rs.getDate("qna_date"));
		qnaDto.setQnaNo(rs.getInt("qna_no"));
		
		
		
		
		return null;
	}

}
