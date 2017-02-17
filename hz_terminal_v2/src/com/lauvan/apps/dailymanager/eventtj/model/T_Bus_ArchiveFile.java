package com.lauvan.apps.dailymanager.eventtj.model;
/**
 * 归档文件实体类
 * */
import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_archivefile",pk="id")
public class T_Bus_ArchiveFile extends Model<T_Bus_ArchiveFile> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_ArchiveFile dao = new T_Bus_ArchiveFile();
	
	public Page<Record> getPageList(Integer pageSize, Integer pageNumber,
			String sqlwhere ){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select f.*";
		StringBuffer str = new StringBuffer();
		str.append("  from t_bus_archivefile f where 1=1");
		if(sqlwhere !=null && !"".equals(sqlwhere)){
			str.append(sqlwhere);
		}
		str.append(" order by f.archivetype asc,f.marktime desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public List<Record> getFileByType(String type,String ids){
		String sql = "select f.* from vw_archivefiles f where f.atype='"+type+"' and f.arcid in ("+ids+") "
					+ " order by f.marktime desc";
		return Db.find(sql);
	}
	
	/*public List<Record> getFileByType(String table,String column,String ids){
		String sql = "select f.* from (select "+column+" from "+table+")f where f.id in ("+ids+")";
		return Db.find(sql);
	}
	
	public List<Record> getFileByType(String type,String ids){
		T_Sys_Parameter pa = T_Sys_Parameter.dao.getByCode(type, "GDFL");
		if(pa!=null){
			String remark = pa.getStr("remark");
			String[] str = remark.split(";");
			StringBuffer column = new StringBuffer();
			String table = "";
			for(int i=0;i<str.length;i++){
				if(str[i].indexOf(":")>=0){
					String[] c = str[i].split(":");
					if(column.length()>0){
						column.append(",");
					}
					column.append(c[0]).append(" as ").append(c[1]);
				}else{
					table = str[i];
				}
			}
			String sql = "select f.* from (select "+column+" from "+table+")f where f.id in ("+ids+")";
			return Db.find(sql);
		}else{
			return null;
		}
	}
	
	public Page<Record> getPageListByType(Integer pageSize, Integer pageNumber,
			String sqlwhere,String table ,String column){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select f.*";
		StringBuffer str = new StringBuffer();
		str.append("  from ");
		//组装查询内容
		str.append(" (select ").append(column).append(" from ").append(table).append(" )");
		str.append(" f where 1=1");
		if(sqlwhere !=null && !"".equals(sqlwhere)){
			str.append(sqlwhere);
		}
		str.append(" order by f.marktime desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}*/
	
	public Page<Record> getPageListByType(Integer pageSize, Integer pageNumber,
			String sqlwhere,String type ){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select f.*";
		StringBuffer str = new StringBuffer();
		str.append("  from vw_archivefiles f");
		str.append("  where  f.atype='").append(type).append("' ");
		if(sqlwhere !=null && !"".equals(sqlwhere)){
			str.append(sqlwhere);
		}
		str.append(" order by f.marktime desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public void insert(T_Bus_ArchiveFile t){
		t.set("id", AutoId.nextval(t));
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}
	
	public void deleteByAid(String aid){
		String sql = "delete from t_bus_archivefile where archiveid="+aid;
		Db.update(sql);
	}
	
	public List<Record> getListByAid(String aid,String type){
		String sql = "select * from t_bus_archivefile where archiveid="+aid;
		if(type!=null && !"".equals(type)){
			sql = sql + " and archivetype='"+type+"'";
		}
		sql = sql + " order by marktime desc ";
		return Db.find(sql);
	}
	
	public List<T_Bus_ArchiveFile> getListByIds(String ids){
		String sql = "select * from t_bus_archivefile where id in ("+ids+")";
		return dao.find(sql);
	}
	
	public boolean deleteByIds(String ids){
		String sql = "delete from t_bus_archivefile where id in ("+ids+")";
		return Db.update(sql)>0;
	}
	
	public Record getFileByIdType(String id,String atype){
		String sql = "select * from vw_archivefiles where arcid="+id+" and atype='"+atype+"'";
		return Db.findFirst(sql);
	}
	
	public T_Bus_ArchiveFile getByName(String name,String arcid,String atype){
		String sql = "select * from t_bus_archivefile where name='"+name+"' and archiveid="+arcid
					+" and archivetype='"+atype+"'";
		return dao.findFirst(sql);
	}
}
