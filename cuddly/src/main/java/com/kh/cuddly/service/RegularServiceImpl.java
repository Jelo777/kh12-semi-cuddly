package com.kh.cuddly.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.cuddly.dao.MemberDao;

//import lombok.extern.slf4j.Slf4j;

//@Slf4j
@Service
public class RegularServiceImpl implements RegularService {
	
	@Autowired
	private MemberDao memberDao;
	
	
//	@Scheduled(cron="0 * * * * *")//1분 마다
	@Scheduled(cron ="0 0 0 * * *")//매일하기
	@Override
		public void updateLevel() {
//			log.debug("됨?");
			memberDao.updateMemberLv();
	
		}
}
