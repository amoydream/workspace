package com.lauvan.system.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_User_Limit;
import com.lauvan.system.service.UserLimitService;
@Service("userLimitService")
public class UserLimitServiceImpl extends BaseDAOSupport<T_User_Limit>
		implements UserLimitService {

}
