package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.CartDto;

@Component
public class CartMapper implements RowMapper<CartDto>{

	@Override
	public CartDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CartDto cartDto = new CartDto();
		cartDto.setCartNo(rs.getInt("cart_no"));
		cartDto.setMemberId(rs.getString("member_id"));
		cartDto.setOptionNo(rs.getInt("option_no"));
		cartDto.setCartCount(rs.getInt("cart_count"));
		cartDto.setCartPrice(rs.getInt("cart_price"));
		
		return cartDto;
	}
}
