package com.lauvan.apps.workcontact.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob 日常组织机构人员
 */
@TableBind(name = "t_bus_organperson", pk = "p_id")
public class T_Bus_OrganPerson extends Model<T_Bus_OrganPerson> {

	private static final long		serialVersionUID	= 1L;
	public static T_Bus_OrganPerson	dao					= new T_Bus_OrganPerson();

	public Page<Record> getPage(Integer pageSize, Integer pageNumber, String sqlWhere, String orderName, String sortOrder) {
		String select = "select p.*,decode(p.p_position,null,null,(";
		select += "select to_char(wmsys.wm_concat(a1.p_name)) from ";
		select += "(select * from t_sys_parameter start with  p_acode = 'RPOSITION' connect by prior id=sup_id) a1 ";
		select += "where ','||p.p_position||',' like '%,'||a1.p_acode||',%' ";
		select += ")) as rposition ";
		String sqlExceptSelect = "from t_bus_organperson p where " + (StringUtils.isNotBlank(sqlWhere) ? sqlWhere : "1=1");
		if(StringUtils.isNotBlank(orderName)) {
			sqlExceptSelect += " order by " + orderName;
			if(StringUtils.isNotBlank(sortOrder)) {
				sqlExceptSelect += " " + sortOrder;
			}
		}
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}

	/**
	 * 删除机构人员
	 *
	 * @param ids
	 *            人员id
	 * @return
	 */
	public boolean delete(Integer[] ids) throws Exception {
		try {
			boolean flag = false;
			for(Integer id : ids) {
				flag = dao.deleteById(id);
			}
			return flag;
		} catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}

	/**
	 * 根据字符串id 删除机构人员
	 * @param ids
	 */
	public void deleteByIds(String ids) {
		String sql = "delete from t_bus_organperson where p_id in (" + ids + ")";
		Db.update(sql);
	}
	
	/**
	 * 判断该日常用户是否存在
	 * */
	public T_Bus_OrganPerson getByNumber(String worknum,String phone,String fax){
		String sql = "select * from t_bus_organperson where 1=1 ";
		if(worknum!=null && !"".equals(worknum)){
			sql = sql +" and p_worknumber='"+worknum+"'";
		}
		if(phone!=null && !"".equals(phone)){
			sql = sql +" and p_mobile='"+phone+"'";
		}
		if(fax!=null && !"".equals(fax)){
			sql = sql +" and p_fax='"+fax+"'";
		}
		return dao.findFirst(sql);
	}
	
	/**
	 * 判断电话是否已经存在
	 * **/
	public boolean  isExitNumber(String tel){
		boolean flag = false;
		String sql = "select * from v_contact where ','||tel_number||',' like '%,'||"+tel+"||',%'";
		Record r = Db.findFirst(sql);
		if(r!=null){
			flag = true;
		}
		return flag;
	}
}
