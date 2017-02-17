<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="js/echarts-all.js"></script>
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/zzsc-demo.css">
<style>
</style>
<script src="js/gauge.min.js"></script>
<script>
function eventHappenSrh(){ //根据指定日期查询
	//修改图表tab路径
	var tab = $("#content");
	var href = tab.panel('options').href;
	var index = href.indexOf('?'); //参数拼接位置
	href = href.substring(0, index);
	var param = "?sdate="+ $("#ratestartdate").datebox('getValue') 
				+ "&edate="+$("#rateenddate").datebox('getValue'); //拼接新路径
	tab.panel('options').href = href + param; //替换路径
	
$("#content").panel('refresh');

}

</script>
	
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
		<span>起始时间：</span>
			<input type="text" name="startdate" id="ratestartdate" value="${sdate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<span>结束时间：</span>
			<input type="text" name="enddate" id="rateenddate" value="${edate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventHappenSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div id="happentab" class="easyui-tabs" data-options="region:'west', split:true" style="width:100%;">
		 <div id="content" title="监测" data-options="href:'<%=basePath%>Main/geology/getChart?sdate=${sdate}&edate=${edate}'"></div>
	</div>
</div>
