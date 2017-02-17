package com.lauvan.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_Module_Info;
import com.lauvan.system.service.ModuleInfoService;
import com.lauvan.system.vo.TreeVo;

/**
 * @describe 系统功能模块service层实现类
 * @author 陈存登
 * @version 1.0 30-11-2015
 */
@Service("moduleInfoService")
public class ModuleInfoServiceImpl extends BaseDAOSupport<T_Module_Info> implements ModuleInfoService {
	/**
	 * 菜单树
	 */
	public List<TreeVo> tree() {
		List<T_Module_Info> ms = getListIsNull("mo_Pid");
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (T_Module_Info m : ms) {
				treeVo = new TreeVo(m.getMo_Name(),m.getMo_Id().toString());
				treeVo.setNodes(getms(m.getMo_Id()));
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
		List<T_Module_Info> ms = findByProperty("mo_Pid", id);
		List<TreeVo> treeVos = null;
		TreeVo treeVo = null;
		if (ms.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			for (T_Module_Info m : ms) {
				treeVo = new TreeVo(m.getMo_Name(),m.getMo_Id().toString());
				treeVo.setNodes(getms(m.getMo_Id()));
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
		List<T_Module_Info> ms = findByProperty("mo_Pid", id);
		for (T_Module_Info m : ms) {
			delete(m.getMo_Id());
			getList(m.getMo_Id());
		}
	}
	
	
	@Override
	public List<T_Module_Info> findByAttr(String attr, int step) {
        List<T_Module_Info> moduleInfo = findByProperty(attr, step);
		return moduleInfo;
	}
	
	

}
