package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.dto.ReviewInfoDto;
import com.kh.cuddly.mapper.AttachMapper;
import com.kh.cuddly.mapper.ProductMapper;
import com.kh.cuddly.mapper.ReviewInfoMapper;
import com.kh.cuddly.mapper.ReviewMapper;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	ReviewMapper reviewMapper;
	
	@Autowired
	ReviewInfoMapper reviewInfoMapper;
	
	@Autowired
	AttachMapper attachMapper;
	
	@Autowired
	ProductMapper productMapper;	

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
	public List<ReviewInfoDto> selectMemberList(String memberId) {
		
//		String sql = "select r.*,rm.attach_no from "
//				+ "review r left outer join "
//				+ "review_image rm on r.review_no = rm.review_no"
//				+ " order by r.review_no asc";
		
		String sql = "select * from review_info where member_id= ? order by review_date desc";
		
		Object[] data= {memberId};
		
		return jdbcTemplate.query(sql, reviewInfoMapper,data);
	}
	
	@Override
	public List<ReviewDto> memberList(String memberId) {
		
		String sql = "select r.*,rm.attach_no from "
				+ "review r left outer join "
				+ "review_image rm on r.review_no = rm.review_no"
				+ " where member_id=? order by r.review_no asc";
		
		Object[] data = {memberId};
		
		return jdbcTemplate.query(sql, reviewMapper,data);
	}
	
	@Override
	public float reviewAvg(int productNo) {
		String sql = "select avg(review_grade) from review where product_no = ?";
		Object[] data = {productNo};
		boolean isNull = jdbcTemplate.queryForObject(sql, float.class, data)==null;
		if(isNull) {
			return 0;
		}
		else {
			return jdbcTemplate.queryForObject(sql, float.class, data);
		}
	}
	
	@Override
	public ProductDto productInfo(int productNo) {
		
		String sql = "select * from product where product_no=?";
		
		Object[] data = {productNo};
		
		List<ProductDto> list = jdbcTemplate.query(sql, productMapper, data);
		
		return list.isEmpty() ? null: list.get(0);
	
	}
	
	@Override
	public boolean delete(int reviewNo) {
		
		String sql = "delete review where review_no=?";
		
		Object[] data = {reviewNo};
		
		return jdbcTemplate.update(sql,data)>0;
		
	}
	
	@Override
	public ReviewDto selectOne(int reviewNo) { 
		
		String sql = "select r.*,rm.attach_no from "
				+ "review r left outer join "
				+ "review_image rm on r.review_no = rm.review_no where r.review_no=?";
		
		Object[] data = {reviewNo};
		
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper,  data);
		
		return list.isEmpty()? null : list.get(0);
	}
	
	@Override
	public boolean update(ReviewDto reviewDto) { 
		
		String sql = "update set review_content=? where review_no";
		
		Object[] data = {reviewDto.getReviewContent(),reviewDto.getReviewNo()};
		
		
		return jdbcTemplate.update(sql,data)>0;
	}
	
}
