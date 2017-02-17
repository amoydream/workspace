package com.lauvan.system.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_Sequence;
import com.lauvan.system.service.SequenceService;
@Service("sequenceService")
public class SequenceServiceImpl extends BaseDAOSupport<T_Sequence> implements
		SequenceService {
	public Integer nextval(String name) {
		if (name!=null && name.trim()!="") {
			name = name.toLowerCase();//全部转换为小写
			T_Sequence s = find(name);
			if (s==null) {
				s = new T_Sequence(name,1l);
				save(s);
				return 1;
			}else {
				s.setSeq(s.getSeq()+1);
				update(s);
				return s.getSeq().intValue();
			}
		}
		return null;
	}
}
