package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ReviewDto;

@Component
public class ReviewMapper implements RowMapper<ReviewDto>{

	@Override
	public ReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewDto reviewDto = new ReviewDto();
		
		reviewDto.setMemberId(rs.getString("member_id"));
		reviewDto.setProductNo(rs.getInt("product_no"));
		reviewDto.setReviewContent(rs.getString("review_content"));
		reviewDto.setReviewDate(rs.getDate("review_date"));
		reviewDto.setReviewGrade(rs.getInt("review_grade"));
		reviewDto.setReviewNo(rs.getInt("review_no"));
		
		return reviewDto;
		
	}
	
	

}
