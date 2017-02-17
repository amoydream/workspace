package com.lauvan.organ.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.organ.entity.C_Address_Book;

public interface AddressBookService extends BaseDAO<C_Address_Book> {
	
	List<C_Address_Book> getAllByPeId(int pe_id);
}
