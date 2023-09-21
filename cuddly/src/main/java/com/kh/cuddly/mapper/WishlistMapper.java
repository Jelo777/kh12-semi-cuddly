package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.WishlistDto;

@Component
public class WishlistMapper implements RowMapper<WishlistDto>{

	@Override
	public WishlistDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		WishlistDto wishlistDto = new WishlistDto();
		wishlistDto.setWishlistNo(rs.getInt("wishlist_no"));
		wishlistDto.setProductNo(rs.getInt("product_no"));
		wishlistDto.setMemberId(rs.getString("member_id"));
		wishlistDto.setWishlistDate(rs.getDate("wishlist_date"));
		return wishlistDto;
	}
}
