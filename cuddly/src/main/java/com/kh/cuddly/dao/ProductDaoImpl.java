package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.mapper.AttachMapper;
import com.kh.cuddly.mapper.ProductMapper;

@Repository
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Override
	public int sequence() {
		String sql = "select product_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(ProductDto productDto) {
		String sql = "insert into product("
						+ "product_no, product_name, product_price, product_item"
						+ ")"
					+ "values(?,?,?, ?)";
		Object[] data = {
							productDto.getProductNo(), productDto.getProductName(),
							productDto.getProductPrice(), productDto.getProductItem()
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
		else if(vo.isSearchByCreatorName()) {
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select product.* from product inner join creator_product "
								+ "on creator_product.product_no = product.product_no "
								+ "LEFT OUTER JOIN creator ON creator_product.creator_no = creator.creator_no "
								+ "WHERE creator.creator_name = ? "
								+ "order by product.product_no desc "
							+ ")TMP"
						+ ") where rn between ? and ?";
			Object[] data = {vo.getCreatorName(), vo.getStartRow(), vo.getFinishRow()}; 
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else if(vo.isSort()) {
			String sql = "select * from( "
							+ "select rownum rn, TMP.* from( "
							+ "select * from product order by " + vo.getType() + " " + vo.getSort()
							+")TMP"
						+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else if(vo.isSortByWishlist()) {
			String sql = "select * from( "
					+ "select rownum rn, TMP.* from( "
					+ "SELECT p.*, (SELECT COUNT(*) FROM wishlist w WHERE w.product_no = p.product_no) AS wishlist_count "
					+ "FROM product p "
					+ "ORDER BY wishlist_count " + vo.getSortByWish()
					+")TMP"
				+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
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
	public AttachDto findProductDetailImage(int productNo) {
		String sql = "select * from attach where attach_no = ("
						+ "select attach_no from product_detail_image "
						+ "where product_no=?"
					+ ")";
		Object[] data = {productNo};
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
}
