<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#havetodo_tb',
				/* toolbar: [
                  { text: '详情', iconCls: 'icon-search',handler:todoview,permitParams:'${pert:hasperti(applicationScope.todoview, loginModel.xdlimit)}'}
                 ], */
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/todo/gethaveGridData",
				onDblClickRow :todoview
        };
		$.lauvan.dataGrid("havetodoGrid",attrArray);
		
	});
	function havetodo_doSearch(){
		$('#havetodoGrid').datagrid('load',{
			htname: $('#htname').val(),
			htcode: $('#htcode').val()
			
		});	
	}
	function todoview(){
		var node= $("#havetodoGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲办结的记录!'});
			return;
		}
			var attrArray={
					title:'事宜详情',
					width:600,
					height:500,
					href: '<%=basePath%>Main/todo/todoview/'+node.ID+"-"+node.TYPE,
					buttons:[{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				$("#needtodoGrid").datagrid('reload');
				$("#viewDialog").dialog('close');
			}
		}
					         ]
			}; 
			$.lauvan.openCustomDialog("viewDialog",attrArray,null,null);
	}
	function type(value,row,index){
		var cc=value;
		if(cc=='001'){
			cc="事宜";
		}else if(cc=='002'){
			cc="公文";
		}else if(cc=='003'){
			cc="交接班";
		}
		return cc;
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<!-- <span>事宜编号:</span>
		<input id="htcode" type="text" class="easyui-textbox" > -->
		<span>事宜名称:</span>
		<input id="htname" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="havetodo_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="havetodo_tb">
		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="todoview()" data-options="iconCls:'icon-search',plain:true">详情</a>
		</div> -->
		
			<table id="havetodoGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="200">事宜名称</th> 
			            <th field="CONTENT" width="500">事宜内容</th>
			            <th field="TYPE" width="100" formatter="type">类型</th>
			             <th field="RECEIVERNAME" width="200">接收人</th>
			             <th field="USER_NAME" width="100">记录人</th> 
			             <th field="RECORDTIME" width="200">记录时间</th> 
			            <th field="NOTE" width="300">备注</th> 	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
