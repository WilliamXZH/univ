package com.group3.mapper;

import java.util.List;

import com.group3.po.Partner;
import com.group3.po.User;

public interface PartnerMapper {
	
	public List<Partner> getPartnerInfo(String id);

	public int partnerSave(Partner partner);

	public int partnerDelete(Partner partner);

	public int partnerAdd(Partner partner);

	public Partner partnerEdit(String mainUserId, String name);

	public int partnerAdd2(User user);

	public Partner getSelfInfo(String id, String name);

}
