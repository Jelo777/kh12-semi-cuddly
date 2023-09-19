package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.cuddly.dto.WishlistDto;

public class WishlistDaoImpl implements WishlistDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	

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
		
	}

