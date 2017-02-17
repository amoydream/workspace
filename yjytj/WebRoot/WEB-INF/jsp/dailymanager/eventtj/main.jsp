<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		$("#etjtime").combobox('yearandmonth');
		$("#evtjGrid").load(basePath+"Main/eventMonTj/getGridView",{},function(){});
	});
	function etj_export(){
		var etjtime = $('#etjtime').datebox('getValue');
		window.open(basePath+"Main/eventMonTj/export?etjtime="+etjtime);
	}
	
	function etj_doSearch(){
		var etjtime = $('#etjtime').datebox('getValue');
		$("#evtjGrid").load(basePath+"Main/eventMonTj/getGridView",{"etjtime":etjtime},function(){});
		
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>时间：</span>
			<input id="etjtime" type="text" class="easyui-combobox" data-options="value:'${nowtj}'">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="etj_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="etj_export()" data-options="iconCls:'icon-redo',plain:true">导出</a>
		</div>
		<div data-options="region:'center',border:false">
			<div id="evtjGrid"></div>
		</div>
	</div>

