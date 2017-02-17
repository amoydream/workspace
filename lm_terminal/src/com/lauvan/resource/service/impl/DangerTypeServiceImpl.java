package com.lauvan.resource.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Danger_Type;
import com.lauvan.resource.service.DangerTypeService;
import com.lauvan.system.vo.TreeVo;

@Service("dangerTypeService")
public class DangerTypeServiceImpl extends BaseDAOSupport<R_Danger_Type> 
implements DangerTypeService{
	
	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<R_Danger_Type> ts = getListIsNull("dt_Pid");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Danger_Type t : ts) {
				treeVo = new TreeVo(t.getDt_Name(),t.getDt_Id().toString());
				treeVo.setNodes(getms(t.getDt_Id()));
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
		List<R_Danger_Type> ts = findByProperty("dt_Pid", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Danger_Type t : ts) {
				treeVo = new TreeVo(t.getDt_Name(),t.getDt_Id().toString());
				treeVo.setNodes(getms(t.getDt_Id()));
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
		List<R_Danger_Type> ts = findByProperty("dt_Pid", id);
		for (R_Danger_Type t : ts) {
			delete(t.getDt_Id());
			getList(t.getDt_Id());
		}
	}

}
