<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">
	//时间格式转换
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	   "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
	 };   
	 if(/(y+)/.test(fmt))   
	   fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	   if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	}
	$(function(){
		var attrArray={
				//toolbar: '#givenworkmg_tb',
				toolbar: [
                  { text: '新增交班信息', iconCls: 'icon-add',handler:addgivenworkmg,permitParams:'${pert:hasperti(applicationScope.givenworkadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改交班信息',iconCls: 'icon-pageedit',handler:updgivenworkmg,permitParams:'${pert:hasperti(applicationScope.givenworkupd, loginModel.xdlimit)}'}, '-',
                  { text: '新增值班纪要信息', iconCls: 'icon-add',handler:addgivenwork,permitParams:'${pert:hasperti(applicationScope.addgivenwork, loginModel.xdlimit)}'}, '-',
                  { text: '值班清单', iconCls: 'icon-print',handler:dutyDocView},'-',
                  { text: '删除',iconCls: 'icon-delete',handler:delgivenworkmg,permitParams:'${pert:hasperti(applicationScope.givenworkdel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				view: detailview,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/workhandover/getgivenGridData/g",
				onDblClickRow :workmgview,
				 detailFormatter:function(index,row){
				return '<div style="padding:2px"><table id="wh-' + row.ID + '"></table></div>';
			},
			onExpandRow: function(index,row){
				$('#wh-'+row.ID).datagrid({
					url:'<%=basePath%>Main/workhandover/getgivenGridDataview?id='+row.ID,
					fitColumns:true,
					singleSelect:true,
					rownumbers:true,
					loadMsg:'',
					height:'auto',
					columns:[[
						{field:'EVENTNAME',title:'事件名称',width:200},
						{field:'D_NAME',title:'事发单位',width:200},
						{field:'CONTENT',title:'基本信息',width:300},
						{field:'TYPE',title:'类型',width:200},
						{field:'MARKTIME',title:'纪要时间',width:300},
						{field:'operation',title:'操作',formatter:function operation(value,row,index){
							var id=row.ID;
							var type=row.TYPE;
							var cc="";
							if(row.GETDUTY==null){
							cc="<table width=\"100%\"><tr><td width=\"15%\"><a href=\"javascript:void(0);\" onclick=\"workview("+id+")\">详情</a></td><td  width=\"5%\">/</td><td width=\"15%\"><a href=\"javascript:void(0);\" onclick=\"updgivenwork("+id+",'"+type+"')\">修改</a></td><td  width=\"5%\">/</td><td  width=\"15%\"><a href=\"javascript:void(0);\" onclick=\"delgivenwork("+id+",'"+type+"')\">删除</a></td></tr></table>";
							}else{
							cc="<table width=\"100%\"><tr><td width=\"100%\"><a href=\"javascript:void(0);\" onclick=\"workview("+id+")\">详情</a></td></tr></table>";
							}
							return cc;
						},width:200}
					]],
					onResize:function(){
						$('#givenworkmgGrid').datagrid('fixDetailRowHeight',index);
					},
					onLoadSuccess:function(){
						setTimeout(function(){
							$('#givenworkmgGrid').datagrid('fixDetailRowHeight',index);
						},0);
					}
				});
				$('#givenworkmgGrid').datagrid('fixDetailRowHeight',index);
			}  
        };
		$.lauvan.dataGrid("givenworkmgGrid",attrArray);
		
	});
	
	function dutyDocView(){
		var node = $("#givenworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择要查看的记录！'});
			return;
		}
		window.open("<%=basePath%>Main/workhandover/getDutyDoc/"+node.ID);
	}
	
	function workview(id){
		var attrArray={
				title:'值班纪要详情',
				height: 400,
				width:700,
				href: '<%=basePath%>Main/workhandover/workview/'+id,
				buttons:[]
		};
		$.lauvan.openCustomDialog("workmgDialog",attrArray,null,null);		
	}
	function workmgview(){
		var node = $("#givenworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择要查看的记录！'});
			return;
		}
		var attrArray={
				title:'交班信息详情',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/workhandover/workmgview/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("workmgDialog",attrArray,null,null);		
}
	function givenworkmg_doSearch(){
		$('#givenworkmgGrid').datagrid('load',{
			givenname: $('#givenname').val(),
			receivename: $('#receivename').val()
			
		});
	}
	function addgivenworkmg(){
		var attrArray={
				title:'新增交班信息',
				height: 550,
				width:600,
				href: '<%=basePath%>Main/workhandover/addgivenworkmg',
		};
		
		$.lauvan.openCustomDialog("givenworkmgDialog",attrArray,givenworkmg_dialogSubmit,'givenworkmg_form');
		
	}
	function addgivenwork(){
		var node = $("#givenworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择要新增纪要的交班信息！'});
			return;
		}
		var attrArray={
				title:'新增值班详细纪要',
				height: 400,
				href: '<%=basePath%>Main/workhandover/addgivenwork/'+node.ID,
		};
		
		$.lauvan.openCustomDialog("givenworkDialog",attrArray,givenwork_dialogSubmit,'givenwork_form');
		
	}
	function updgivenworkmg(){
		var node = $("#givenworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择要修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改交班信息',
				height: 500,
				width:600,
				href: '<%=basePath%>Main/workhandover/updgivenworkmg/'+node.ID
		};
		$.lauvan.openCustomDialog("givenworkmgDialog",attrArray,givenworkmg_dialogSubmit,'givenworkmg_form');
	}
	function updgivenwork(id,type){
			var attrArray={
					title:'修改值班详细纪要',
					height: 550,
					width:600,
					href: '<%=basePath%>Main/workhandover/updgivenwork/'+id
			};			
		$.lauvan.openCustomDialog("givenworkDialog",attrArray,givenwork_dialogSubmit,'givenwork_form');
	}
	function givenworkmg_dialogSubmit(){
  		$('#givenworkmg_form').form('submit',{
  			onSubmit:function(param){
  				var bak=document.getElementById("bak").value;	
  				var type=document.getElementById("type").value;
  				if(type=="add"){
  				var useraccount=document.getElementById("useraccount").value;
  	  			var doccontent=document.getElementById("doccontentid").value;
  	  			var managername=document.getElementById("managername").value;
  	  		     if(useraccount==""){
					$.messager.alert('错误','请选择接班人！','error');
	                return false;	
				}
  	  		    if(managername==""){
					$.messager.alert('错误','请选择值班领导！','error');
	                return false;	
				}
  	  		    
  			    if(bak==""){
  						$.messager.alert('错误','请输入交接事项！','error');
  		                return false;	
  				}	
  	  		    if(doccontent==""){
  	  		    $.messager.alert('错误','请输入公文报送情况！','error');
                return false;	
  	  		    }				
  			   
  			 }
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function givenwork_dialogSubmit(){
  		$('#givenwork_form').form('submit',{
  			onSubmit:function(param){
  				var controltype=$('#controltype').combobox('getValue');
  				var content=document.getElementById("content").value;	
  				if(controltype==""||content==""){
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
			var account="";
			var uid="";
			var name="";
			var mobile = "";
			var node = $("#usersGrid").datagrid('getSelected');
			account=node.USER_ACCOUNT;
			name=node.USER_NAME;
			mobile = node.BO_MOBILE;
			uid=node.USER_ID;
			document.getElementById('useraccount').value=account;
			document.getElementById('receiveid').value=uid;
			$("#telnumberid").textbox('setValue',mobile);
			$("#smsnumberid").textbox('setValue',mobile);
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
	function findmanager(){
		var attrArray={
				title:'选择值班主任',
				width:600,
				height:500,
				href: '<%=basePath%>Main/workhandover/getUsers',
				buttons:[
	{
		text:'确定',
		iconCls:'icon-save',
		handler:function(){
			var account="";
			var uid="";
			var name="";
			var node = $("#usersGrid").datagrid('getSelected');
			name=node.USER_NAME;
			$("#managername").textbox('setValue',name);
			$("#managerDialog").dialog('close');
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#managerDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("managerDialog",attrArray,null,null);
	}
	function findevent(ids){
		var attrArray={
				title:'选择事件',
				width:600,
				height:500,
				href: '<%=basePath%>Main/workhandover/getEvents?eventids='+ids,
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
	function delgivenworkmg(){
    	/* var node= $("#givenworkmgGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择要删除的数据!'});
			return;
		} */
		var nodes= $("#givenworkmgGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择要删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	//url:'<%=basePath%>Main/workhandover/delgivenworkmg/'+node.ID,
	            	url:'<%=basePath%>Main/workhandover/delgivenworkmg?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#givenworkmgGrid").datagrid('clearSelections');
	            			$("#givenworkmgGrid").datagrid('clearChecked');
	            			$("#givenworkmgGrid").datagrid('reload');
	            		}
	            		else{
	            			$("#givenworkmgGrid").datagrid('clearSelections');
	            			$("#givenworkmgGrid").datagrid('clearChecked');
	            			$("#givenworkmgGrid").datagrid('reload');
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function delgivenwork(id,type){
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/workhandover/delgivenwork/'+id,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#givenworkmgGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>交班人:</span>
		<input id="givenname" type="text" class="easyui-textbox" >
		<span>接班人:</span>
		<input id="receivename" type="text" class="easyui-textbox" >		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="givenworkmg_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="givenworkmg_tb">
		
		<a href="javascript:void(0);" onclick="addgivenworkmg()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增交班信息</a>
		<a  href="javascript:void(0);" onclick="updgivenworkmg()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改交班信息</a>
		<a href="javascript:void(0);" onclick="addgivenwork()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增值班详细纪要</a>
		<a href="javascript:void(0);" onclick="delgivenworkmg()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
		
			<table id="givenworkmgGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="GIVERNAME" width="100">交班人</th> 
			            <th field="RECEIVENAME" width="100">接班人</th> 
			            <th field="DUTYDATE" width="200">交班时间</th> 
			            <th field="BAK" width="200">备注</th> 
			            <th field="GETDUTY"  width="200" >接班时间</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
