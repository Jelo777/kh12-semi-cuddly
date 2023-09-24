package com.kh.cuddly;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

//스케줄러 쓰기
@EnableScheduling
@SpringBootApplication
public class CuddlyApplication {

	public static void main(String[] args) {
		SpringApplication.run(CuddlyApplication.class, args);
	}

}
