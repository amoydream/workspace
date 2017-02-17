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
                  { text: '新增', iconCls: 'icon-add',handler:addAffiche,permitParams:'${pert:hasperti(applicationScope.afficheadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updAffiche,permitParams:'${pert:hasperti(applicationScope.afficheupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delAffiche,permitParams:'${pert:hasperti(applicationScope.affichedel, loginModel.xdlimit)}'}, '-',              
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true, 
				url:"<%=basePath%>Main/affiche/getGridData",
				onDblClickRow:function(rowIndex, rowData) {
			        //打开详情页面
			        $("#afficheViewDialog").dialog({
			            title : '公告详情',
			            width : 800,
			            height : 380,
			            cache : false,
			            modal : true,
			            href : "<%=basePath%>Main/affiche/getView/" + rowData.ID,
			            buttons : []
			        });
		        }
        };
		$.lauvan.dataGrid("afficheGrid",attrArray);
		
	});
	
	$.fn.datebox.defaults.cleanText = '清空';

	(function ($) {
	    var buttons = $.extend([], $.fn.datebox.defaults.buttons);
	    buttons.splice(1, 0, {
	        text: function (target) {
	            return $(target).datebox("options").cleanText
	        },
	        handler: function (target) {
	            $(target).datebox("setValue", "");
	            $(target).datebox("hidePanel");
	        }
	    });
	    $.extend($.fn.datebox.defaults, {
	        buttons: buttons
	    });

	})(jQuery)
	
	function affiche_doSearch(){
		$('#afficheGrid').datagrid('load',{
			title:$('#titleid').val(),
			username:$('#usernameid').val(),
			createtime:$('#createtimeid').datebox('getValue')	
		});	
	}
	function addAffiche(){
		var attrArray={
				title:'新增公告',
				height: 300,
				width:650,
				href: '<%=basePath%>Main/affiche/add',
				buttons: [{
					text:'发送',
					iconCls:'icon-ok',
					id : 'sendtaskButid',
					handler:function(){
					  sendAdd_dialogSubmit();
					}
				},{
					text:'保存',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
						affiche_addSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#afficheDialog").dialog('close');
					}
				}]
		};
		
		$.lauvan.openCustomDialog("afficheDialog",attrArray,affiche_addSubmit,'affiche_form');	
	}
	function updAffiche(){
		var node = $("#afficheGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		if(node.STATUS=='1'){
			$.lauvan.MsgShow({msg:'已发送的不支持修改！'});
			return;
		}
		var attrArray={
				title:'修改公告',
				height: 300,
				width:650,
				href: '<%=basePath%>Main/affiche/update/'+node.ID,
				buttons: [{
					text:'发送',
					iconCls:'icon-ok',
					id : 'sendtaskButid',
					handler:function(){
					  sendUdp_dialogSubmit();
					}
				},{
					text:'保存',
					iconCls:'icon-save',
					id : 'sendtaskButid',
					handler:function(){
					  affiche_editSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#afficheDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("afficheDialog",attrArray,affiche_editSubmit,'affiche_form');
	}
	
	function affiche_addSubmit(){
		$("#affiche_form").attr("action","<%=basePath%>Main/affiche/save");
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
	function affiche_editSubmit(){
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
	function delAffiche(){
		var nodes= $("#afficheGrid").datagrid('getChecked');
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
	
	function sendStatus(val,row){
		if(val=='0'){
			return '<span style="color:#EE7621;">已保存</span>';
		}else if(val=='1'){
			return '<span style="color:#3CB371;">已发送</span>';
		}
	}
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>标题:</span>
		<input id="titleid" type="text" class="easyui-textbox" data-options="icons:iconClear">
		<span>发送人姓名:</span>
		<input id="usernameid" type="text" class="easyui-textbox" data-options="icons:iconClear">			
		<span>创建时间:</span>
		<input id="createtimeid" type="text" class="easyui-datebox" data-options="icons:iconClear,editable:false,value:'${now }'">
		<%-- <input id="createtimeid" type="text" class="easyui-combobox" data-options="value:'${now}'"> --%>
		<a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="affiche_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="afficheGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="TITLE" width="230">标题</th> 
			            <th field="USERNAME" width="80">发布人</th>	
			            <th field="CREATETIME" width="100">创建时间</th>
			            <th field="SENDTIME" width="100">发送时间</th>
			            <th field="STATUS" width="80" data-options="formatter:sendStatus">发送状态</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
	<div id="afficheViewDialog"></div>
