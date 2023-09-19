package com.kh.cuddly.dao;

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
				+ "address_addr2, address_coment) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {addressDto.getAddressNo(), addressDto.getMemberId(), 
				addressDto.getAddressName(), addressDto.getAddressContact(), 
				addressDto.getAddressPost(), addressDto.getAddressAddr1(), 
				addressDto.getAddressAddr2(),addressDto.getAddressComent()
		};
		jdbcTemplate.update(sql,data);
	}

}
