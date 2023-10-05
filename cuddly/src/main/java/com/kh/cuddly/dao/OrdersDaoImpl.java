package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrderDetailJoinDto2;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;
import com.kh.cuddly.mapper.OrderDetailJoinMapper;
import com.kh.cuddly.mapper.OrderDetailJoinMapper2;
import com.kh.cuddly.mapper.OrdersMapper;
import com.kh.cuddly.mapper.OrdersProductMapper;


@Repository
public class OrdersDaoImpl implements OrdersDao{

	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersMapper ordersMapper;
	
	@Autowired
	private OrdersProductMapper ordersProductMapper;
	
	@Autowired
	private OrderDetailJoinMapper orderDetailjoinMapper;
	
	@Autowired
	private OrderDetailJoinMapper2 orderDetailjoinMapper2;
	
	
	
	@Override
	public int sequence() {
		String sql = "select orders_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(OrdersDto ordersDto) {
		String sql = "insert into orders ("
	            + "orders_no, member_id, address_no, orders_price, orders_payment "
	            + ") values (?, ?, ?, ?, ?)";
		 Object[] data = {
		            ordersDto.getOrdersNo(), ordersDto.getMemberId(), ordersDto.getAddressNo(), 
		            ordersDto.getOrdersPrice(), ordersDto.getOrdersPayment()
		    };
		jdbcTemplate.update(sql, data);
	}
	
	
	
	
// 뭔가 이상해서 내 맘대로 수정
//	@Override
//	public OrdersDto selectOne(String memberId) {
//	    String sql =  "SELECT m.member_name, m.member_contact, m.member_email " +
//                "FROM orders o " +
//                "JOIN member m ON o.member_id = m.member_id " +
//                "WHERE o.orders_no = ?";
//	    Object[] data = {memberId};
//	    List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
//	    return list.isEmpty() ? null : list.get(0);
//	}
//	
	@Override
	public OrdersDto selectOne(String memberId) {
		String sql =  "SELECT m.member_name, m.member_contact, m.member_email " +
				"FROM orders o " +
				"JOIN member m ON o.member_id = m.member_id " +
				"WHERE m.member_id = ?";
		Object[] data = {memberId};
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}


	
	
	
	
	
	
	
	
	

	@Override
	public List<OrdersDto> selectList() {
		String sql = "select * from orders_list order by orders_detail_no desc";
		return jdbcTemplate.query(sql, ordersMapper);
	}
	
	@Override
	public OrdersProductDto viewProduct(int cartNo) {
		
		String sql = "select * from ordered_product where cart_no = ?";
		
		Object[] data= {cartNo};
		
		List<OrdersProductDto> list = jdbcTemplate.query(sql, ordersProductMapper, data);
	    return list.isEmpty() ? null : list.get(0);
	}
	
	
	@Override
	public List<OrdersDto> selectOneByMemberOrders(String memberId) {//회원별 구매내역
		String sql = "select * from orders "
				+ "inner join member on orders.member_id = member.member_id "
				+ "where orders.member_id = ?";
		Object[] data = {memberId};
		
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list;
	}
	
	@Override
	public List<OrderDetailJoinDto> selectListOrders(String memberId){	//주문 목록
		
		String sql = "select * from orders_detail_list where member_id=? order by orders_no desc";
		
		Object[] data = {memberId};
		
		return jdbcTemplate.query(sql, orderDetailjoinMapper, data);
		
	}
	 
	@Override
	public List<OrderDetailJoinDto2> selectListOrders2(PaginationVO vo,String memberId){	//주문 목록
		
//		String sql = "select * from orders_detail_list1 where member_id=? order by orders_no desc";
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from orders_detail_list1 where member_id=? order by orders_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		
		Object[] data = {memberId,vo.getStartRow(), vo.getFinishRow()};
		
		return jdbcTemplate.query(sql, orderDetailjoinMapper2, data);
		
	}
	
	@Override
	public int countList(PaginationVO vo,String memberId) {
		String sql = "select count(*) from orders_detail_list1 where member_id=?";
		
		Object[] data = {memberId};
		
		return jdbcTemplate.queryForObject(sql, int.class,data);
	}
	
	@Override
	public OrderDetailJoinDto selectOneByProductNo(String memberId, int productNo) {
		String sql="select * from detail_order where member_id=? and product_no =?";
		
		Object[] data= {memberId,productNo};
		List<OrderDetailJoinDto>list=jdbcTemplate.query(sql,orderDetailjoinMapper,data);
		
		return list.isEmpty() ? null: list.get(0);
	}
	
}


