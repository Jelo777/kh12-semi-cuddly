package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.mapper.ProductMapper;

@Repository
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Override
	public int sequence() {
		String sql = "select product_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProductDto productDto) {
		String sql = "insert into product("
						+ "product_no, product_name, product_price"
						+ ")"
					+ "values(?,?,?)";
		Object[] data = {
							productDto.getProductNo(), productDto.getProductName(),
							productDto.getProductPrice()
						};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public void connectMain(int productNo, int attachNo) {
		String sql = "insert into product_main_image values(?, ?)";
		Object[] data = {attachNo, productNo};
		jdbcTemplate.update(sql, data);	
	}

	@Override
	public void connectDetail(int productNo, int attachNo) {
		String sql = "insert into product_detail_image values(?, ?)";
		Object[] data = {attachNo, productNo};
		jdbcTemplate.update(sql, data);			
	}
	public ProductDto selectOne(int productNo) {
		String sql = "select * from product where product_no = ?";
		Object[] data = {productNo};
		List<ProductDto> list = jdbcTemplate.query(sql, productMapper,data);
		return list.isEmpty()?null : list.get(0);
	}
	
	@Override
	public int countList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from product "
					+ "where instr(product_name, ?)>0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from product";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	@Override
	public List<ProductDto> selectList(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "SELECT * FROM product WHERE instr(product_name, ?)>0 "
								+ "ORDER BY product_no DESC"
							+ ")TMP"
						+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "SELECT * FROM product "
						+ "ORDER BY product_no DESC"
					+ ")TMP"
				+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
	}
}
