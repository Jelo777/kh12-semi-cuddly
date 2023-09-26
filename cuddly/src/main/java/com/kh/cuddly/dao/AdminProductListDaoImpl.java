package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AdminProductListDto;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.mapper.AdminProductListMapper;
import com.kh.cuddly.mapper.AttachMapper;

@Repository
public class AdminProductListDaoImpl implements AdminProductListDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AdminProductListMapper adminProductListMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Override
	public List<AdminProductListDto> selectList(PaginationVO vo) {
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select distinct "
				+ "(select count(*) from product_option where product_no=p.product_no) as option_count, "
				+ "p.product_no, "
				+ "p.product_name, "
				+ "p.product_date, "
				+ "c.creator_name "
				+ "from product p "
				+ "left outer join product_option po on p.product_no = po.product_no "
				+ "left outer join creator_product cp ON p.product_no = cp.product_no "
				+ "left outer join creator c ON cp.creator_no = c.creator_no "
				+ "order by product_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		Object[] data = {vo.getStartRow(), vo.getFinishRow()};
		return jdbcTemplate.query(sql, adminProductListMapper, data);
	}
	

	@Override
	public AttachDto findProductMainImage(int productNo) {
		String sql = "select * from attach where attach_no = ("
				+ "select attach_no from product_main_image "
				+ "where product_no=?"
				+ ")";
		Object[] data = {productNo};
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper, data);
		
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public int countList(PaginationVO vo) {
		String sql = "select count(*) from product";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

}
