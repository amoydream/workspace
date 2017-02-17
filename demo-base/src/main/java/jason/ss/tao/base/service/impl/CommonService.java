package jason.ss.tao.base.service.impl;

import javax.annotation.Resource;

import jason.ss.tao.base.dao.impl.CommonDao;
import jason.ss.tao.base.entity.BaseEntity;

public class CommonService<E extends BaseEntity> {
	private CommonDao<E> commonDao;

	@Resource
	public void setCommonDao(CommonDao<E> commonDao) {
		this.commonDao = commonDao;
	}

	public CommonDao<E> getCommonDao() {
		return commonDao;
	}
}
