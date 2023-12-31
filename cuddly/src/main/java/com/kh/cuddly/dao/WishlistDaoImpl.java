package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.ProductListDto;
import com.kh.cuddly.dto.WishlistDto;
import com.kh.cuddly.mapper.ProductListMapper;
import com.kh.cuddly.mapper.ProductMapper;
import com.kh.cuddly.mapper.WishlistMapper;

@Repository
public class WishlistDaoImpl implements WishlistDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private WishlistMapper wishlistMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private ProductListMapper productListMapper;

	@Override
	public void insert(WishlistDto wishlistDto) {
		String sql = "insert into wishlist (wishlist_no, product_no, member_id)"
						+ "values (wishlist_seq.nextval, ?, ?)";
		Object[] data = {wishlistDto.getProductNo(), wishlistDto.getMemberId()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(WishlistDto wishlistDto) {
		String sql = "delete wishlist where member_id = ? and product_no = ?"; 
		Object[] data = {wishlistDto.getMemberId(), wishlistDto.getProductNo()};
		return jdbcTemplate.update(sql, data)>0;
	}

	@Override
	public boolean check(WishlistDto wishlistDto) {
		String sql = "select * from wishlist "
					+ "where member_id = ? and product_no = ?";
		Object[] data = {wishlistDto.getMemberId(), wishlistDto.getProductNo()};
		List<WishlistDto> list = jdbcTemplate.query(sql, wishlistMapper, data);
		return list.isEmpty() ? false : true;
	}

	@Override
	public int count(int productNo) {
		String sql = "select count(*) from wishlist where product_no = ?";
		Object[] data = {productNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	@Override
	public List<ProductListDto> wishlistByMemberId(String memberId) {
		String sql = "select * from wishlist_view where member_id = ? "
					+ "order by product_no desc";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, productListMapper, data);
	}

	
	
	
	
	
	
}
