package com.group3.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.PartnerMapper;
import com.group3.po.Partner;
import com.group3.po.User;
import com.group3.service.PartnerService;

import oracle.net.aso.n;

@Service
public class PartnerServiceImpl implements PartnerService {

	@Resource
	PartnerMapper partnerMapper;
	
	@Override
	public List<Partner> getPartnerInfo(String id){
		
		List<Partner> partner = partnerMapper.getPartnerInfo(id);
		
		return partner;
	}

	@Override
	public boolean partnerSave(Partner partner){
		System.out.println(partner);
		int result = partnerMapper.partnerSave(partner);
		if(result>0){
			return true;
		}
		return false;

	}

	@Override
	public boolean partnerDelete(Partner partner) {
		int result=partnerMapper.partnerDelete(partner);
		if(result>0){
			return true;
		}
		return false;
	}

	@Override
	public boolean partnerAdd(Partner partner) {
		int result = partnerMapper.partnerAdd(partner);
		if(result>0){
			return true;
		}
		return false;
	}

	@Override
	public Partner partnerEdit(String mainUserId, String name) {
		Partner partner = partnerMapper.partnerEdit(mainUserId,name);
		return partner;
	}

	@Override
	public boolean partnerAdd2(User user) {
		int result = partnerMapper.partnerAdd2(user);
		if(result>0){
			return true;
		}
		return false;
	}

	@Override
	public Partner getSelfInfo(String id, String name) {
		Partner partner = partnerMapper.getSelfInfo(id,name);
		return partner;
	}

}
