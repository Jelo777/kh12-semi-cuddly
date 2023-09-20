package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.WishlistDto;
import com.kh.cuddly.mapper.WishlistMapper;

@Repository
public class WishlistDaoImpl implements WishlistDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private WishlistMapper wishlistMapper;
	

	@Override
	public int sequence() {
		String sql = "select wishlist_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(WishlistDto wishlistDto) {
		String sql = "insert into wishlist("
				+ "wishlist_no, wishlist_date"
				+ ") values(?, ?)";
		Object[] data = {
				wishlistDto.getWishlistNo(), wishlistDto.getWishlistDate()
		};
		jdbcTemplate.update(sql, data);
		}

	@Override
	public WishlistDto selectOne(int WishlistNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<WishlistDto> selectList() {
		String sql = "select * from wishlist";
		return jdbcTemplate.query(sql, wishlistMapper);
	}

	@Override
	public void delete(int wishlistNo) {
		String sql = "delete from wishlist where wishlist_no = ?";
		Object[] data = {wishlistNo};
		jdbcTemplate.update(sql, data);
		
	}
		
	}

