package com.lauvan.apps.web.manager.model;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;

@TableBind(name="t_bus_content", pk="contentid")
public class T_Bus_Content extends Model<T_Bus_Content>{
	
	private static final long serialVersionUID = 1L;
	public static T_Bus_Content dao = new T_Bus_Content();

	public boolean insert(T_Bus_Content c){
		c.set("contentid", AutoId.nextval(c));
		return c.save();
	}
	public Page<Record> getPage(Integer pageSize,Integer pageNumber,Integer channelId,String caption,String sqlWhere,String orderName, String sortOrder){
		StringBuffer str = new StringBuffer();
		String sql = "select con.*,cha.channelname,cha.channelpath,(select url from t_attachment a where a.id=con.imageid) photourl, u.user_account as username ";
		str.append(" from t_bus_content con,t_bus_channel cha, t_sys_user u where con.channelid=cha.channelid and con.releaseuid = u.user_id ");
		
		if(channelId!=0){
			T_Bus_Channel cha=T_Bus_Channel.dao.findById(channelId);
			if(null!=cha){
				str.append(" and con.channelid in (select channelid from t_bus_channel t1 where t1.channelcode like '"+cha.getStr("channelcode")+"%')");
			}else{
				str.append(" and 0=1");
			}
		}
		
		if(null!=caption){
			str.append(" and con.caption like '%"+caption+"%'");
		}
		
		if(null!=sqlWhere && !"".equals(sqlWhere))
			str.append(" and "+sqlWhere);
		
		str.append(" order by ");
		if(null!=orderName){
			str.append(orderName);
		}
		
		if(null!=orderName && null!=sortOrder){
			str.append(" "+sortOrder);
		}
		if( null != orderName){
			str.append(",");
		}
		str.append(" con.releasedate desc,con.contentid desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
	public List<T_Bus_Content> findByT_Bus_Channel(Integer[] T_Bus_ChannelIds){
		if(null==T_Bus_ChannelIds)
			return null;
		
		String sql="select * from t_bus_content where channelid in ("+ArrayUtils.ArrayToString(T_Bus_ChannelIds)+")";
		return dao.find(sql);
	}
	
	@Before(Tx.class)
	public void del(Integer[] ids){
		String idStr =  ArrayUtils.ArrayToString(ids);
		String sql = "select wm_concat(c.imageid) as imgids from t_bus_content c where contentid in (" + idStr + ")";
		String imgids = Db.queryStr(sql);
		if(imgids != null && !"".equals(imgids)){
			T_Attachment.dao.deleteByIds(imgids); //删除对应图片
		}
		sql = "delete from t_bus_content c  where c.contentid in (" + idStr + ")";
		Db.update(sql);
	}
	
	public T_Bus_Content getById(Integer id){
		String sql = "select c.* , a.url as fjurl,c2.channelname from t_bus_content c left join t_attachment a on c.imageid=a.id " +
				"left join t_bus_channel c2 on c.channelid = c2.channelid where c.contentid = "+id;
		return dao.findFirst(sql);
	}
	
}
