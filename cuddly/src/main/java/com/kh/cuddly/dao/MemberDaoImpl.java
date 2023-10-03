package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MemberListDto;
import com.kh.cuddly.mapper.MemberListMapper;
import com.kh.cuddly.mapper.MemberMapper;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private MemberListMapper memberListMapper;

	@Override
	public void insert(MemberDto memberDto) {
		String sql="insert into member("
					+ "member_id, member_name, member_pw, "
					+ "member_contact, member_email, member_birth) "
					+ "values(?, ?, ? ,?, ?, ?)";
		Object[] data= {
				memberDto.getMemberId(),memberDto.getMemberName(), 
				memberDto.getMemberPw(), memberDto.getMemberContact(), 
				memberDto.getMemberEmail(), memberDto.getMemberBirth()
				
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public MemberDto selectOne(String memberId) {
		String sql="select * from member where member_id =?";
		Object[] data= {
				memberId
		};
		List<MemberDto> list=jdbcTemplate.query(sql, memberMapper,data);
		return list.isEmpty() ? null: list.get(0);
	}
	
	@Override
	public boolean updateMemberPw(String memberId, String changePw) {
		String sql="update member "
					+ "set member_pw=?, member_udate=sysdate "
					+ "where member_id=?";
		Object[] data= {changePw, memberId};
		return jdbcTemplate.update(sql,data)>0;
	}
	
	@Override
	public boolean updateMemberInfo(MemberDto memberDto) {
		String sql="update member set "
					+ "member_contact =?, "
					+ "member_birth =? where member_id= ?";
		Object[] data= {
				memberDto.getMemberContact(), 
				memberDto.getMemberBirth(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql,data)>0;
	}
	
	@Override
	public boolean updateMemberLevel(MemberDto memberDto) {
		String sql = "update member set member_level = ? where member_id =?";
		Object[] data = {memberDto.getMemberLevel(), memberDto.getMemberId()};
		
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean updateMemberTotalPrice(MemberDto memberDto) {
		String sql = "update member set member_totalprice = ?  where member_id=?";
		Object[] data = {memberDto.getMemberTotalprice(), memberDto.getMemberId()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean delete(String memberId) {
		String sql="delete member where member_id =?";
		Object[] data= {memberId};
		return jdbcTemplate.update(sql,data)>0;
	}
	@Override
	public MemberDto selectOneByEmail(String memberEmail) {
		String sql="select * from member where member_email=?";
		Object[] data= {memberEmail};
		List<MemberDto> list=jdbcTemplate.query(sql, memberMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//회원수 카운트
	@Override
	public int countList(PaginationVO vo) {
		if(vo.isSearchByMember()) {//회원검색이면
			String sql = "select count(*) from member where instr("+vo.getType()+", ?) > 0";
			Object[] data = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from member";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	//한페이지당 회원 리스트 구하기
	@Override
	public List<MemberListDto> selectByPage(PaginationVO vo) {
		if(vo.isSearchByMember()) {//회원검색이면
			String sql = "select * from("
									+ "select rownum rn, TMP.* from("
										+ "select * from member "
										+ "where instr("+vo.getType()+", ?) > 0 "
										+ "order by "+vo.getType()+" asc"
									+ ") TMP"
								+ ") where rn between ? and ?";
			Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberListMapper, data);
		}
		else {//검색이 아니면
			String sql = "select * from ("
									+ "select rownum rn, TMP.* from("
										+ "select * from member "
										+ "order by member_join desc"
									+ ") TMP"
								+ ") where rn between ? and ?";
			Object[] data = {vo.getStartRow(), vo.getFinishRow()};
			return jdbcTemplate.query(sql, memberListMapper, data);
		}
	}

	@Override
	public boolean updateMemberLv() {
		String sql="update member set member_level = "
				+ "case "
				+ "when member_totalprice >=100000 "
				+ "and member_level <> '관리자' then '골드' "
				+ "when member_totalprice >=50000 "
				+ "and member_level <> '관리자' then '실버' "
				+ "else member_level "
				+ "end";
		return jdbcTemplate.update(sql)>0;
	}
	
	
}
