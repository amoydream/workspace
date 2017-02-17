package com.lauvan.organ.service;

import java.util.List;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.vo.ContactVo;

public interface ContactService {
	QueryResult<ContactVo> getContacts(ContactVo vo);

	List<ContactVo> getContactPage(ContactVo vo);

	ContactVo getContactByMobile(String mobile);

	List<ContactVo> getContactByMobiles(String[] mobiles);

	List<V_Contact> getAllMobileContacts();

	List<ContactVo> getMobileContactPage(ContactVo vo);

	V_Contact getContactById(String contact_id);
}
