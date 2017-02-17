package com.lauvan.organ.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.service.BaseService;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.dao.ContactDao;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.service.ContactService;
import com.lauvan.organ.vo.ContactVo;

@Service("contactService")
public class ContactServiceImpl extends BaseService implements ContactService {
	@Autowired
	private ContactDao contactDao;

	@Override
	public QueryResult<ContactVo> getContacts(ContactVo vo) {
		QueryResult<ContactVo> queryResult = new QueryResult<>();
		QueryResult<V_Contact> result = contactDao.getContacts(vo);
		List<V_Contact> contactList = result.getResultlist();
		List<ContactVo> voList = new ArrayList<>(8);
		if(contactList != null) {
			for(V_Contact contact : contactList) {
				ContactVo contactVo = new ContactVo();
				BeanUtils.copyProperties(contact, contactVo);
				voList.add(contactVo);
			}
		}

		queryResult.setTotalrecord(result.getTotalrecord());
		queryResult.setResultlist(voList);
		return queryResult;
	}

	@Override
	public List<ContactVo> getContactPage(ContactVo vo) {
		List<V_Contact> contactList = contactDao.getContactPage(vo);
		List<ContactVo> voList = new ArrayList<>();
		if(contactList != null) {
			for(V_Contact contact : contactList) {
				ContactVo contactVo = new ContactVo();
				BeanUtils.copyProperties(contact, contactVo);
				voList.add(contactVo);
			}
		}

		return voList;
	}
	
	@Override
	public List<ContactVo> getMobileContactPage(ContactVo vo) {
		List<V_Contact> contactList = contactDao.getMobileContactPage(vo);
		List<ContactVo> voList = new ArrayList<>();
		if(contactList != null) {
			for(V_Contact contact : contactList) {
				ContactVo contactVo = new ContactVo();
				BeanUtils.copyProperties(contact, contactVo);
				voList.add(contactVo);
			}
		}

		return voList;
	}

	@Override
	public ContactVo getContactByMobile(String mobile) {
		List<V_Contact> list = contactDao.getListEntitys(" tel_mobile = ?1", new String[]{mobile});
		if(list != null && list.size() > 0) {
			V_Contact vc = list.get(0);
			ContactVo vo = new ContactVo();
			BeanUtils.copyProperties(vc, vo);
			return vo;
		}

		return null;
	}

	@Override
	public List<ContactVo> getContactByMobiles(String[] mobiles) {
		List<V_Contact> list = contactDao.getContactByMobiles(mobiles);
		if(list != null && list.size() > 0) {
			List<ContactVo> voList = new ArrayList<>();
			for(V_Contact vc : list) {
				ContactVo vo = new ContactVo();
				BeanUtils.copyProperties(vc, vo);
				voList.add(vo);
			}
			return voList;
		}
		return null;
	}

	@Override
	public List<V_Contact> getAllMobileContacts() {
		return contactDao.getAllMobileContacts();
	}

	@Override
	public V_Contact getContactById(String contact_id) {
		return contactDao.find(contact_id);
	}
}
