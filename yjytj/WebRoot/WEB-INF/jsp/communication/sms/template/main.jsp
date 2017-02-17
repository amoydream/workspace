<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '添加',title:'添加短信模板', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'smsTempDialog',href:basePath+"Main/smsTemp/add",width:700,
						height:200,formId:'smsTempform',isNoParam:true}}, '-', 
                  { text: '修改',title:'编辑短信模板',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'smsTempDialog',href:basePath+"Main/smsTemp/edit",width:700,
								height:200,formId:'smsTempform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/smsTemp/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/smsTemp/getDataGrid"
		};
		$.lauvan.dataGrid("smsTempGrid",attrArray);
		});

	
	function smstemp_doSearch(){
		$('#smsTempGrid').datagrid('load',{
			scontent: $('#scontent_temp').val()
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>短信内容：</span>
			<input id="scontent_temp" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smstemp_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="smsTempGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="CONTENT" width="150">短信模板内容</th> 
			            <th field="USERNAME" width="100"  >创建人</th>
			            <th field="UPTIME" width="150" >创建时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

