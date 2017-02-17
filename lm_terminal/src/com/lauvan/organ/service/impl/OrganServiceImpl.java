package com.lauvan.organ.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.service.OrganService;
import com.lauvan.organ.vo.OrganVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.ValidateUtil;

@Service("organService")
@SuppressWarnings("unchecked")
public class OrganServiceImpl extends BaseDAOSupport<C_Organ> implements
	OrganService {

	public List<TreeVo> tree() {
		List<C_Organ> os = getListNullParent();
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if(os.size() > 0) {
			treeVos = new ArrayList<TreeVo>();
			for(C_Organ o : os) {
				treeVo = new TreeVo(o.getOr_name(), o.getOr_id().toString());
				treeVo.setNodes(getms(o.getOr_id()));
				treeVos.add(treeVo);
			}
		}

		return treeVos;
	}

	/**
	 * 递归查找
	 * 
	 * @param id
	 * @return
	 */
	public List<TreeVo> getms(Integer id) {
		List<C_Organ> os = findByProperty("organ.or_id", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if(os.size() > 0) {
			treeVos = new ArrayList<TreeVo>();
			for(C_Organ o : os) {
				treeVo = new TreeVo(o.getOr_name(), o.getOr_id().toString());
				treeVo.setNodes(getms(o.getOr_id()));
				treeVos.add(treeVo);
			}
		}

		return treeVos;
	}

	public void deleteAll(Integer id) {
		getList(id);
		delete(id);
	}

	protected void getList(Integer id) {
		List<C_Organ> ms = findByProperty("organ.or_id", id);
		for(C_Organ m : ms) {
			delete(m.getOr_id());
			getList(m.getOr_id());
		}
	}

	@Override
	public List<C_Organ> findByPid(Integer pid) {
		return getResultList(" from C_Organ where organ.or_id = " + pid + " order by organ.or_sort,or_sort");
	}

	@Override
	public List<C_Organ> listAll() {
		List<C_Organ> list = new ArrayList<>();
		list.addAll(getResultList(" from C_Organ where organ is null"));
		list.addAll(getResultList(" from C_Organ where organ is not null order by organ.or_sort,or_sort"));
		return list;
	}

	@Override
	public List<C_Organ> getListNullParent() {
		return em.createQuery("select o from C_Organ o where o.organ is null order by or_sort").getResultList();
	}

	@Override
	public QueryResult<C_Organ> getOrganPage(OrganVo vo) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from C_Organ where 1 = 1");
		int i = 1;
		if(!ValidateUtil.isEmpty(vo.getPid())) {
			jpql.append(" and organ.or_id = ?" + i++);
			paramList.add(vo.getPid());
		} else if(!ValidateUtil.isEmpty(vo.getOr_name())) {
			jpql.append(" and or_name like ?" + i++);
			paramList.add("%" + vo.getOr_name() + "%");
		}

		jpql.append(" order by organ.or_sort, or_sort");
		Object[] params = paramList.toArray(new Object[paramList.size()]);
		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((vo.getPage() - 1) * vo.getRows()).setMaxResults(vo.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(or_id) " + jpql);
		setQueryParams(cQuery, params);

		QueryResult<C_Organ> queryResult = new QueryResult<C_Organ>();

		queryResult.setResultlist(rQuery.getResultList());
		queryResult.setTotalrecord((long)cQuery.getSingleResult());

		return queryResult;
	}
}
