package com.lauvan.resource.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.resource.service.ExpertTypeService;
import com.lauvan.system.vo.TreeVo;

@Service("expertTypeService")
public class ExpertTypeServiceImpl extends BaseDAOSupport<R_Expert_Type> 
implements ExpertTypeService{
	
	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<R_Expert_Type> ts = getListIsNull("ext_Pid");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Expert_Type t : ts) {
				treeVo = new TreeVo(t.getExt_Name(),t.getExt_Id().toString());
				treeVo.setNodes(getms(t.getExt_Id()));
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
		List<R_Expert_Type> ts = findByProperty("ext_Pid", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ts.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (R_Expert_Type t : ts) {
				treeVo = new TreeVo(t.getExt_Name(),t.getExt_Id().toString());
				treeVo.setNodes(getms(t.getExt_Id()));
				treeVos.add(treeVo);
			}
		}
		return treeVos;
	}

}
