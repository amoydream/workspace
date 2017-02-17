package com.lauvan.resource.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Supplies_Type;
import com.lauvan.resource.service.SuppliesTypeService;
import com.lauvan.system.vo.TreeVo;

@Service("suppliesTypeService")
public class SuppliesTypeServiceImpl extends BaseDAOSupport<R_Supplies_Type> 
implements SuppliesTypeService{
	
	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<R_Supplies_Type> ts = getListIsNull("ty_Pid");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Supplies_Type t : ts) {
				treeVo = new TreeVo(t.getTy_Name(),t.getTy_Id().toString());
				treeVo.setNodes(getms(t.getTy_Id()));
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
		List<R_Supplies_Type> ts = findByProperty("ty_Pid", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Supplies_Type t : ts) {
				treeVo = new TreeVo(t.getTy_Name(),t.getTy_Id().toString());
				treeVo.setNodes(getms(t.getTy_Id()));
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
		List<R_Supplies_Type> ts = findByProperty("ty_Pid", id);
		for (R_Supplies_Type t : ts) {
			delete(t.getTy_Id());
			getList(t.getTy_Id());
		}
	}
	
}
