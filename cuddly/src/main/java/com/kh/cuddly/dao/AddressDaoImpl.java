package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.AddressDto;
import com.kh.cuddly.mapper.AddressMapper;

@Repository
public class AddressDaoImpl implements AddressDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AddressMapper addressMapper;
	
	
	
	@Override
	public int sequence() {
		String sql ="select address_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	

	@Override
	public void insert(AddressDto addressDto) {
		
		String sql="insert into address("
				+ "address_no, member_id, address_name, "
				+ "address_contact, address_post, address_addr1, "
				+ "address_addr2, address_coment, address_default) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {addressDto.getAddressNo(), addressDto.getMemberId(), 
				addressDto.getAddressName(), addressDto.getAddressContact(), 
				addressDto.getAddressPost(), addressDto.getAddressAddr1(), 
				addressDto.getAddressAddr2(),addressDto.getAddressComent(),
				addressDto.getAddressDefault() //!= null ? "Y" : "N"
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public AddressDto selectOne(String memberId) {
		String sql="select * from address where member_id=? and address_default='Y'";
		Object[] data= {memberId};
		List<AddressDto>list=jdbcTemplate.query(sql, addressMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}
	@Override
	public List<AddressDto> selectList() {
		String sql="select * from address order by address_default desc, address_no asc";
		return jdbcTemplate.query(sql, addressMapper);
	}
	@Override
	public void changeDefault() {
		String sql="update address set address_default ='N' where address_default='Y'";
		 jdbcTemplate.update(sql);
	}
}
