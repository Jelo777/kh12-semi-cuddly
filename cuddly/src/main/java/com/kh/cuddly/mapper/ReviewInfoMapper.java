package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ReviewInfoDto;

@Component
public class ReviewInfoMapper implements RowMapper<ReviewInfoDto>{

	@Override
	public ReviewInfoDto mapRow(ResultSet rs, int rowNum) throws SQLException {

		ReviewInfoDto reviewInfoDto = new ReviewInfoDto();
		
		reviewInfoDto.setAttachNo(rs.getInt("attach_no"));
		reviewInfoDto.setCreatorName(rs.getString("creator_name"));
		reviewInfoDto.setMemberId(rs.getString("member_id"));
		reviewInfoDto.setProductName(rs.getString("product_name"));
		reviewInfoDto.setProductNo(rs.getInt("product_no"));
		reviewInfoDto.setProductPrice(rs.getInt("product_price"));
		reviewInfoDto.setReviewContent(rs.getString("review_content"));
		reviewInfoDto.setReviewDate(rs.getDate("review_date"));
		reviewInfoDto.setReviewGrade(rs.getInt("review_grade"));
		reviewInfoDto.setReviewNo(rs.getInt("review_no"));
		reviewInfoDto.setImage(rs.getObject("attach_no")!=null);
		
		
		return reviewInfoDto;
	}

}
