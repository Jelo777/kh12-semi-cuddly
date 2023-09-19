package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.QnaDto;
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
		
		String sql = "update qna set qna_content=?,qna_date=sysdate where qna_no=?";
		
		Object[] data = {qnaDto.getQnaContent(),qnaDto.getQnaNo()};
		
		jdbcTemplate.update(sql,data);
		
		return jdbcTemplate.update(sql,data)>0;
	}

	@Override
	public QnaDto selectOne(int qnaNo) {
		
		String sql = "select * from qna where qna_no=?";
		
		Object[] data = {qnaNo};
		
		List<QnaDto> list =  jdbcTemplate.query(sql, qnaMapper,data);
		
		
		return list.isEmpty() ? null : list.get(0);
	}
	
	
	
	
	
	
	
}