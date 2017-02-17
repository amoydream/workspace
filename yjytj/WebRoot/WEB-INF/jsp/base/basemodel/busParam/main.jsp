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
				                   { text: '添加',title:'新增参数', iconCls: 'icon-add',
					                   dialogParams:{dialogId:'busParamDialog',href:basePath+'Main/busParam/add',
				                	   outerParam:"${root.id}-${ztreename}" ,formId:'busParam_form'}}, '-', 
				                   { text: '修改',title:'参数编辑',iconCls: 'icon-pageedit', 
				                		   handler:function(){
			                		   		var row=$('#'+'${ztreename}'+'_grid').datagrid("getSelected");
					           				if(!row){
					           					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
					           					return;
					           				}
			                		   var dialogDef={
												title:'参数编辑',
												href: basePath+'Main/busParam/edit/'+row.ID+"-${ztreename}"
										};
										$.lauvan.openCustomDialog('busParamDialog',dialogDef,null,'busParam_form');
			                	   	}}, '-',
				                   { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/busParam/delete'}}
				                  ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/busParam/getGridData?pid=${root.id}"
		};
		$.lauvan.dataGrid("${ztreename}_grid",attrArray);
		$('#_'+'${ztreename}'+'_gridsearch').bind('click', function(){    
			$('#'+'${ztreename}'+'_grid').datagrid('load',{
				pname: $('#_pname_grid_'+'${ztreename}').val()
			});   
	    });
		});


	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>参数名称：</span>
			<input id="_pname_grid_${ztreename}" type="text" class="easyui-textbox" >
			<a id="_${ztreename}_gridsearch" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false" >
			<table id="${ztreename}_grid" cellspacing="0" cellpadding="0"> 
						    <thead> 
						        <tr> 
						           <th field="ID" width="100" data-options="hidden:true">ID</th> 
						            <th field="P_NAME" width="250">参数名称</th> 
						            <th field="P_ACODE" width="200" >参数编码</th> 
						            <th field="SUP_ID" width="100" data-options="hidden:true">pID</th> 
						            <th field="REMARK"  width="350" >备注</th> 
						        </tr> 
						    </thead> 
			</table>
		</div>
	</div>

