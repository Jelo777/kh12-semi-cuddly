package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.mapper.ReviewMapper;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	ReviewMapper reviewMapper;

	@Override
	public void insert(ReviewDto reviewDto) {
		
		String sql = "insert into review"
				+ "(review_no,product_no,member_id,review_grade,review_content) "
				+ "values(review_seq.nextval,?,?,?,?)";
		
		Object[] data= {
				reviewDto.getProductNo(),reviewDto.getMemberId(),reviewDto.getReviewGrade(),
				reviewDto.getReviewContent()
				};
		
		jdbcTemplate.update(sql,data);
		
		
		
		
	}

}
