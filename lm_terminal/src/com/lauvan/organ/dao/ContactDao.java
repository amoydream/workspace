package com.lauvan.organ.dao;

import java.util.List;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.vo.ContactVo;

public interface ContactDao extends BaseDAO1<V_Contact> {
	QueryResult<V_Contact> getContacts(ContactVo vo);

	List<V_Contact> getContactPage(ContactVo vo);

	List<V_Contact> getContactByMobiles(String[] mobiles);
	
	List<V_Contact> getAllMobileContacts();

	List<V_Contact> getMobileContactPage(ContactVo vo);
}
