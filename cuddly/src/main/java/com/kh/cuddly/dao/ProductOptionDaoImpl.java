package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductOptionDto;
import com.kh.cuddly.mapper.ProductOptionMapper;

@Repository
public class ProductOptionDaoImpl implements ProductOptionDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	ProductOptionMapper productOptionMapper;
	
	@Override
	public int sequence() {
		String sql = "select product_option_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProductOptionDto productOptionDto) {
		String sql = "insert into product_option("
					+ "product_option_no, product_no, product_option_name, product_option_stock"
					+ ") "
					+ "values(?, ?, ?, ?)";
		Object[] data = {
									productOptionDto.getProductOptionNo(), productOptionDto.getProductNo(), 
									productOptionDto.getProductOptionName(), productOptionDto.getProductOptionStock()
									};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public List<ProductOptionDto> selectListByProductNo(int productNo) {//상품과 연결된 옵션 검색
		String sql = "select * from product_option where product_no = ?";
		Object[] data = {productNo};
		return jdbcTemplate.query(sql, productOptionMapper, data);
	}

	@Override
	public int update(ProductOptionDto productOptionDto) {//옵션수정
		String sql = "update product_option set "
								+ "product_option_stock = ? "
							+ "where product_option_no = ?";
		Object[] data = {productOptionDto.getProductOptionStock(), productOptionDto.getProductOptionNo()};
		
		return jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean findOptionName(ProductOptionDto productOptionDto) {//옵션추가에 중복확인
		String sql = "select * from product_option where product_option_name = ? and product_no = ?";
		Object[] data = {productOptionDto.getProductOptionName(), productOptionDto.getProductNo()};
		
		List<ProductOptionDto> list = jdbcTemplate.query(sql, productOptionMapper, data);
		if(list == null || list.size() == 0) {
			return false;
		}else {
			return true;
		}
		
	}
	
}
