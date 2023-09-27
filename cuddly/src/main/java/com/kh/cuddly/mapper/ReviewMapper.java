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
		
		reviewDto.setReviewNo(rs.getInt("review_no"));
		reviewDto.setProductNo(rs.getInt("product_no"));
		reviewDto.setMemberId(rs.getString("member_id"));
		reviewDto.setReviewGrade(rs.getInt("review_grade"));
		reviewDto.setReviewContent(rs.getString("review_content"));
		reviewDto.setReviewDate(rs.getDate("review_date"));
		reviewDto.setImage(rs.getObject("attach_no")!=null);
		return reviewDto;
		
	}
	
	

}
