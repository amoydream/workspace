<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
</style>
	<script>
	$(function(){
		var nowOption = {
			fitColumns: true,
			toolbar:[],
			url:"<%=basePath%>Main/happenrate/getGridData?sdate=${sdate}&edate=${edate}&occurarea=${occurarea}"
			//url:null
		};

		var lastOption = {
				fitColumns: true,
				toolbar:[],
				//url:null
				url:"<%=basePath%>Main/happenrate/getGridData?sdate=${lastsdate}&edate=${lastedate}&occurarea=${occurarea}"
			};

		$.lauvan.dataGrid("nowlist", nowOption);

		$.lauvan.dataGrid("lastlist", lastOption);
		
	});

	</script>
	
	<div style="border:3px solid #A4D3EE;border-radius:10px;margin-top:5px;height:43%;">
	<div style="padding-left:10px;background-color:#A4D3EE;font-size:14px;font-weight:bold;">本期</div>
	<div style="width:100%;height:92%;">
	<table id="nowlist" cellspacing="0" cellpadding="0" width="100%">
		<thead>
			<tr>
				  <th field="EV_NAME" width="100">事件标题</th> 
				  <th field="EV_DATE" width="100">接报时间</th> 
				  <th field="TYPENAME" width="100">事件类型</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
	<div style="border:3px solid #A4D3EE;border-radius:10px;margin-top:5px;height:43%;">
	<div style="padding-left:10px;background-color:#A4D3EE;font-size:14px;font-weight:bold;">上年同期</div>
	<div style="width:100%;height:92%;">
	<table id="lastlist" cellspacing="0" cellpadding="0" width="100%">
		<thead>
			<tr>
				  <th field="EV_NAME" width="100">事件标题</th> 
				  <th field="EV_DATE" width="100">接报时间</th> 
				  <th field="TYPENAME" width="100">事件类型</th> 
			</tr>
		</thead>
	</table>
		</div>
		</div>

