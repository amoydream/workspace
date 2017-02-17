package com.lauvan.resource.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Legal_Type;
import com.lauvan.resource.service.LegalTypeService;
import com.lauvan.system.vo.TreeVo;

@Service("legalTypeService")
public class LegalTypeServiceImpl extends BaseDAOSupport<R_Legal_Type> 
implements LegalTypeService{
	
	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<R_Legal_Type> ts = getListIsNull("lt_Pid");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Legal_Type t : ts) {
				treeVo = new TreeVo(t.getLt_Name(),t.getLt_Id().toString());
				treeVo.setNodes(getms(t.getLt_Id()));
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
		List<R_Legal_Type> ts = findByProperty("lt_Pid", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Legal_Type t : ts) {
				treeVo = new TreeVo(t.getLt_Name(),t.getLt_Id().toString());
				treeVo.setNodes(getms(t.getLt_Id()));
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
		List<R_Legal_Type> ts = findByProperty("lt_Pid", id);
		for (R_Legal_Type t : ts) {
			delete(t.getLt_Id());
			getList(t.getLt_Id());
		}
	}


}
