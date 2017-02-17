package com.lauvan.organ.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.organ.entity.C_Position;

public interface PositionService extends BaseDAO<C_Position> {
	/**
	 * 根据岗位的id字符集(1,3,6)获取岗位名称字符集
	 * @param poids
	 * @return
	 */
	public String getPositionNames(String poids);
	
}
