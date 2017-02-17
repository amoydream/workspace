<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#mobileuser_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addmobileuser,permitParams:'${pert:hasperti(applicationScope.mobileuseradd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updmobileuser,permitParams:'${pert:hasperti(applicationScope.mobileuserupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delmobileuser,permitParams:'${pert:hasperti(applicationScope.mobileuserdel, loginModel.xdlimit)}'}, '-',
                  { text: '发送记录',iconCls: 'icon-search',handler:searchTaskList,permitParams:'${pert:hasperti(applicationScope.sendlist, loginModel.xdlimit)}'},'-',
                  { text: '发送信息',iconCls: 'icon-folderup',handler:sendTaskList,permitParams:'${pert:hasperti(applicationScope.sendtask, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/mobileuser/getGridData",
				onDblClickRow:userview
        };
		$.lauvan.dataGrid("mobileuserGrid",attrArray);
		
	});
	function mobileuser_doSearch(){
		$('#mobileuserGrid').datagrid('load',{
			mobileusername: $('#mobileusername').val(),
			mobileuserrealname: $('#mobileuserrealname').val()
			
		});	
	}
	function addmobileuser(){
		var attrArray={
				title:'新增终端用户',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/mobileuser/useradd',
		};
		
		$.lauvan.openCustomDialog("mobileuserDialog",attrArray,mobileuser_addSubmit,'mobileuser_form');	
	}
	function updmobileuser(){
		var node = $("#mobileuserGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改终端用户',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/mobileuser/userupd/'+node.ID
		};
		$.lauvan.openCustomDialog("mobileuserDialog",attrArray,mobileuser_editSubmit,'mobileuser_form');
	}
	function userview(){
		var node = $("#mobileuserGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'终端用户详情',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/mobileuser/getUserView/'+node.ID,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#mobileuserGrid").datagrid('reload');
						$("#mobileuserDialog").dialog('close');
					}
				}
							         ]
		};
		$.lauvan.openCustomDialog("mobileuserDialog",attrArray,null,null);
	}
	function mobileuser_addSubmit(){
  		$('#mobileuser_form').form('submit',{
  			onSubmit:function(param){
  			var mbrealname=$('#mbrealname').textbox('getValue');
  			var mbusername=$('#mbusername').textbox('getValue');
  			var mbpassword=$('#mbpassword').textbox('getValue');			
  			if(mbrealname==""||mbusername==""||mbpassword==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}
  			var reg = new RegExp("^[0-9]{11}$");
  			if(!reg.test(mbusername)){
  				$.messager.alert('错误','用户名必须为11为数字的号码，请检查！','error');
                return false;
  			}
  			
  			if(!flagUserAdd){
  				$.messager.alert('提示','已存在该用户名，请检查！','info');
  				return false;
  			 }
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function mobileuser_editSubmit(){
  		$('#mobileuser_form').form('submit',{
  			onSubmit:function(param){
  			var mbrealname=$('#mbrealname').textbox('getValue');
  			var mbusername=$('#mbusername').textbox('getValue');
  			var mbpassword=$('#mbpassword').textbox('getValue');			
  			if(mbrealname==""||mbusername==""||mbpassword==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}
  			var reg = new RegExp("^[0-9]{11}$");
  			if(!reg.test(mbusername)){
  				$.messager.alert('错误','用户名必须为11为数字的号码，请检查！','error');
                return false;
  			}

  			if(!flagUserEdit){
  				$.messager.alert('提示','已存在该用户名，请检查！','info');
  				return false;
  			 }
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function delmobileuser(){
    	/* var node= $("#mobileuserGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#mobileuserGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/mobileuser/userdel/'+node.ID,
	            	url:'<%=basePath%>Main/mobileuser/userdel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#mobileuserGrid").datagrid('clearSelections');
	            			$("#mobileuserGrid").datagrid('clearChecked');
	            			$("#mobileuserGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function option(value,row,index){
		var id=row.ID;
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=\"sendtask("+id+")\">发送信息</a></li></ul>";
	return act;	
	}
	function sendtask(id){
		var attrArray={
				title:'发送任务',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/mobileuser/sendtask?ids='+id,
				buttons: [{
					text:'发送',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
					sendtasktom_dialogSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#sendtasktomDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("sendtasktomDialog",attrArray,sendtasktom_dialogSubmit,'sendtasktom_form');	
	}
	
	function sendTaskList(){
		var rows= $("#mobileuserGrid").datagrid('getChecked');
		var ids="";
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请勾选需要发送的终端用户!'});
			return;
		}
		for (var i = 0; i < rows.length; i++) {
			 ids=ids+rows[i].ID+",";
			 }
   	     ids=ids.substring(0,ids.length-1);	
		var attrArray={
				title:'发送任务',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/mobileuser/sendtask?ids='+ids,
				buttons: [{
					text:'发送',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
					sendtasktom_dialogSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#sendtasktomDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("sendtasktomDialog",attrArray,sendtasktom_dialogSubmit,'sendtasktom_form');	
		
	}
	
	function sendtasktom_dialogSubmit(){  
		  $('#sendtasktom_form').form('submit',{
  			onSubmit:function(param){
  			var sendtasktitle=$('#sendtasktitle').textbox('getValue');	
  			var pointx=$('#pointx').textbox('getValue');	
  			var pointy=$('#pointy').textbox('getValue');	
  			var sendtaskcontent=document.getElementById("sendtaskcontent").value;	
  			if(sendtasktitle==""||pointx==""||pointy==""||sendtaskcontent==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}
		       $("#sendtaskButid").linkbutton('disable');
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	
	function searchTaskList(){
		var node= $("#mobileuserGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲查询的终端用户 ！'});
			return;
		}
		var attrArray={
				title:'发送记录',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/mobileuser/getTaskView/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("taskDialog",attrArray,null,null);
	}
	
	function showBackList(rowIndex, rowData){
		var attrArray={
				title:'反馈信息',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/mobileuser/getTaskBack/'+rowData.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("taskBackViewDialog",attrArray,null,null);
		
		<%-- 	$("#taskBackViewDialog").dialog({
				title:'任务详情',
				width: 800,
				height: 380,
				cache: false,
			    modal: true,
				href: '<%=basePath%>Main/mobileuser/taskview/'+rowData.ID,
				buttons: []
			});	 --%>
	} 
	
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>用户名:</span>
		<input id="mobileusername" type="text" class="easyui-textbox" >
		<span>姓名:</span>
		<input id="mobileuserrealname" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="mobileuser_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="mobileuser_tb">
		
		<a href="javascript:void(0);" onclick="addmobileuser()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a  href="javascript:void(0);" onclick="updmobileuser()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:void(0);" onclick="delmobileuser()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
		
			<table id="mobileuserGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="USERNAME" width="200">用户名</th> 
			            <th field="DEPPOSNAME" width="400">职位</th>
			             <th field="OPTION" formatter="option" width="200">操作</th> 
			             	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
