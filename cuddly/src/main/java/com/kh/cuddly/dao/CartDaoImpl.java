package com.kh.cuddly.dao;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
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
		public List<OrdersProductDto> selectCartList(PaginationVO vo,String memberId) {
			
//			String sql = "select * from ordered_product where member_id = ? order by cart_date desc";
			
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from ordered_product where member_id = ? order by cart_date desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
			
			Object[] data= {memberId,vo.getStartRow(), vo.getFinishRow()};
			
			
			
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
	 
	 @Override
	public CartDto selectOne(int cartNo) {
		String sql = "select * from cart where cart_no=?";
		Object[] data = {cartNo};
		List<CartDto> list = jdbcTemplate.query(sql, cartMapper, data);
		return list.isEmpty()?null : list.get(0);
	}
	 
		@Override
		public int countList(PaginationVO vo,String memberId) {
			String sql = "select count(*) from ordered_product where member_id = ?";
			
			Object[] data = {memberId};
			
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
	
//	@Override
//	public CartDto selectOneByMemberId(String memberId,int cartNo) {
//		String sql="select * from cart where member_id=? and cart_no=?";
//		Object[]data= {memberId,cartNo};
//		List<CartDto> list=jdbcTemplate.query(sql, cartMapper, data);
//		return list.isEmpty() ? null: list.get(0);
//	}
	@Override
	public List<CartDto> CartListByMemberId(String memberId) {
		String sql="select * from cart "
				+ "where member_id=? ";
		Object[]data= {memberId};
		return jdbcTemplate.query(sql,cartMapper,data);
	}
	
}


