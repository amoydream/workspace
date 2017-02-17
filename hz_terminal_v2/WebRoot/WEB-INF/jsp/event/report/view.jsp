<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td >
		    	${t.ev_name}</td>
		    	<td class="sp-td1">事发单位：</td>
		    	<td >
		    		${organ}
		    	</td>
		  		
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td >
		    	${str:translate(t.ev_type,'EVTP')}
		  		</td>
		  		<td class="sp-td1">接报方式：</td>
		    	<td >
		    	${str:translate(t.ev_reportmode,'EVRP')}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事发时间：</td>
		    	<td >
		    	${t.ev_date}
		    	</td>
		    	<td class="sp-td1">接报时间：</td>
		    	<td >
		    	${t.ev_reportdate}
		    	</td>
		    	</tr>
		    	<tr>
		  		
		    	<td class="sp-td1">事发地点：</td>
		    	<td colspan="3">
		    	${t.ev_address}</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		${t.ev_reporter}
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    		${t.ev_reporttel}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="3">
		    		${t.ev_basicsituation}
		    	</td>
		    	</tr>
		    	
	    </table>
   </div>
   </div>
