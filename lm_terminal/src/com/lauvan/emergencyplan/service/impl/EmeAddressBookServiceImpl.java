package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_EmeAddressBook;
import com.lauvan.emergencyplan.service.EmeAddressBookService;
@Service("emeAddressBookService")
public class EmeAddressBookServiceImpl extends BaseDAOSupport<E_EmeAddressBook>
		implements EmeAddressBookService {

}
