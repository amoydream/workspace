package com.lauvan.emergencyplan.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.emergencyplan.entity.E_PlanInfo;
import com.lauvan.emergencyplan.vo.PlanInfoVo;

public interface PlanInfoService extends BaseDAO<E_PlanInfo> {

	QueryResult<E_PlanInfo> getPlanInfoList(PlanInfoVo vo);

	QueryResult<E_PlanInfo> getPlanInfoListByEvId(Integer ev_id);

}
