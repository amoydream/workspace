package com.lauvan.apps.communication.mail.utils;

import java.util.TimerTask;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.DbKit;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_Rece;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;

public class EmailTask extends TimerTask {

	@Override
	public void run() {
		if(DbKit.getConfig() != null) {//判断数据库是否连接上
			//获取邮件附件存放地址
			String path = "upload";
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("FJDZ", "UPDZ");
			if(p != null) {
				path = p.getStr("p_acode");
			}
			if(!path.startsWith("/") && path.indexOf(":") != 1) {
				path = PathKit.getWebRootPath() + "/" + path;
			}
			path = path+"/emailRece";
			//查询接收文件开始数
			Integer seq = T_Bus_Mail_Rece.dao.getMaxSeq();
			//读取邮件
			EmailUtil.receive(seq, path);
			
		}
	}

}
