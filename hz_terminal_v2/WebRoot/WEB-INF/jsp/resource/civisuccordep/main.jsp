<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	
	$(function(){
		var attrArray={
				idField:'DEPTID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加组织', iconCls: 'icon-add',
								dialogParams:{dialogId:'civilDialog', href:'<%=basePath%>Main/civisuccordep/add', 
								width:800, height:580, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改组织',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'civilDialog',href:'<%=basePath%>Main/civisuccordep/edit',width:800,
									height:580,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该组织及其下属人员和装备信息吗？',delParams:{url:'<%=basePath%>Main/civisuccordep/delete'}}, '-',
						  {text :'查看', iconCls:'icon-eye', title:'查看组织', tabid:'civitabs',url:'<%=basePath%>Main/civisuccordep/view',handler:'viewFn'}

						],
				url:"<%=basePath%>Main/civisuccordep/getGridData",
				onDblClickRow: function(rowIndex, rowData){
					viewFn();
				}
			};
		$.lauvan.dataGrid("civil_data",attrArray);
	//	var html = $("#civi_tb").html();
	//	$("#civi_tb").empty();
	//	$(html).prependTo("#civi_box .datagrid-toolbar table tbody tr");
	
	});

	function viewFn(){
		var title = '查看组织';
		var mainTab = $("#mainTab");
		var row = $("#civil_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			return;
		}
		var url = "<%=basePath%>Main/civisuccordep/view/" + row.DEPTID;
		if(mainTab.tabs('exists', title)){//如果查看组织详情的tab已经打开
			mainTab.tabs('select', title); //选中tab
			mainTab.tabs('getSelected').panel('refresh', url); //刷新tab

		}else{
			//新建查看组织详情的tab
			mainTab.tabs('add', {
				title: title,
				href: url,
				iconCls: 'icon-eye',
				closable: true

			});
		}
	}

	function civiSearch(){
		$("#civil_data").datagrid('load',{
			civiname: $("#civiname").val()
			});
	}

	function civiAdd(){
		var param = {
				title:'添加组织',
				href:'<%=basePath%>Main/civisuccordep/add',
				width:800, 
				height:580
			};
		$.lauvan.openCustomDialog("civilDialog", param, null, "form1");
	}

	function civiEdit(){
		var row = $("#civil_data").datagrid('getSelected');
		if(!row){
			$.lanvan.MsgShow({msg:"请选择要修改的记录！"});
			return;
		}
		
		var param = {
				title:'修改组织',
				href:'<%=basePath%>Main/civisuccordep/edit/'+row.DEPTID,
				width:800, 
				height:580
			};
		$.lauvan.openCustomDialog("civilDialog", param, null, "form1");
	}

	function civiDel(){
		var rows = $("#civil_data").datagrid('getChecked');
		if(rows.length<=0){
			$.lauvan.MsgShow({msg:'请选择要删除的数据!'});
			return;
		}
		var idArr = "";
		for(var i=0; i<rows.length; i++){
			idArr += "," + rows[i].DEPTID;
		}
		idArr = idArr.substring(1);
		$.messager.confirm('删除', '您确定要删除选择的数据吗？', function(r){
			if(r){
				$.post('<%=basePath%>Main/civisuccordep/delete',{ids:idArr}, function(data){
					if(data.success){
						$.lauvan.MsgShow({msg:'数据删除成功'});
            			$("#civil_data").datagrid('reload');
					}else{
						$.messager.alert('错误',data.msg,data.errorcode);
					}
				});
			}
		});
		

	}

	//查找部门
	function findbusorg(){
		var param = {
			title:'选择部门',
			width:600,
			height:500,
			href:'<%=basePath%>Main/emsperson/getBusOrg',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#orgGrid").datagrid("getSelected");
					$("#equdeptid").val(row.OR_ID);
					$("#equdeptname").textbox('setValue', row.OR_NAME);
					$("#orgDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#orgDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("orgDialog", param, null, null);
	
	}
	</script>

 <div id="civi_box" class="easyui-layout"  data-options="fit:true">
 		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
				<span >组织名称：</span>
				<input id="civiname" type="text" class="easyui-textbox"/>
				<a href="javascript:civiSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="civil_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">名称</th> 
			            <th field="ORGSORTID" width="100">类别</th>
			            <th field="ORGDUTYMAIL" width="100">责任人邮箱</th> 
			            <th field="ORGDUTYFAX" width="100">责任人传真</th> 
			            <th field="ORGFUNC" width="100" >宗旨</th> 
			            <th field="DUTY" width="100">任务</th> 
			            <th field="ICON" width="100">徽标</th> 
			            <th field="ORGDUTYNAME" width="100">责任人</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

