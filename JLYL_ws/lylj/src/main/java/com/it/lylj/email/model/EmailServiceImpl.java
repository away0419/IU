package com.it.lylj.email.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.it.lylj.common.SearchVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService{
	private final EmailDAO emailDao;
	
	@Override
	public int sendEmail(EmailVO vo) {
		return emailDao.sendEmail(vo);
	}
	
	// 101(이름) 에서 이름 분리 
	@Override
	public String splitName(String taker) {
		String[] splitTaker = taker.split("@");
		String emailTake = "";
		for(int i=0;i<splitTaker.length;i++) {
			emailTake = splitTaker[0];
		}
		
		return emailTake;
	}


	@Override
	public EmailVO selectByMailNo(int mailNo) {
		return emailDao.selectByMailNo(mailNo);
	}


	@Override
	public List<Map<String, Object>> selectListByType(SearchVO searchVo, int type) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(type==EmailService.TAKE_MAIL) {
			list = emailDao.selectTakeMailList(searchVo);
		}else if(type==EmailService.SEND_MAIL) {
			list= emailDao.selectSendMailList(searchVo);
		}
		
		return list;
	}

	@Override
	public int totalRecordByType(String taker, int type) {
		int totalRecord = 0;
		if(type==EmailService.TAKE_MAIL) {
			totalRecord = emailDao.totalRecordByEmailTake(taker);
		}else if(type==EmailService.SEND_MAIL) {
			totalRecord = emailDao.totalRecordByEmailSend(taker);
		}
		
		return totalRecord;
	}
}
