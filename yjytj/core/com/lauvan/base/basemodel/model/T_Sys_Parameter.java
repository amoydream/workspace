package com.lauvan.base.basemodel.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_sys_parameter",pk="id")
public class T_Sys_Parameter extends Model<T_Sys_Parameter> {
	private static final long serialVersionUID = 1L;
	public static final T_Sys_Parameter dao = new T_Sys_Parameter();
	
	/**
	 * 根据ids查询字典表中ids组的所有下级
	 * @param  ids 查询ids数组
	 * @return
	 * */
	public List<T_Sys_Parameter> getChildList(String ids){
		String sql = "select  * from t_sys_parameter where sup_id in ("+ids+")";
		return dao.find(sql);
	}
	
	/**
	 * 根据ids删除ids数组的所有下级以及本身
	 * @param  ids ids数组
	 * @return
	 * */
	public boolean deleteByIds(String ids){
		String sql ="delete from t_sys_parameter where sup_id in ("+ids+") or id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	/**
	 * 插入字典记录
	 * @param  t 字段model
	 * @return
	 * */
	public boolean insert(T_Sys_Parameter t){
		t.set("id", AutoId.nextval(t));
		return t.save();
	}
	
	/**
	 * 根据父级acode获取所有下级
	 * @param  acode 父级参数编码
	 * @return
	 * */
	public List<T_Sys_Parameter> getChildByAcode(String acode){
		String sql = "select  p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p2.p_acode='"+acode+"' order by p1.id asc ";
		return dao.find(sql);
	}
	
	/**
	 * 根据父级参数编码，以及参数编码，判断系统参数是否存在
	 * @param  		acode		参数编码
	 * @param  		facode		父级参数编码
	 * @return	 
	 * */
	
	public boolean isExist(String acode,String facode){
		boolean flag = false;
		String sql = "select p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p1.p_acode='"
					+acode+"' and p2.p_acode='"+facode+"'";
		T_Sys_Parameter p = dao.findFirst(sql);
		if(p!=null){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 根据父级参数编码，以及参数编码，获取参数
	 * @param  		aname		参数名称
	 * @param  		facode		父级参数编码
	 * @return	 
	 * */
	
	public T_Sys_Parameter getByCode(String aname,String facode){
		String sql = "select p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p1.p_name='"
					+aname+"' and p2.p_acode='"+facode+"'";
		return dao.findFirst(sql);
	}
	
	public List<T_Sys_Parameter> getByStartCode(String aname,String facode){
		String sql = "select p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p1.p_name like '"
					+aname+"\\_%' Escape '\\'  and p2.p_acode='"+facode+"'";
		return dao.find(sql);
	}
	/**
	 * 根据父级参数编码，以及子集参数编码，获取子集参数
	 * @param  		aname		参数名称
	 * @param  		facode		父级参数编码
	 * @return	 
	 * */
	
	public T_Sys_Parameter getByCode2(String acode,String facode){
		String sql = "select p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p1.p_acode='"
					+acode+"' and p2.p_acode='"+facode+"'";
		return dao.findFirst(sql);
	}
	
	/**
	 * 根据参数编码，获取参数
	 * @param  		aname		参数名称
	 * @return	 
	 * */
	
	public T_Sys_Parameter getByCode3(String acode){
		String sql = "select p1.* from t_sys_parameter p1 where  p1.p_acode='"
					+acode+"' ";
		return dao.findFirst(sql);
	}
	
	/**
	 * 根据参数编码，循环获取该编码下的所有下级(暂时只针对oracle)
	 * @param  		code		参数编码
	 * @param  		flag		是否包含当前参数
	 * @return	
	 * */
	public List<Record> getParamByCode(String code,boolean flag){
		String	sql = "select a.* from t_sys_parameter a ";
		if(!flag){
			sql = sql + "where  a.p_acode<>'"+code+"'";
		}
		sql = sql+" Start With a.p_acode=? Connect By  Prior a.id = a.sup_id ";
		return Db.find(sql, code);
	}
	/**
	 * 根据父级参数编码，以及子集参数编码，获取子集参数
	 * @param  		aname		参数名称
	 * @param  		facode		父级参数编码
	 * @return	 
	 * */
	
	public String getByCodeValue(String aname,String facode){
		String sql = "select p1.* from t_sys_parameter p1,t_sys_parameter p2 where p1.sup_id=p2.id and p1.p_name='"
					+aname+"' and p2.p_acode='"+facode+"'";
		T_Sys_Parameter t = dao.findFirst(sql);
		if(t!=null){
		return t.getStr("p_acode");
		}else{
			return null;
		}
	}
	
	/**
	 * 根据父级ID，获取子树列表(暂时只针对oracel)
	 * @param  		pid		父级ID
	 * */
	public List<Record> getChildTree(String pid){
		String sql ="select p.*,case when (select count(a.id) from t_sys_parameter a where a.sup_id=p.id)>0"
					+" then 1 else 0 end as isleaf  from t_sys_parameter p  Start With p.sup_id="+pid
					+"  Connect By  Prior p.id = p.sup_id order by p.p_acode asc ";
		return Db.find(sql);
	}
	/**
	 * 循环删除父节点下的所有子节点
	 * @param  		pids		父级ID组
	 * */
	public void deleteAllChildren(String pids){
		String sql = "select wmsys.wm_concat(p.id) from t_sys_parameter p where p.sup_id in ("+pids
				+") and (select count(a.id) from t_sys_parameter a where a.sup_id=p.id)>0";
		String ids = Db.queryStr(sql);
		if(ids!=null && !"".equals(ids)){
			deleteAllChildren(ids);
		}
		String delsql = "delete from t_sys_parameter where sup_id in ("+pids+")";
		Db.update(delsql);
	}
	
	/**
	 * 根据id查询字典表中id的所有下级
	 * @param  id 查询id
	 * @param  flag 业务字段标志
	 * @param  swhere 查询条件
	 * @param  sflag 查询标志
	 * @return
	 * */
	public Page<Record> getChildPage(Integer pageSize,Integer pageNumber,String id,String flag,String swhere,String searchid,String sflag){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer  str = new StringBuffer();
		
		if(searchid!=null && !"".equals(searchid)){
			str.append("  from (select a.* from t_sys_parameter a where a.id<>"+searchid+" Start With a.id="+searchid
					+" Connect By  Prior a.id = a.sup_id  ) p where 1=1 ");
		}else{
			str.append("  from t_sys_parameter p where 1=1");
		}
		if(!"search".equals(sflag) && id!=null && !"".equals(id)){
			str.append(" and  p.sup_id= "+id);
		}
		if(flag!=null && !"".equals(flag)){
			str.append(" and p.ptype='"+flag+"' ");
		}
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p_acode asc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	/***
	 * 根据id组，获取id组里面的所有父级ID
	 * */
	public String getSupids(String ids){
		StringBuffer str = new StringBuffer();
		String sql = "select p.sup_id from t_sys_parameter p where p.id in ("+ids+") group by p.sup_id";
		List<Record> list = Db.find(sql);
		if(list!=null && list.size()>0){
			for(Record r : list){
				if(str.length()>0){
					str.append(",");
				}
				str.append(r.get("sup_id").toString());
			}
		}
		return str.length()>0?str.toString():"";
	}
	/**
	 * 根据id修改其子集的所有参数状态，循环修改参数类型
	 * @param	id	父级参数
	 * @param	ptype	参数类型00B为业务参数
	 * */
	public void updateType(String id,String ptype){
		String sql = "select wmsys.wm_concat(p.id) from t_sys_parameter p where p.sup_id in ("+id
		+") and (select count(a.id) from t_sys_parameter a where a.sup_id=p.id)>0";
		String ids = Db.queryStr(sql);
		if(ids!=null && !"".equals(ids)){
			updateType(ids,ptype);
		}
		String sql2 = "update t_sys_parameter p set p.ptype='"+ptype+"' where sup_id in("+id+")";
		Db.update(sql2);	
	}
	
	public void updateTypeIds(String id,String ptype){
		String sql2 = "update t_sys_parameter p set p.ptype='"+ptype+"' where id in("+id+")";
		Db.update(sql2);	
	}
	
	/**
	 * 根据ids获取参数列表
	 * */
	public List<Record> getListByIDS(String ids){
		String sql = "select * from t_sys_parameter where id in ("+ids+") order by id asc ";
		return Db.find(sql);
	}
}
