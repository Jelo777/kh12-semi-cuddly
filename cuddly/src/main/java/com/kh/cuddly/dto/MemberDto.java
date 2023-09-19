package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	
	private String memberId, memberName, memberPw;
	private String memberContact, memberEmail;
	private String memberBirth, memberLevel;
	private int memberTotalprice;
	private Date memberJoin,memberUdate;
}
