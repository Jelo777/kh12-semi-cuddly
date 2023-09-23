package com.kh.cuddly.dao;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.OrdersProductDto;
import com.kh.cuddly.mapper.CartMapper;
import com.kh.cuddly.mapper.OrdersProductMapper;


@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private OrdersProductMapper ordersProductMapper;
	
	
	@Override
	public int sequence() {
		String sql = "select cart_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(CartDto cartDto) {
		String sql = "insert into cart("
				+ "cart_no,member_id,option_no,cart_count,cart_price"
				+  ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				cartDto.getCartNo(),cartDto.getMemberId(),cartDto.getOptionNo(),cartDto.getCartCount(),cartDto.getCartPrice()
		};
		jdbcTemplate.update(sql,data);
	}

//	 @Override
//	    public List<CartDto> selectCartList() {
//	        String sql = "SELECT c.*, p.product_name " +
//	                     "FROM cart c " +
//	                     "JOIN product_option po ON c.option_no = po.product_option_no " +
//	                     "JOIN product p ON po.product_no = p.product_no";
//	        return jdbcTemplate.query(sql, cartMapper);
//	    }
	 
	 @Override
		public List<OrdersProductDto> selectCartList(String memberId) {
			
			String sql = "select * from ordered_product where member_id = ?";
			
			Object[] data= {memberId};
			
			
			
		    return jdbcTemplate.query(sql, ordersProductMapper, data);
			
		
			
			
		}
	 
	 @Override
	 	public int price(int optionNo) {
		 
		 String sql = "select product_price from "
		 		+ "product_option o join product p on p.product_no=o.product_no "
		 		+ "where product_option_no=?";
		 
		 Object[] data = {optionNo};
		 
		 return jdbcTemplate.queryForObject(sql, int.class,data);	 
	 }
	 
	 public boolean cartDelete(int cartNo) {
		 
		 String sql = "delete cart where cart_no=?";
		 
		 Object[] data= {cartNo};
		 
		 return jdbcTemplate.update(sql,data)>0;
		 
	 }
	
}


