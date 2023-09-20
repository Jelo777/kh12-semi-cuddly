package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.mapper.AttachMapper;
import com.kh.cuddly.mapper.ReviewMapper;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	ReviewMapper reviewMapper;
	
	@Autowired
	AttachMapper attachMapper;

	@Override
	public void insert(ReviewDto reviewDto) {
		
		String sql = "insert into review"
				+ "(review_no,product_no,member_id,review_grade,review_content) "
				+ "values(?,?,?,?,?)";
		
		Object[] data= {
				reviewDto.getReviewNo(),reviewDto.getProductNo(),reviewDto.getMemberId(),reviewDto.getReviewGrade(),
				reviewDto.getReviewContent()
				};
		
		jdbcTemplate.update(sql,data);

	}

	@Override
	public int sequence() {
		
			String sql = "select review_seq.nextval from dual";
		
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void connect(int reviewNo, int attachNo) {
		
		String sql = "insert into review_image(review_no,attach_no) values(?, ?)";
		
		Object[] data = {reviewNo, attachNo};
		
		jdbcTemplate.update(sql,data);
		
		
	}
	
	@Override
	public AttachDto findImage(int reviewNo) {
		
		String sql = "select * from attach "
				+ "where attach_no = ("
				+ "select attach_no from review_image "
				+ "where review_no=?)";
		Object[] data = {reviewNo};
		
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public List<ReviewDto> selectList() {
		
		String sql = "select r.*,rm.attach_no from "
				+ "review r left outer join "
				+ "review_image rm on r.review_no = rm.review_no"
				+ " order by r.review_no asc";
		
		return jdbcTemplate.query(sql, reviewMapper);
		
		
	}
	
	
	
	
	
	
	

}
