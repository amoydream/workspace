package com.lauvan.apps.resource.assets.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_equipstore", pk = "eqs_id")
public class T_Bus_Equipstore extends Model<T_Bus_Equipstore>{

	private static final long serialVersionUID = 5591215954074359182L;
	
	public static final T_Bus_Equipstore dao=new T_Bus_Equipstore();
	
	public Page<Record> getPage(Integer pageSize,Integer pageNum,String typeCode){
		pageNum = pageNum == null || pageNum<1?1:pageNum;
		pageSize = pageSize == null || pageSize<1?JFWebConfig.pageSize:pageSize;
		String select = "select sto.*,equ2.eqn_name,p_id,p_name,unitname,dept.or_name deptname ";
		StringBuffer sql = new StringBuffer("from t_bus_equipstore sto left join ( "
							+" select equ.*,para1.id p_id,para1.p_name,para2.p_name unitname from T_Bus_Equipname equ left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='"+(typeCode.isEmpty()?"":typeCode)+"') para1 on equ.type=para1.id"
							+" left join (select p2.* from t_sys_parameter p1,t_sys_parameter p2 where p1.id=p2.sup_id and p1.p_acode='MAUNIT') para2 on para2.p_acode=equ.measureunit"
							+" ) equ2 on sto.equipnameid=equ2.eqn_id left join t_bus_organ dept on sto.organid=dept.or_id where 1=1");

		return Db.paginate(pageNum, pageSize, select, sql.toString());
	}
	
	public boolean delByIds(Integer[] ids) throws Exception{
		try{
			boolean flag=false;
			for(Integer id:ids){
				flag=dao.deleteById(id);
			}
			return flag;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(e);
		}
	}
	
	public boolean  deleteByIds(String ids){
		String sql = "delete from t_bus_equipstore where eqs_id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public boolean  beNullByEqnIds(String ids){
		String sql = "update t_bus_equipstore set equipnameid = NULL where equipnameid in ("+ids+")";
		return Db.update(sql)>0;
	}

	public T_Bus_Equipstore findByequipnameId(int itemid) {
		String sql="select * from t_bus_equipstore where equipnameid="+itemid;
		return dao.findFirst(sql);
	}
	public List<Record> getListbymatid(Integer itemid) {
		String sql = "select *";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_equipstore e left join t_bus_equipname n on e.equipnameid = n.eqn_id left join t_sys_parameter p on n.type= p.id where e.equipnameid=").append(itemid);
		return Db.find(sql+str.toString());
	}
	public Page<Record> getPagebymatid(Integer pageNum, Integer pageSize,
			Integer itemid) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		// TODO Auto-generated method stub
		String sql = "select *";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_equipstore e left join t_bus_equipname n on e.equipnameid = n.eqn_id left join t_sys_parameter p on n.type= p.id where e.equipnameid=").append(itemid);
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	

}
