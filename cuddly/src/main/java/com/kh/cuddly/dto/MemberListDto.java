package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberListDto {
	
	private String memberId;
	private String memberName;
	private String memberContact;
	private String memberEmail;
	private String memberLevel;
	private int memberTotalprice;
	private Date memberJoin;

}
