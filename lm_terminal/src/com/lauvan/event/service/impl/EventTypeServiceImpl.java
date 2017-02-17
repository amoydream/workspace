package com.lauvan.event.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.event.service.EventTypeService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
@Service("eventTypeService")
public class EventTypeServiceImpl extends BaseDAOSupport<T_Event_Type> implements EventTypeService {
	
	public List<TreeVo> tree() {
		List<T_Event_Type> ets = getListIsNull("eventType");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ets.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (T_Event_Type et : ets) {
				treeVo = new TreeVo(et.getEt_name(),et.getEt_id().toString());
				treeVo.setNodes(getms(et.getEt_id()));
				treeVos.add(treeVo);
			}
		}
		
		return treeVos;
	}
	/**
	 * 递归查找
	 * @param id
	 * @return
	 */
	public List<TreeVo> getms(Integer id) {
		List<T_Event_Type> ets = findByProperty("eventType.et_id", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ets.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (T_Event_Type et : ets) {
				treeVo = new TreeVo(et.getEt_name(),et.getEt_id().toString());
				treeVo.setNodes(getms(et.getEt_id()));
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
		List<T_Event_Type> ms = findByProperty("eventType.et_id", id);
		for (T_Event_Type m : ms) {
			delete(m.getEt_id());
			getList(m.getEt_id());
		}
	}
	
	/**
	 * ztree 树
	 * @return
	 */
	public List<Tree2Vo> tree2() {
		List<T_Event_Type> ms = getListIsNull("eventType");
		List<Tree2Vo> treeVos = null;
		Tree2Vo tree2Vo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<Tree2Vo>();
			for (T_Event_Type m : ms) {
				tree2Vo = new Tree2Vo(m.getEt_id(),m.getEt_name());
				tree2Vo.setChildren(getms2(m.getEt_id()));
				treeVos.add(tree2Vo);
			}
		}
		
		return treeVos;
	}
	
	private List<Tree2Vo> getms2(Integer id) {
		List<T_Event_Type> ms = findByProperty("eventType.et_id", id);
		List<Tree2Vo> treeVos = null;
		Tree2Vo tree2Vo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<Tree2Vo>();
			for (T_Event_Type m : ms) {
				tree2Vo = new Tree2Vo(m.getEt_id(),m.getEt_name());
				tree2Vo.setChildren(getms2(m.getEt_id()));
				treeVos.add(tree2Vo);
			}
		}
		return treeVos;
	}
}
