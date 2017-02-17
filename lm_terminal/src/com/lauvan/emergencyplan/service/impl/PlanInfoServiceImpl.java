package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.emergencyplan.entity.E_PlanInfo;
import com.lauvan.emergencyplan.service.PlanInfoService;
import com.lauvan.emergencyplan.vo.PlanInfoVo;

@Service("planInfoService")
public class PlanInfoServiceImpl extends BaseDAOSupport<E_PlanInfo> implements PlanInfoService {

	@Override
	public QueryResult<E_PlanInfo> getPlanInfoList(PlanInfoVo vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public QueryResult<E_PlanInfo> getPlanInfoListByEvId(Integer ev_id) {
		// TODO Auto-generated method stub
		return null;
	}
	/*@Autowired
	private EventInfoService	eventInfoService;
	@Autowired
	private PlanTypeService		planTypeService;

	@Override
	public QueryResult<E_PlanInfo> getPlanInfoList(PlanInfoVo vo) {
		return getPagingRecords(createPaginationQuery(vo));
	}

	@Override
	public QueryResult<E_PlanInfo> getPlanInfoListByEvId(Integer ev_id) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		if(eventInfo != null) {
			String ev_name = eventInfo.getEventType().getEt_name();
			if(!ValidateUtil.isEmail(ev_name)) {
				String sql = "pt_name like ?1";
				List<E_PlanType> planTypeList = planTypeService.getListEntitys(sql, new Object[]{"%" + ev_name + "%"});
				if(planTypeList != null) {
					Set<Integer> pt_id_set = new HashSet<Integer>();
					for(E_PlanType planType : planTypeList) {
						pt_id_set.add(planType.getPt_id());
					}
					if(pt_id_set.size() > 0) {
						Integer[] pt_id_arr = pt_id_set.toArray(new Integer[pt_id_set.size()]);
						sql = "planType.pt_id in (4)";
						return getScrollList(0, 8, sql, null);
					}
				}
			}
		}

		return null;
	}

	private PaginationQuery createPaginationQuery(PlanInfoVo vo) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from E_PlanInfo where 1 = 1");
		int i = 1;
		if(vo != null) {
			if(!ValidateUtil.isEmpty(vo.getPi_name())) {
				jpql.append(" and pi_name like ?" + i++);
				paramList.add("%" + vo.getPi_name() + "%");
			}
		}

		jpql.append(" order by pi_name desc");

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((vo.getPage() - 1) * vo.getRows()).setMaxResults(vo.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(pi_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		return new PaginationQuery(rQuery, cQuery);
	}*/
}
