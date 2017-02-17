<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#needtodo_tb',
				/* toolbar: [
                  { text: '详情', iconCls: 'icon-search',handler:todoview,permitParams:'${pert:hasperti(applicationScope.todoview, loginModel.xdlimit)}'}
                 ], */
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/todo/getneedGridData",
				onDblClickRow :todoview
        };
		$.lauvan.dataGrid("needtodoGrid",attrArray);
		
	});
	function needtodo_doSearch(){
		$('#needtodoGrid').datagrid('load',{
			ntname: $('#ntname').val(),
			ntcode: $('#ntcode').val()
			
		});	
	}
	function todoview(){
		var node= $("#needtodoGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲办结的记录!'});
			return;
		}
		var butpermit = 'false';
		if(node.TYPE!=001){
			butpermit='true';
		}
			var attrArray={
					title:'事宜详情',
					width:600,
					height:500,
					href: '<%=basePath%>Main/todo/todoview/'+node.ID+"-"+node.TYPE,
					buttons:[
		{
			text:'办结事宜',
			iconCls:'icon-save',
			permitParams:butpermit,
			handler:function(){
				$.messager.confirm('办结','您确定办结此事宜吗？',function(r){
				    if (r){
				    $("#makingDialog").dialog('close');
				       $.ajax({
			            	url:'<%=basePath%>Main/todo/todomaking/'+node.ID,
			            	type:'post',
			            	traditional:true,
			            	success:function(data){
			            		if(data.success){
			            			$.lauvan.MsgShow({msg:'事宜办结成功'});
			            			$("#needtodoGrid").datagrid('reload');
			            		}
			            		else{
			            			$.messager.alert('错误',data.msg,data.errorcode);
			            		}
			            	}
			            });
				    }
				});
			}
		},{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				$("#needtodoGrid").datagrid('reload');
				$("#makingDialog").dialog('close');
			}
		}
					         ]
			}; 
			$.lauvan.openCustomDialog("makingDialog",attrArray,null,null);
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
		<input id="ntcode" type="text" class="easyui-textbox" > -->
		<span>事宜名称:</span>
		<input id="ntname" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="needtodo_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="needtodo_tb">
		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="todoview()" data-options="iconCls:'icon-search',plain:true">详情</a>
		</div> -->
		
			<table id="needtodoGrid"   cellspacing="0" cellpadding="0" width="100%"> 
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
