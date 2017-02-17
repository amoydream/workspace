package com.lauvan.organ.service.impl;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.service.AddressBookService;

@Service("addressBookService")
public class AddressBookServiceImpl extends BaseDAOSupport<C_Address_Book>
		implements AddressBookService {
			
			@SuppressWarnings("unchecked")
			@Override
			public List<C_Address_Book> getAllByPeId(int pe_id) {
				Query q = em.createQuery("from C_Address_Book where pe_id = " + pe_id);
				return q.getResultList();
			}
}
