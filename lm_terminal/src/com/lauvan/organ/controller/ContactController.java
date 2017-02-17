package com.lauvan.organ.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.T_Contact_Group;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.service.ContactGroupService;
import com.lauvan.organ.service.ContactService;
import com.lauvan.organ.service.OrganService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.organ.vo.ContactVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;

@Controller
@RequestMapping("contact/")
public class ContactController extends BaseController {
	@Autowired
	private ContactService		contactService;

	@Autowired
	private ContactGroupService	contactGroupService;

	@Autowired
	private OrganService		organService;

	@Autowired
	private PositionService		positionService;

	@Autowired
	private Properties			config;

	@RequestMapping("search")
	@ResponseBody
	public Json search(ContactVo vo, @ModelAttribute("userVo") UserInfoVo userVo) {
		try {
			if(vo == null) {
				vo = new ContactVo();
			}
			if(vo.getPage() == null || vo.getPage() < 1) {
				vo.setPage(1);
			}
			if(vo.getRows() < 1) {
				vo.setRows(8);
			}
			PageView<ContactVo> pageView = new PageView<ContactVo>(vo.getRows(), vo.getPage());
			if(!StringUtils.isEmpty(vo.getGroup_id())) {
				T_Contact_Group g = contactGroupService.find(vo.getGroup_id());
				if(g != null) {
					vo.setContactIds(g.getContactIds());
				}
			}
			QueryResult<ContactVo> result = contactService.getContacts(vo);
			List<ContactVo> voList = result.getResultlist();
			for(ContactVo c : voList) {
				c.setP_names(positionService.getPositionNames(c.getPe_poids()));
			}

			pageView.setQueryResult(result);
			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	@RequestMapping("groupsearch/{group_id}/{page}")
	@ResponseBody
	public Json groupSearch(@PathVariable Integer group_id, @PathVariable Integer page) {
		try {
			ContactVo vo = new ContactVo();
			vo.setGroup_id(group_id);
			vo.setPage(page);
			vo.setRows(8);
			PageView<ContactVo> pageView = new PageView<ContactVo>(vo.getRows(), vo.getPage());
			if(!StringUtils.isEmpty(vo.getGroup_id())) {
				T_Contact_Group g = contactGroupService.find(vo.getGroup_id());
				if(g != null) {
					vo.setContactIds(g.getContactIds());
				}
			} else {
				return json(false, "分组不存在");
			}
			QueryResult<ContactVo> result = contactService.getContacts(vo);
			List<ContactVo> voList = result.getResultlist();
			for(ContactVo c : voList) {
				c.setP_names(positionService.getPositionNames(c.getPe_poids()));
			}

			pageView.setQueryResult(result);
			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	@RequestMapping("savegroup")
	@ResponseBody
	public Json saveGroup(ContactVo vo) {
		try {
			T_Contact_Group group = contactGroupService.find(vo.getGroup_id());
			if(group == null) {
				return json(false, "分组不存在");
			} else {
				group.setContactIds(vo.getContactIds());
				contactGroupService.update(group);
				return json(true, "添加成功");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "操作失败");
		}
	}

	@RequestMapping("creategroup/{group_name}")
	@ResponseBody
	public Json createGroup(@PathVariable String group_name) {
		try {
			T_Contact_Group group = contactGroupService.findEntity("name", group_name);
			if(group == null) {
				group = new T_Contact_Group();
				group.setName(group_name);
				contactGroupService.save(group);
				group = contactGroupService.findEntity("name", group_name);
				return json(true, "分组创建成功", group.getId());
			} else {
				return json(false, "分组已存在");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "操作失败");
		}
	}

	@RequestMapping("deletegroup/{group_id}")
	@ResponseBody
	public Json deleteGroup(@PathVariable Integer group_id) {
		try {
			T_Contact_Group group = contactGroupService.find(group_id);
			if(group == null) {
				return json(false, "分组不存在");
			} else {
				contactGroupService.delete(group_id);
				return json(true, "分组已删除");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "操作失败");
		}
	}

	@RequestMapping("deletecontacts")
	@ResponseBody
	public Json deleteContacts(ContactVo vo) {
		try {
			T_Contact_Group group = contactGroupService.find(vo.getGroup_id());
			if(group == null) {
				return json(false, "分组不存在");
			} else {
				String contactIds = group.getContactIds();
				if(contactIds != null && contactIds.length() > 0) {
					Set<String> idSet = new HashSet<>();
					String[] idArr = contactIds.split(",");
					for(String contact_id : idArr) {
						idSet.add(contact_id);
					}
					idArr = vo.getContactIds().split(",");
					for(String contact_id : idArr) {
						idSet.remove(contact_id);
					}

					idArr = idSet.toArray(new String[idSet.size()]);
					contactIds = StringUtils.collectionToDelimitedString(idSet, ",");
					group.setContactIds(contactIds);
					contactGroupService.update(group);
				}
				return json(true, "删除成功");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "操作失败");
		}
	}

	@RequestMapping("export")
	@ResponseBody
	public Json export() {
		String rootDir = config.getProperty("contact_export_dir");
		FileOutputStream fos = null;
		HSSFWorkbook workbook = null;
		try {
			File dir = new File(rootDir);
			if(!dir.exists()) {
				dir.mkdir();
			} else if(!dir.isDirectory()) {
				dir.delete();
				dir = new File(rootDir);
				dir.mkdir();
			}
			List<V_Contact> list = contactService.getAllMobileContacts();
			if(list != null && list.size() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String timestamp = sdf.format(Calendar.getInstance().getTime());
				File file = new File(rootDir + "/contacts_" + timestamp + ".xls");
				file.createNewFile();
				fos = new FileOutputStream(file);
				workbook = new HSSFWorkbook();
				HSSFSheet sheet = workbook.createSheet("龙门应急办通讯录");
				for(int i = 0; i < list.size(); i++) {
					V_Contact c = list.get(i);
					HSSFRow row = sheet.createRow(i);
					HSSFCell tel_mobile = row.createCell(0);
					tel_mobile.setCellType(HSSFCell.CELL_TYPE_STRING);
					tel_mobile.setCellValue(c.getTel_mobile());
					HSSFCell pe_name = row.createCell(1);
					pe_name.setCellType(HSSFCell.CELL_TYPE_STRING);
					pe_name.setCellValue(c.getPe_name());
				}
				workbook.write(fos);
				fos.flush();
				return json(true, "已导出到 " + file.getAbsolutePath());
			}
			return json(false, "未导出任何数据");
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		} finally {
			if(fos != null) {
				try {
					fos.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(workbook != null) {
				try {
					workbook.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@RequestMapping("contactree")
	@ResponseBody
	public List<Object> contactTree() {
		List<Object> bookTree = new ArrayList<Object>();
		TreeVo groupTree = contactGroupService.tree();
		List<TreeVo> organTree = organService.tree();

		if(groupTree != null) {
			setTreeName(groupTree, "group");
		} else {
			groupTree = new TreeVo();
		}
		if(organTree != null) {
			for(TreeVo treeVo : organTree) {
				setTreeName(treeVo, "organ");
			}
		}

		bookTree.add(groupTree);
		bookTree.add(organTree);
		return bookTree;
	}

	@RequestMapping("grouptree")
	@ResponseBody
	public TreeVo groupTree() {
		TreeVo groupTree = contactGroupService.tree();

		if(groupTree == null) {
			groupTree = new TreeVo();
		}

		return groupTree;
	}

	private void setTreeName(TreeVo tree, String name) {
		if(tree != null) {
			tree.setName(name);
			List<TreeVo> nodes = tree.getNodes();
			if(nodes != null) {
				for(TreeVo node : nodes) {
					setTreeName(node, name);
				}
			}
		}
	}
}
