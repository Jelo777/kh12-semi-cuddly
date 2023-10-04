package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.ProductListVO;
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
	
	@Override
	public ProductDto selectOne(int productNo) {
		String sql = "select * from product where product_no = ?";
		Object[] data = {productNo};
		List<ProductDto> list = jdbcTemplate.query(sql, productMapper,data);
		return list.isEmpty()?null : list.get(0);
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
	
	
	
	
	@Override
	public List<ProductDto> selectList(ProductListVO vo) {
		if(!vo.isSearch()) {
			String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
						+ "select * from product_list_view "
						+ "ORDER BY " + vo.getTarget() + " " + vo.getSort()
						+")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else {
			String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
						+ "select * from product_list_view "
						+ "where instr(product_name,?)>0 "
						+ "ORDER BY " + vo.getTarget() + " " + vo.getSort()
						+")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword() ,vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
	}
	
	@Override
	public List<ProductDto> selectListByCreator(ProductListVO vo) {
		if(vo.getTarget().equals("wishlist_count")) {
			String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
							+ "SELECT * FROM product_list_view p INNER JOIN CREATOR_PRODUCT cp "
							+ "ON cp.PRODUCT_NO = p.product_no "
							+ "LEFT OUTER JOIN creator c ON cp.CREATOR_NO = c.CREATOR_NO "
							+ "where c.creator_name = ? "
							+ "ORDER BY " + vo.getTarget() + " " + vo.getSort()
							+")TMP"
						+ ") where rn between ? and ?";
			Object[] data = {vo.getCreator(), vo.getStartRow(), vo.getFinishRow()}; 
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else{
			String sql = "select * from( "
					+ "select rownum rn, TMP.* from( "
						+ "SELECT * FROM product_list_view p INNER JOIN CREATOR_PRODUCT cp "
						+ "ON cp.PRODUCT_NO = p.product_no "
						+ "LEFT OUTER JOIN creator c ON cp.CREATOR_NO = c.CREATOR_No "
						+ "where c.creator_name = ? "
						+ "ORDER BY p." + vo.getTarget() + " " + vo.getSort()
						+")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getCreator(), vo.getStartRow(), vo.getFinishRow()}; 
			return jdbcTemplate.query(sql, productMapper, data);
		}
	}
	
	@Override
	public List<ProductDto> selectListByProductItem(ProductListVO vo) {
		if(vo.getKeyword()==null) {
			String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
						+ "select * from product_list_view "
						+ "where product_item = ? "
						+ "ORDER BY " + vo.getTarget() + " " + vo.getSort()
						+")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getItem() ,vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
		else {
			String sql = "select * from( "
						+ "select rownum rn, TMP.* from( "
						+ "select * from product_list_view "
						+ "where product_item = ? "
						+ "and "
						+ "instr(product_name, ?)>0"
						+ "ORDER BY " + vo.getTarget() + " " + vo.getSort()
						+")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {vo.getItem(),vo.getKeyword() ,vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, productMapper, data);
		}
	}
	
	@Override
	public int countList(ProductListVO vo) {
		
		if(vo.isItem()&&vo.getKeyword()!=null) {
			String sql = "select count(*) from product_list_view where product_item = ? "
					+ "and instr(product_name, ?)>0";
			Object[] data = {vo.getItem(), vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else if(vo.isItem()) {
			String sql = "select count(*) from product_list_view where product_item = ?";
			Object[] data = {vo.getItem()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else if(vo.isSearch()) {
			String sql = "select count(*) from product_list_view where instr(product_name, ?) >0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else if(vo.isCreator()) {
			String sql = "select count(*) "
						+ "from product_list_view p inner join creator_product "
						+ "on creator_product.product_no = p.product_no "
						+ "left outer join creator on creator_product.creator_no = creator.creator_no "
						+ "where creator.creator_name = ?";
			Object[] data = {vo.getCreator()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from product_list_view";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
}