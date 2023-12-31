package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.QnaDto;
import com.kh.cuddly.mapper.AttachMapper;
import com.kh.cuddly.mapper.QnaMapper;

@Repository
public class QnaDaoImpl implements QnaDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaMapper qnaMapper;
	
	@Override
	public int sequence() {
		
		String sql = "select qna_no.nextval from dual";
		
		return jdbcTemplate.queryForObject(sql, int.class);
		
		
	}

	@Override
	public void insert(QnaDto qnaDto) {
		
		String sql = "insert into qna(qna_no,product_no,member_id,qna_content,qna_answer) "
				+ "values(?,?,?,?,?)";
		
		Object[] data = {qnaDto.getQnaNo(),qnaDto.getProductNo(),qnaDto.getMemberId(),qnaDto.getQnaContent(),qnaDto.getQnaAnswer()
	};
		
		jdbcTemplate.update(sql,data);

}

	@Override
	public boolean update(QnaDto qnaDto) {
		
		String sql = "update qna set qna_content=? where qna_no=?";
		
		Object[] data = {qnaDto.getQnaContent(),qnaDto.getQnaNo()};
		
		jdbcTemplate.update(sql,data);
		
		return jdbcTemplate.update(sql,data)>0;
	}
	
	@Override
	public boolean updateByAnswer(QnaDto qnaDto) {//상품문의 답변용
		String sql = "update qna set qna_answer = ? where qna_no = ?";
		Object[] data = {qnaDto.getQnaAnswer(), qnaDto.getQnaNo()};
		
		return jdbcTemplate.update(sql, data) > 0;
	}
	

	@Override
	public QnaDto selectOne(int qnaNo) {
		
		String sql = "select * from qna where qna_no=?";
		
		Object[] data = {qnaNo};
		
		List<QnaDto> list =  jdbcTemplate.query(sql, qnaMapper,data);
		
		
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<QnaDto> selectList() {
		String sql = "select * from qna order by qna_date desc";
		List<QnaDto> list = jdbcTemplate.query(sql, qnaMapper);
		return list;
	}
	
	@Override
	public List<QnaDto> memberList(String memberId,PaginationVO vo) {
		
		
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from qna where member_id=? order by qna_date desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		
		Object[] data = {memberId,vo.getStartRow(), vo.getFinishRow()};
		
		List<QnaDto> list = jdbcTemplate.query(sql, qnaMapper, data);
		
		
		return list;
	}
	
//	@Override
//	public List<QnaDto> selectList() {
//		
//		String sql = "select q.*, pam.attach_no from qna q "
//				+ "left outer join product_main_image pam "
//				+ "on q.product_no=pam.product_no";
//		
//		List<QnaDto> list = jdbcTemplate.query(sql, qnaMapper);
//		
//		
//		return list;
//	}
	
	@Override
	public List<QnaDto> selectList(int productNo) {
		String sql = "select * from qna where product_no = ? order by qna_date desc";
		Object[] data = {productNo};
		return jdbcTemplate.query(sql, qnaMapper, data);
	}
	
	@Override
	public boolean delete(int qnaNo) {
		
		String sql = "delete qna where qna_no=?";
		
		Object[] data = {qnaNo};
		
		return jdbcTemplate.update(sql,data)>0;
		
	}
	
	@Override
	public int countList(PaginationVO vo,String memberId) {
		String sql = "select count(*) from qna where member_id=?";
		
		Object[] data = {memberId};
		
		return jdbcTemplate.queryForObject(sql, int.class,data);
	}
	
}