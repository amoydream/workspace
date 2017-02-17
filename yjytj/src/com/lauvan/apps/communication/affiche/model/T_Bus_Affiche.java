package com.lauvan.apps.communication.affiche.model;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob
 * 终端公告
 */
@TableBind(name="t_bus_affiche",pk="id")
public class T_Bus_Affiche extends Model<T_Bus_Affiche> {
	private static final long serialVersionUID = 1L;
	public static final T_Bus_Affiche dao = new T_Bus_Affiche();
	
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize,String sqlWhere){
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_affiche t where 1=1");
		if(StringUtils.isNotBlank(sqlWhere)){
			str.append(sqlWhere);
		}
		str.append(" order by t.status asc,t.createtime desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	
	
	//查询ids的状态
		public boolean isStatus(String ids,String uid){
			boolean flag = true;
			String sql = "select * from t_bus_affiche where id in ("+ids+") ";
			if(uid!=null && !"".equals(uid)){
				sql = sql +" and userid<> "+uid;
			}
			
			T_Bus_Affiche t = dao.findFirst(sql);
			if(t!=null){
				flag = false;
			}
			return flag;
		}
	
	/**
	 * 删除公告
	 * 
	 * @param ids
	 *            公告id
	 * @return
	 */
	public boolean delete(String[] ids) throws Exception {
		try {
			boolean flag = false;
			for (String id : ids) {
				flag = dao.deleteById(id);
			}
			return flag;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
	}
 
}
