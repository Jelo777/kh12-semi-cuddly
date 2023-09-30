package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.QnaDto;

public interface QnaDao {
	
	void insert(QnaDto qnaDto);
	int sequence();
	boolean update(QnaDto qnaDto);
	boolean updateByAnswer(QnaDto qnaDto);//상품문의 답변용
	QnaDto selectOne(int qnaNo);
	List<QnaDto> selectList();
	List<QnaDto> memberList(String memberId,PaginationVO vo);
	List<QnaDto> selectList(int productNo);
	boolean delete(int qnaNo);
	int countList(PaginationVO vo,String memberId);
	
}
