package com.lauvan.organ.service.impl;


import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.organ.entity.C_Position;
import com.lauvan.organ.service.PositionService;
import com.lauvan.util.ValidateUtil;

@Service("positionService")
public class PositionServiceImpl extends BaseDAOSupport<C_Position> implements
		PositionService {
	public String getPositionNames(String poids) {
		if (ValidateUtil.isEmpty(poids)) {
			return null;
		}
		StringBuilder sb = new StringBuilder();
		String[] ids = poids.split(",");
		for (String s : ids) {
			C_Position p = find(Integer.valueOf(s));
			if(p!=null){
				sb.append(p.getP_name()).append(",");
			}
			
		}
		if(sb.length()>0){
			sb.delete(sb.length()-1,sb.length());
		}
		
		return sb.toString();
	}
	
}
