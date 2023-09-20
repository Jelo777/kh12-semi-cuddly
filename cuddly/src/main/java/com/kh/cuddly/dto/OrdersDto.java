package com.kh.cuddly.dto;


import java.sql.Date;

import lombok.Data;

@Data
public class OrdersDto {
    private int ordersNo;
    private String memberId;
    private int addressNo;
    private int ordersPrice;
    private String ordersPayment;
    private Date ordersDate;

	}

