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
                  { text: '新增', iconCls: 'icon-add',handler:addDriver,permitParams:'${pert:hasperti(applicationScope.afficheadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updDriver,permitParams:'${pert:hasperti(applicationScope.afficheupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delDriver,permitParams:'${pert:hasperti(applicationScope.affichedel, loginModel.xdlimit)}'}, '-',              
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true, 
				url:"<%=basePath%>Main/driver/getGridData"
				<%-- /**,
				onDblClickRow:function(rowIndex, rowData) {
			        //打开详情页面
			        $("#driverViewDialog").dialog({
			            title : '公告详情',
			            width : 800,
			            height : 380,
			            cache : false,
			            modal : true,
			            href : "<%=basePath%>Main/affiche/view/" + rowData.ID,
			            buttons : []
			        });
		        }  */ --%>
        };
		$.lauvan.dataGrid("driverGrid",attrArray);
		
	});
	function affiche_doSearch(){
		$('#driverGrid').datagrid('load',{
			title:$('#titleid').val(),
			username:$('#usernameid').val(),
			createtime:$('#createtimeid').datebox('getValue')	
		});	
	}
	function addDriver(){
		var attrArray={
				title:'新增司机',
				height: 300,
				width:650,
				href: '<%=basePath%>Main/driver/add'
		};
		
		$.lauvan.openCustomDialog("driverDialog",attrArray,driver_addSubmit,'driver_form');	
	}
	function updDriver(){
		var node = $("#driverGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改司机信息',
				height: 300,
				width:650,
				href: '<%=basePath%>Main/driver/edit/'+node.ID
		};
		$.lauvan.openCustomDialog("driverDialog",attrArray,driver_editSubmit,'driver_form');
	}
	
	function driver_addSubmit(){
  		$('#driver_form').form('submit',{
  			onSubmit:function(param){				
  			var title=$('#atitleid').textbox('getValue');	
  			var content=document.getElementById("acontentid").value;	
  			if(title==""||content==""){
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
	function driver_editSubmit(){
  		$('#affiche_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#utitleid').textbox('getValue');
  				var content=document.getElementById("ucontentid").value;		
  	  			if(title==""||content==""){
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
	function delDriver(){
		var nodes= $("#driverGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请勾选欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/affiche/del?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#afficheGrid").datagrid('clearSelections');
	            			$("#afficheGrid").datagrid('clearChecked');
	            			$("#afficheGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
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
	
	
		
	function sendAdd_dialogSubmit(){
		$("#affiche_form").attr("action","<%=basePath%>Main/affiche/send");
		$('#affiche_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#atitleid').textbox('getValue');
  				var content=document.getElementById("acontentid").value;		
  	  			if(title==""||content==""){
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
	
	function sendUdp_dialogSubmit(){  
		$("#affiche_form").attr("action","<%=basePath%>Main/affiche/send");
		$('#affiche_form').form('submit',{
  			onSubmit:function(param){
  				var title=$('#utitleid').textbox('getValue');
  				var content=document.getElementById("ucontentid").value;		
  	  			if(title==""||content==""){
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
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>姓名:</span>
		<input id="usernameid" type="text" class="easyui-textbox" data-options="icons:iconClear">			
		<a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="affiche_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="driverGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="100">姓名</th> 
			            <th field="SEX" width="100">性别</th> 
			            <th field="TYPE" width="100">准驾车型</th>	
			            <th field="TEL" width="200">联系电话</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
	<div id="driverViewDialog"></div>
