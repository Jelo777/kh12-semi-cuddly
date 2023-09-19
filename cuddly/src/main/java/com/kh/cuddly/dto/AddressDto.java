package com.kh.cuddly.dto;

import lombok.Data;

@Data
public class AddressDto {
	private int addressNo;
	private String memberId;
	private String addressName, addressContact, addressPost;
	private String addressAddr1, addressAddr2;
	private String addressComent, addressDefault;

}
