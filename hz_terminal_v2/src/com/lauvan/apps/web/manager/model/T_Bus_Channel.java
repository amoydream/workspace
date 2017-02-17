package com.lauvan.apps.web.manager.model;

import java.util.LinkedList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;

@TableBind(name="t_bus_channel", pk="channelid")
public class T_Bus_Channel extends Model<T_Bus_Channel>{

	private static final long serialVersionUID = 1L;
	public static T_Bus_Channel dao = new T_Bus_Channel();

	public boolean insert(T_Bus_Channel c){
		c.set("channelid", AutoId.nextval(c));
		return c.save();
	}
	
	public String getNextChannelCode(Integer parentId){
		
		T_Bus_Channel T_Bus_Channel=dao.findById(parentId);
		String appendNum="1001";
		if(null==T_Bus_Channel && parentId!=0){
			return appendNum;
		}else{
			String sql="select max(channelcode) from t_bus_channel where parentid="+parentId;
			String code=Db.queryStr(sql);
			if(null==code && null!=T_Bus_Channel){
				code=T_Bus_Channel.getStr("channelcode")+appendNum;
			}else{
				if(null == code){
					return appendNum;
				}else{
					int index=code.length()-appendNum.length();
					String preCode=code.substring(0, index);
					String lastCode=code.substring(index);
					code=preCode+(Integer.parseInt(lastCode)+1);
				}
			}
			
			return code;
		}
	}
	
	@Before(Tx.class)
	public void del(Integer[] T_Bus_ChannelIds){
		for(Integer id:T_Bus_ChannelIds){
			List<T_Bus_Content> conList=T_Bus_Content.dao.findByT_Bus_Channel(new Integer[]{id});
			Integer[] conIds=new Integer[conList.size()];
			for(int i=0;i<conIds.length;i++)
				conIds[i]=conList.get(i).getBigDecimal("contentid").intValue();
			if(conIds.length>0)
				T_Bus_Content.dao.del(conIds);
			
			dao.deleteById(id);
		}
	}
	
	public boolean ifExistChildren(Integer[] T_Bus_ChannelIds){
		if(T_Bus_ChannelIds==null){
			return false;
		}
		String sql="select count(*) from t_bus_channel where parentid in ("+ArrayUtils.ArrayToString(T_Bus_ChannelIds)+")";
		return Db.queryBigDecimal(sql).intValue()>0;
	}
	
	public T_Bus_Channel findByPath(String path){
		if(null==path || "".equals(path))
			return null;
		String sql="select * from t_bus_channel where channelpath=?";
		return dao.findFirst(sql, path);
	}
	
	public List<T_Bus_Channel> getNodeList(){
		LinkedList<T_Bus_Channel> list=new LinkedList<T_Bus_Channel>();
		T_Bus_Channel node=this;
		while(node!=null){
			list.addFirst(node);
			node = node.findById(node.get("parentid"));
		}
		return list;
	}

	public List<T_Bus_Channel> getList(String isdisplay, Integer parentid){
		StringBuffer sql = new StringBuffer("select * from t_bus_channel where 1=1 ");
		if(null != isdisplay && !"".equals(isdisplay)){
			sql.append(" and isdisplay = '").append(isdisplay).append("'");
		}
		if(parentid != null){
			sql.append(" and parentid =").append(parentid) ;
		}
		sql.append(" order by priority");
		return dao.find(sql.toString());
	}
	
}
