package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.FaqlistVO;
import com.kh.cuddly.dto.FaqDto;
import com.kh.cuddly.mapper.FaqListMapper;
import com.kh.cuddly.mapper.FaqMapper;

@Repository
public class FaqDaoImpl implements FaqDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private FaqListMapper faqListMapper;
	
	@Autowired
	private FaqMapper faqMapper;
	
	
	
	@Override
	public void insert(FaqDto faqDto) {
		String sql = "insert into faq"
				+ "(faq_no,faq_id,faq_title,faq_content,faq_category) "
				+ "values(?,?,?,?,?)";
		
		Object[] data = {faqDto.getFaqNo(),faqDto.getFaqId(),faqDto.getFaqTitle(),faqDto.getFaqContent(),faqDto.getFaqCategory()};
		jdbcTemplate.update(sql,data);
	}
	

	@Override
	public int sequence() {
		String sql = "select notice_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	

	@Override
	public FaqDto selectOne(int faqNo) {
		String sql = "select * from faq where faq_no = ?";
		Object[] data = {faqNo};
		List<FaqDto> list = jdbcTemplate.query(sql, faqMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	
	@Override
	public List<FaqDto> selectList() {
		String sql = "select faq_no, faq_id, faq_title, faq_content, faq_date, faq_category "
				+ "from faq order by faq_no desc";
		return jdbcTemplate.query(sql, faqListMapper);
	}


	@Override
	public boolean update(FaqDto faqDto) {
		String sql = "update faq set faq_title=?, faq_content=?, faq_date = sysdate where faq_no=?";
		Object[] data = {faqDto.getFaqTitle(), faqDto.getFaqContent(), faqDto.getFaqNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}


	@Override
	public boolean delete(int faqNo) {
		String sql = "delete faq where faq_no = ?";
		Object[] data = {faqNo};
		return jdbcTemplate.update(sql, data) > 0;
	}


	@Override
	public List<FaqDto> selectList(String category, String keyword) {
	String sql = "select * from faq "
			+ "where instr(faq_category, ?) > 0 "
			+ "order by faq_no desc";		
	Object[] data = {keyword};
	return jdbcTemplate.query(sql, faqListMapper, data);
	}


	@Override
	public List<FaqDto> selectCategory(String faqCategory) {
		String sql = "select * from faq where faq_category = ?";
		Object[] data = {faqCategory};
		return jdbcTemplate.query(sql, faqMapper, data);
	}
	
	@Override
	public int countList(FaqlistVO vo) {
	    if (vo.isCategory()) {
	        String sql = "select count(*) from faq where faq_category = ?";
	        Object[] data = {vo.getCategory()};
	        return jdbcTemplate.queryForObject(sql, int.class, data);
	        
	    } else if (vo.isSearch()) {
	        String sql = "select count(*) from ("
	                   + "select rownum rn, TMP.* from ("
	                   + "SELECT * FROM faq WHERE instr(faq_content, ?) > 0 "
	                   + "ORDER BY faq_no DESC"
	                   + ")TMP"
	                   + ") where rn between ? and ?";
	        Object[] data = { vo.getKeyword(), vo.getStartRow(), vo.getFinishRow() };
	        return jdbcTemplate.queryForObject(sql, int.class, data);
	        
	    } else {
	        String sql = "select count(*) from faq";
	        return jdbcTemplate.queryForObject(sql, int.class);
	    }
	}


	


	@Override
	public List<FaqDto> selectListByPage(FaqlistVO vo) {
		if(vo.isCategory()) {
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
								+ "select * from faq where faq_category =? "
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {vo.getCategory(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, faqListMapper, data);
		}
		else {
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
							+ "select * from faq "
							+ ")TMP"
						+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, faqListMapper, data);
		}
	}
	
	@Override
	public List<FaqDto> selectListByTitle(String keyword) {
	    String sql = "select * from faq where instr(faq_title, ?) > 0 order by faq_no desc";
	    Object[] data = { keyword };
	    return jdbcTemplate.query(sql, faqListMapper, data);
	}

	

}
	