<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">
	$(function(){
		var attrArray={
				toolbar: '#opelog_tb',
				fitColumns : true,
				idField:'ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/logmg/getopeGridData"
        };
		$.lauvan.dataGrid("opelogGrid",attrArray);
		
	});
	
	function opelog_doSearch(){
		$('#opelogGrid').datagrid('load',{
			name: $('#name').val(),
			type: $('#type').combobox('getValue'),
			status: $('#status').combobox('getValue')
		});
	}
	function type(value,row,index){
		var cc = value;
		if(cc=="1"){
			cc="新增";
		}else if(cc=="2"){
			cc="修改";
		}else if(cc=="3"){
			cc="删除";
		}else{
			cc="其他";
		}
		return cc;
	}
	function status(value,row,index){
		var cc = value;
		if(cc=="1"){
			cc="成功";
		}else{
			cc="失败";
		}
		return cc;
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="opelog_tb">
		<span>操作用户名:</span>
		<input id="name" type="text" class="easyui-textbox" >
		<span>操作类型:</span>
		<select id="type" class="easyui-combobox" style="width:100px;" panelHeight="auto" data-options="editable:false,icons:iconClear">
		<option value=""></option> 
        <option value="1">新增</option> 
        <option value="2">修改</option>
        <option value="3">删除</option>
        <option value="4">其他</option>
        </select>
        <span>操作状态:</span>
		<select id="status" class="easyui-combobox" style="width:100px;" panelHeight="auto" data-options="editable:true,icons:iconClear">
		<option value=""></option> 
		<option value="1">成功</option>
        <option value="0">失败</option> 
        </select> 
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="opelog_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		
			<table id="opelogGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="USER_NAME" width="100">登录用户</th> 
			            <th field="LOGIN_IP" width="150">登录机器IP</th> 
			            <th field="OPT_TYPE" width="100" formatter="type">操作类型</th>
			            <th field="MNAME" width="250">操作模块</th> 
			            <th field="OPT_TIME" width="150">操作时间</th>
			            <th field="STATUS" width="100" formatter="status">操作状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
