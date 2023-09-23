package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.CreatorDto;
import com.kh.cuddly.mapper.AttachMapper;
import com.kh.cuddly.mapper.CreatorMapper;

@Repository
public class CreatorDaoImpl implements CreatorDao{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	CreatorMapper creatorMapper;
	
	@Autowired
	AttachMapper attachMapper;
		
	
	@Override
	public int sequence() {
		String sql = "select creator_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void insert(CreatorDto creatorDto) {
		String sql = "insert into creator(creator_no, creator_name)"
					+ "values(?, ?)";
		Object[] data = {creatorDto.getCreatorNo(),creatorDto.getCreatorName()};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean isNewCreator(String creatorName) {
		String sql = "select * from creator where instr(creator_name, ?) > 0";
		Object[] data = {creatorName};
		List<CreatorDto> list = jdbcTemplate.query(sql, creatorMapper, data); 
		return list.isEmpty() ? true : false;
	}

	@Override
	public CreatorDto selectOneByProductNo(int productNo) {//상품과 연결된 크리에이터 검색
		String sql = "select * from product p "
								+ "inner join creator_product cp on cp.product_no = p.product_no "
								+ "inner join creator c on c.creator_no = cp.creator_no "
							+ "where p.product_no = ?";
		Object[] data = {productNo};
		List<CreatorDto> list = jdbcTemplate.query(sql,  creatorMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public CreatorDto selectOne(String creatorName) {
		String sql = "select * from creator where creator_name = ?";
		Object[] data = {creatorName};
		List<CreatorDto> list = jdbcTemplate.query(sql, creatorMapper, data);
		return list.isEmpty()?null : list.get(0);
	}

	@Override
	public CreatorDto selectOne(int creatorNo) {
		String sql = "select * from creator where creator_no = ?";
		Object[] data = {creatorNo};
		List<CreatorDto> list = jdbcTemplate.query(sql, creatorMapper, data);
		return list.isEmpty()?null : list.get(0);
	}
	
	@Override
	public List<CreatorDto> selectList() {
			String sql = "select * from creator";
			return jdbcTemplate.query(sql, creatorMapper);
	}
	
	@Override
	public List<CreatorDto> selectList(String creatorName) {
		String sql = "select * from creator where instr(creator_name, ? )>0";
		Object[] data = {creatorName};
		return jdbcTemplate.query(sql, creatorMapper, data);
	}
	
	@Override
	public void connect(int attachNo, int creatorNo) {
		String sql = "insert into creator_image("
						+ "attach_no, creator_no)"
					+ "values(?,?)";
		Object[] data = {attachNo, creatorNo};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean deleteConnect(int creatorNo) {
		String sql = "delete creator_image where creator_no = ?";
		Object[] data = {creatorNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	
	@Override
	public AttachDto findCreatorImage(int creatorNo) {
		String sql = "select * from attach where attach_no = ("
						+ "select attach_no from creator_image "
						+ "where creator_no = ?)";
		Object[] data = {creatorNo}; 
		List<AttachDto> list = jdbcTemplate.query(sql, attachMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	@Override
	public List<CreatorDto> selectListJoinImage() {
		String sql = "SELECT * FROM creator c "
					+ "LEFT outer JOIN CREATOR_IMAGE ci ON c.CREATOR_NO = ci.creator_no "
					+ "LEFT outer JOIN attach a ON ci.attach_no = a.ATTACH_NO "
					+ "ORDER BY c.CREATOR_NO asc";
		return jdbcTemplate.query(sql, creatorMapper);
	}
}