package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.WishlistDto;

public class WishlistMapper implements RowMapper<WishlistDto>{

	@Override
	public WishlistDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		WishlistDto wishlistDto = new WishlistDto();
		wishlistDto.setWishlistNo(rs.getInt("wishlist_no"));
		wishlistDto.setWishlistDate(rs.getDate("wishlist_date"));
		return wishlistDto;
	}
}
