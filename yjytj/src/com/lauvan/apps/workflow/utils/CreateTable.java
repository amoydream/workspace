package com.lauvan.apps.workflow.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.plugin.activerecord.Config;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Record;

public class CreateTable {
	public static boolean execute(String sql){
		boolean flag = true;
		Config config = DbKit.getConfig();
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = config.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			flag = false;
		}finally{
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	//数据库连接
	public static List<Record>  executeQuery(String sql){
		Config config = DbKit.getConfig();
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		List<Record> list = new ArrayList<Record>();
		try {
			conn = config.getConnection();
			stmt = conn.createStatement();
			result = stmt.executeQuery(sql);
			int count = result.getMetaData().getColumnCount();
			if(count>=1 && result.next()){
				Record r = new Record();
				for(int i=0;i<count;i++){
					r.set(result.getMetaData().getColumnName(i+1), 
							result.getObject(i+1));
				}
				list.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
