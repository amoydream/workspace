package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_EmeOrganPerson;

public interface EmeOrganPersonService extends BaseDAO<E_EmeOrganPerson> {
	public void addAll(List<E_EmeOrganPerson> eops);
}
