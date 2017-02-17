package com.lauvan.apps.workcontact.model;

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob 系统内部组织机构和人员通讯录
 */
@TableBind(name = "t_bus_contactbook", pk = "bo_id")
public class T_Bus_ContactBook extends Model<T_Bus_ContactBook> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_ContactBook	dao					= new T_Bus_ContactBook();

	/**
	 * 根据外键用户id获取信息
	 *
	 * @param user_id
	 *            用户id
	 * @return
	 */
	public T_Bus_ContactBook getBookByUserId(BigDecimal user_id) {
		return dao.findFirst("select * from t_bus_contactbook where bo_userid=?", user_id);
	}

	/**
	 * 根据外键部门id获取信息
	 *
	 * @param d_id
	 *            部门id
	 * @return
	 */
	public T_Bus_ContactBook getBookByDepartId(BigDecimal d_id) {
		return dao.findFirst("select * from t_bus_contactbook where bo_deptid=?", d_id);
	}

	/**
	 * 根据通讯录ids，获通讯录与关联用户列表
	 *
	 * @param ids
	 *            IDs
	 * */
	public Page<Record> getBookAndUserPage(Integer pageSize, Integer pageNumber, String ids) {
		String select = "select * ";
		StringBuffer str = new StringBuffer();
		str.append("from t_bus_contactbook b ");
		if(ids != null && !"".equals(ids)) {
			str.append(" ,t_sys_user u where b.bo_userid=u.user_id and b.bo_id in(" + ids + ")");
		}
		str.append(" order by b.bo_id desc");
		return Db.paginate(pageNumber, pageSize, select, str.toString());
	}

	/**
	 * 删除通讯录
	 *
	 * @param ids
	 *            通讯录id
	 * @return
	 */
	public boolean delete(Integer[] ids) throws Exception {
		try {
			boolean flag = false;
			for(Integer id : ids) {
				if(id != null) {
					flag = dao.deleteById(id);
				}
			}
			return flag;
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}

	/**
	 * 删除组织机构通讯录
	 *
	 * @param ids
	 *            组织机构id
	 * @return
	 */
	public boolean deleteForDepart(Integer[] ids) throws Exception {
		try {
			boolean flag = false;
			for(Integer id : ids) {
				T_Sys_Department depart = T_Sys_Department.dao.findById(id);
				T_Bus_ContactBook book = dao.getBookByDepartId(depart.getBigDecimal("D_ID"));
				if(book != null) {
					book.delete();
					flag = true;
				}
			}
			return flag;
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}

	/**
	 * 获取应急人员通讯信息列表
	 */
	public Page<Record> getUserPage(Integer pageSize, Integer pageNumber, String sqlWhere, String orderName, String sortOrder) {
		String select = "select u.user_id,u.user_name, b.*,decode(b.bo_position,null,null,(";
		select += "select to_char(wmsys.wm_concat(a1.p_name)) from ";
		select += "(select * from t_sys_parameter start with  p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 ";
		select += "where ','||b.bo_position||',' like '%,'||a1.p_acode||',%' ";
		select += ")) as emposition ";
		String sqlExceptSelect = "from t_sys_user u left join t_bus_contactbook b on b.bo_userid = u.user_id where " + (StringUtils.isNotBlank(sqlWhere) ? sqlWhere : "1=1");
		if(StringUtils.isNotBlank(orderName)) {
			sqlExceptSelect += " order by " + orderName;
			if(StringUtils.isNotBlank(sortOrder)) {
				sqlExceptSelect += " " + sortOrder;
			}
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}

}
