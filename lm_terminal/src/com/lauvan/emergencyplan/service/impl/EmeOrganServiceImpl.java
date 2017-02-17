package com.lauvan.emergencyplan.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_EmeOrgan;
import com.lauvan.emergencyplan.service.EmeOrganService;
import com.lauvan.system.vo.TreeVo;
@Service("emeOrganService")
public class EmeOrganServiceImpl extends BaseDAOSupport<E_EmeOrgan> implements
		EmeOrganService {

	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<E_EmeOrgan> ms = getListIsNull("organ");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (E_EmeOrgan m : ms) {
				treeVo = new TreeVo(m.getEo_name(),m.getEo_id().toString());
				treeVo.setNodes(getms(m.getEo_id()));
				treeVos.add(treeVo);
			}
		}
		
		return treeVos;
	}
	/**
	 * 递归查询菜单树
	 * @param id
	 * @return
	 */
	public List<TreeVo> getms(Integer id) {
		List<E_EmeOrgan> ms = findByProperty("organ.eo_id", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (E_EmeOrgan m : ms) {
				treeVo = new TreeVo(m.getEo_name(),m.getEo_id().toString());
				treeVo.setNodes(getms(m.getEo_id()));
				treeVos.add(treeVo);
			}
		}
		
		return treeVos;
	}
	
	public void deleteAll(Integer id) {
		getList(id);
		delete(id);
	}
	protected void getList(Integer id){
		List<E_EmeOrgan> ms = findByProperty("organ.eo_id", id);
		for (E_EmeOrgan m : ms) {
			delete(m.getEo_id());
			getList(m.getEo_id());
		}
	}
}
