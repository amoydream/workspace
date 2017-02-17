<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var eleId = 2;
		var attrArray={
				idField:'EGP_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加组成员', iconCls: 'icon-add',
								dialogParams:{dialogId:'exgroupPerDialog', href:'<%=basePath%>Main/expertgroupper/add/${exgroup.eg_id}', 
								width:700, height:560, formId:'perAdd', isNoParam:true,permitParams:'${pert:hasperti(applicationScope.exgroupperAdd, loginModel.xdlimit)}'}}, '-',
						  { text: '修改', title:'修改组成员',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'exgroupPerDialog',href:'<%=basePath%>Main/expertgroupper/edit',width:700,
									height:560,formId:'perEdit'},permitParams:'${pert:hasperti(applicationScope.exgroupperEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/expertgroupper/delete'},permitParams:'${pert:hasperti(applicationScope.exgroupperDel, loginModel.xdlimit)}'}

						],
				url:"<%=basePath%>Main/expertgroupper/getGridData/${exgroup.eg_id}"
			};
		$.lauvan.dataGrid("exgroupPerGrid",attrArray);
	});
	
	function findExpert(){
		var param = {
			title:'选择专家',
			width:600,
			height:500,
			href:'<%=basePath%>Main/expert/getExpert',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#selectExpertGrid").datagrid("getSelected");
					$("#expertid").val(row.EX_ID);
					$("#expertname").textbox('setValue', row.NAME);
					$("#selectDialog").dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$("#selectDialog").dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("selectDialog", param, null, null);
	}

	</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'center',border:false">
			<table id="exgroupPerGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="EGP_ID" data-options="hidden:true">ID</th> 
			            <th field="NAME" width="100">专家姓名</th>
			            <th field="EGP_POSITION" width="200">组中职务</th> 
			            <th field="EGP_REMARK" width="200">备注</th>   
			        </tr> 
			    </thead> 
			</table> 
			</div>
			</div>

