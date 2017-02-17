<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">
	$(function(){
		var attrArray={
				toolbar: '#loginlog_tb',
				fitColumns : true,
				idField:'ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/logmg/getloginGridData"
        };
		$.lauvan.dataGrid("loginlogGrid",attrArray);
		
	});
	
	function loginlog_doSearch(){
		$('#loginlogGrid').datagrid('load',{
			name: $('#name').val(),
			type: $('#type').combobox('getValue')
		});
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="loginlog_tb">
		<span>登陆用户名:</span>
		<input id="name" type="text" class="easyui-textbox" >
		<span>登陆类型:</span>
		<select id="type" class="easyui-combobox" style="width:100px;" panelHeight="auto" data-options="editable:false,icons:iconClear">
		<option value=""></option> 
        <option value="正常">正常</option> 
        <option value="注销">注销</option>
        </select> 
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="loginlog_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		
			<table id="loginlogGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="USER_NAME" width="100">登录用户</th> 
			            <th field="LOGINIP" width="250">登录机器IP</th> 
			            <th field="LOGINTYPE" width="100">登录类型</th> 
			            <th field="LOGINTIME" width="200">登录时间</th> 
			            <th field="LOGOUTTIME"  width="200" >退出时间</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
