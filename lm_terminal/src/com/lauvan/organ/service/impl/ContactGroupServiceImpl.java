package com.lauvan.organ.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.organ.entity.T_Contact_Group;
import com.lauvan.organ.service.ContactGroupService;
import com.lauvan.system.vo.TreeVo;

@Service("contactGroupService")
public class ContactGroupServiceImpl extends BaseDAOSupport<T_Contact_Group> implements ContactGroupService {
	@Override
	public TreeVo tree() {
		List<T_Contact_Group> result = getListEntitys();

		TreeVo tree = new TreeVo("常用联系人", "0");
		List<TreeVo> nodes = new ArrayList<TreeVo>();
		tree.setNodes(nodes);
		if(result.size() > 0) {
			for(T_Contact_Group r : result) {
				TreeVo treeVo = new TreeVo(r.getName(), r.getId().toString());
				tree.getNodes().add(treeVo);
			}
		}

		return tree;
	}
}
