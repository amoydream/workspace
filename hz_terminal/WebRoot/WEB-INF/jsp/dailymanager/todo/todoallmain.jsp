<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#todoall_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addtodo,permitParams:'${pert:hasperti(applicationScope.todoadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updtodo,permitParams:'${pert:hasperti(applicationScope.todoupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:deltodo,permitParams:'${pert:hasperti(applicationScope.tododel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,
				url:"<%=basePath%>Main/todo/getallGridData",
				onDblClickRow :todoview
        };
		$.lauvan.dataGrid("todoallGrid",attrArray);
		
	});
	function todoview(){
		var node= $("#todoallGrid").datagrid('getSelected');
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
				$("#todoallGrid").datagrid('reload');
				$("#viewDialog").dialog('close');
			}
		}
					         ]
			}; 
			$.lauvan.openCustomDialog("viewDialog",attrArray,null,null);
	}
	function todoall_doSearch(){
		$('#todoallGrid').datagrid('load',{
			tname: $('#tname').val(),
			tcode: $('#tcode').val()
			
		});	
	}
	function addtodo(){
		var attrArray={
				title:'新增事宜',
				height: 400,
				width:500,
				href: '<%=basePath%>Main/todo/todoadd',
		};
		
		$.lauvan.openCustomDialog("todoDialog",attrArray,todo_dialogSubmit,'todo_form');
		
	}
	function updtodo(){
		var node = $("#todoallGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		if(node.TYPE!='001'){
			$.lauvan.MsgShow({msg:'只能修改类型为“事宜”的事宜！'});
			return;	
		}
		if(node.THINGSTATUS!=0){
			$.lauvan.MsgShow({msg:'只能修改状态为“未办结”的事宜！'});
			return;		
		}
		var attrArray={
				title:'修改事宜',
				height: 400,
				width:600,
				href: '<%=basePath%>Main/todo/todoupd/'+node.ID+"-"+node.TYPE
		};
		$.lauvan.openCustomDialog("todoDialog",attrArray,todo_dialogSubmit,'todo_form');
	}
	function deltodo(){
    	//var node= $("#todoallGrid").datagrid('getSelected');
    	var nodes= $("#todoallGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
    		if(nodes[i].TYPE=='001'&&nodes[i].THINGSTATUS==1){
			 ids=ids+nodes[i].ID+",";
    		}
			 }
    	ids=ids.substring(0,ids.length-1);
    	if(ids==""){
    	$.lauvan.MsgShow({msg:'只能删除类型为“事宜”且状态为“办结”的事宜!'});
		return;		
    	}
		/* if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		if(node.TYPE!='001'){
			$.lauvan.MsgShow({msg:'只能删除类型为“事宜”的事宜！'});
			return;	
		}
		if(node.THINGSTATUS!=1){
			$.lauvan.MsgShow({msg:'只能删除状态为“办结”的事宜！'});
			return;		
		} */
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/todo/tododel/'+node.ID,
	            	url:'<%=basePath%>Main/todo/tododel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#todoallGrid").datagrid('clearSelections');
	            			$("#todoallGrid").datagrid('clearChecked');
	            			$("#todoallGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function todo_dialogSubmit(){
  		$('#todo_form').form('submit',{
  			onSubmit:function(param){
  			var event_id=document.getElementById("event_id").value;
  			var todoname=$('#todoname').textbox('getValue');
  			var userid=document.getElementById("userid").value;
  			var todocontent=document.getElementById("todocontent").value; 			
  			if(event_id==""||todoname==""||userid==""||todocontent==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				} 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function finduser(){
		var attrArray={
				title:'选择接班人',
				width:600,
				height:500,
				href: '<%=basePath%>Main/workhandover/getUsers',
				buttons:[
	{
		text:'确定',
		iconCls:'icon-save',
		handler:function(){
			var userid="";
			var name="";
			var node = $("#usersGrid").datagrid('getSelected');
			userid=node.USER_ID;
			name=node.USER_NAME;	
			document.getElementById('userid').value=userid;
			$("#username").textbox('setValue',name);
			$("#userDialog").dialog('close');
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#userDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("userDialog",attrArray,null,null);
	}
	//获取所有事件
	function findevent(){
		var attrArray={
				title:'选择事件',
				width:600,
				height:500,
				href: '<%=basePath%>Main/todo/getEvents',
				buttons:[
	{
		text:'确定',
		iconCls:'icon-save',
		handler:function(){
			var event_id="";
			var name="";
			var node = $("#eventGrid").datagrid('getSelected');
			event_id=node.ID;
			name=node.EV_NAME;	
			document.getElementById('event_id').value=event_id;
			$("#event_name").textbox('setValue',name);
			$("#eventDialog").dialog('close');
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#eventDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("eventDialog",attrArray,null,null);
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
		<input id="tcode" type="text" class="easyui-textbox" > -->
		<span>事宜名称:</span>
		<input id="tname" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="todoall_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		<!-- <div id="todoall_tb">
		<a href="javascript:void(0);" onclick="addtodo()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a  href="javascript:void(0);" onclick="updtodo()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:void(0);" onclick="deltodo()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
		
			<table id="todoallGrid"   cellspacing="0" cellpadding="0" width="100%"> 
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
