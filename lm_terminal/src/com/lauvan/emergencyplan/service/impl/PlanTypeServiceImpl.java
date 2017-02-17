package com.lauvan.emergencyplan.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_PlanType;
import com.lauvan.emergencyplan.service.PlanTypeService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
@Service("palnTypeService")
public class PlanTypeServiceImpl extends BaseDAOSupport<E_PlanType> implements
		PlanTypeService {

	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<E_PlanType> ms = getListIsNull("planType");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (E_PlanType m : ms) {
				treeVo = new TreeVo(m.getPt_name(),m.getPt_id().toString());
				treeVo.setNodes(getms(m.getPt_id()));
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
		List<E_PlanType> ms = findByProperty("planType.pt_id", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (E_PlanType m : ms) {
				treeVo = new TreeVo(m.getPt_name(),m.getPt_id().toString());
				treeVo.setNodes(getms(m.getPt_id()));
				treeVos.add(treeVo);
			}
		}
		
		return treeVos;
	}
	/**
	 * ztree 树
	 * @return
	 */
	public List<Tree2Vo> tree2() {
		List<E_PlanType> ms = getListIsNull("planType");
		List<Tree2Vo> treeVos = null;
		Tree2Vo tree2Vo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<Tree2Vo>();
			for (E_PlanType m : ms) {
				tree2Vo = new Tree2Vo(m.getPt_id(),m.getPt_name());
				tree2Vo.setChildren(getms2(m.getPt_id()));
				treeVos.add(tree2Vo);
			}
		}
		
		return treeVos;
	}
	
	private List<Tree2Vo> getms2(Integer id) {
		List<E_PlanType> ms = findByProperty("planType.pt_id", id);
		List<Tree2Vo> treeVos = null;
		Tree2Vo tree2Vo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<Tree2Vo>();
			for (E_PlanType m : ms) {
				tree2Vo = new Tree2Vo(m.getPt_id(),m.getPt_name());
				tree2Vo.setChildren(getms2(m.getPt_id()));
				treeVos.add(tree2Vo);
			}
		}
		return treeVos;
	}
	public void deleteAll(Integer id) {
		getList(id);
		delete(id);
	}
	protected void getList(Integer id){
		List<E_PlanType> ms = findByProperty("planType.pt_id", id);
		for (E_PlanType m : ms) {
			delete(m.getPt_id());
			getList(m.getPt_id());
		}
	}
}
