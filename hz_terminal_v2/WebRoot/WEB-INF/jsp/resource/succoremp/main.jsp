<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	var type = "";
	$(function(){
		var attrArray={
				idField:'PERSONID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加志愿者信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'succorempDialog', href:'<%=basePath%>Main/succoremp/add/', 
								width:750, height:560, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改志愿者信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'succorempDialog',href:'<%=basePath%>Main/succoremp/edit',width:750,
									height:560,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/succoremp/delete'}}, '-',
						  {text :'查看', iconCls: 'icon-eye', handler:'succorempView'}

						],
				url:"<%=basePath%>Main/succoremp/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					succorempView();
				}
			};
		$.lauvan.dataGrid("succoremp_data",attrArray);

		//var searchbox = "<td style='padding:0 10px;'>姓名：<input type='text' id='username' class='easyui-textbox' />&nbsp;";
		//searchbox += "<a href='javascript:succorempSearch();' class='easyui-linkbutton' data-options='iconCls:\"icon-search\",plain:true'>查询</a></td>";
		//$(searchbox).prependTo("#succoremp_box .datagrid-toolbar table tbody tr");
	});

	function loadByType(t){
		type = t;
		$("#succoremp_data").datagrid('load',{
			type: t
		});
		var addHref = $("#succoremp_data").datagrid('options').toolbar[0].dialogParams.href;//根据选择的志愿者类型修改添加路径
		var index = addHref.lastIndexOf("/")
		addHref = addHref.substring(0,index+1);
		$("#succoremp_data").datagrid('options').toolbar[0].dialogParams.href = addHref + t;
	}
	function succorempSearch(){
		$("#succoremp_data").datagrid('load',{
			pname:$("#username").val(),
			type:type
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

	function succorempView(){
		var title="查看志愿者详情";
		var mainTab = $("#mainTab");
		var row = $("#succoremp_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var url = "<%=basePath%>Main/succoremp/view/"+ row.PERSONID;
		if(mainTab.tabs('exists', title)){
			mainTab.tabs('select', title);
			mainTab.tabs('getSelected').panel('refresh', url);
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
	</script>
	<div id="succoremp_box" class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',split:true" style="width:200px;">
			<ul class="easyui-tree">
				<li>
					<span>志愿人员分类</span>
					<ul>
						<c:forEach items="${typelist}" var="t">
							<li><a href="javascript:loadByType('${t.p_acode}');" style="text-decoration:none;color:black;"><span>${t.p_name}</span></a></li>
						</c:forEach>
					</ul>
				</li>
			</ul>
		</div>
		<div data-options="region:'center',border:false">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>姓名：</span>
			<input type="text" id="username" class="easyui-textbox" />
			<a href="javascript:succorempSearch();" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
			<table id="succoremp_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="PERSONID" data-options="hidden:true">ID</th> 
			            <th field="PERSONNAME" width="100">姓名</th> 
			            <th field="PERSONBIRTHDAY" width="100">出生年月</th>
			            <th field="PERSONSEX" width="100" CODE="SEX">性别</th> 
			            <th field="PERSONDEPT" width="100">所在单位</th> 
			        </tr> 
			    </thead> 
			</table>
		</div> 
	</div>
