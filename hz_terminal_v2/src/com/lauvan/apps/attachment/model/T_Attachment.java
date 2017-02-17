package com.lauvan.apps.attachment.model;

import java.io.File;
import java.util.Date;
import java.util.List;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_attachment",pk="id")
public class T_Attachment extends Model<T_Attachment> {
	private static final long serialVersionUID = 1L;
	public static T_Attachment dao = new T_Attachment();
	
	public String  insert(T_Attachment t){
		String id = AutoId.nextval(t).toString();
		t.set("id", id);
		t.set("uploaddate", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
		return id;
	}
	
	public List<T_Attachment> getListByIds(String ids){
		String sql = "select * from T_Attachment where id in ("+ids+")";
		return dao.find(sql);
	}
	
	public List<Record> getListRecordByids(String ids){
		String sql = "select t.*,u.user_name as username from T_Attachment t,t_sys_user u where t.uploadid=u.user_id and t.id in ("+ids+") order by t.uploaddate desc";
		return Db.find(sql);
	}
	
	public void deleteByIds(String ids){
		List<T_Attachment> list = getListByIds(ids);
		if(list!=null && list.size()>0){
			for(T_Attachment a : list){
				String url = a.getStr("url");
				if(!url.startsWith("/") && url.indexOf(":")!=1){
					url = PathKit.getWebRootPath() + "/" + url;
				}
				File file = new File(url);
				if(file.exists()){
					file.delete();
				}
			}
			String sql = "delete from T_Attachment where id in ("+ids+")";
			Db.update(sql);
		}
	}
}
