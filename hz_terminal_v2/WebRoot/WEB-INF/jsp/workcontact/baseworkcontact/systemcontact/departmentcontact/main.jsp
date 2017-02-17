<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	$(function(){
		var attrArray={
				toolbar: [
		                    
		                   { text: '编辑通讯信息',title:'编辑通讯信息',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'departDialog',href:'<%=basePath%>Main/systemcontact/contactbook/editForDepart'
					                   ,formId:'form1'},permitParams:'${pert:hasperti(applicationScope.editdepartmentcontact, loginModel.xdlimit)}'}, '-',
					       { text: '删除通讯信息',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/systemcontact/departmentcontact/delete'},permitParams:'${pert:hasperti(applicationScope.deletedepartmentcontact, loginModel.xdlimit)}'}, '-',
					       { text: '导入',iconCls: 'icon-undo',handler: importClick,permitParams:'${pert:hasperti(applicationScope.importdepartcontact, loginModel.xdlimit)}'}
		                  ],
				fitColumns : true,
				idField:'D_ID',    
			    treeField:'D_NAME',
			    pagination:false,
				url:"<%=basePath%>Main/systemcontact/departmentcontact/getGridData"
        };
		$.lauvan.treeGrid("departcontactTree",attrArray);
	});
   
	function importClick(){
		var options=$(this).linkbutton("options");
		var attrArray={
				title:'批量导入应急机构通讯录',
				iconCls:options.iconCls,
				href: '<%=basePath%>Main/systemcontact/departmentcontact/importdepartcontact',
				buttons:[]
		};
		$.lauvan.openCustomDialog("importDialog",attrArray,null);
	}

	
	
	function formatDeptType(val,row){
		if(val=='0')
			val='市';
		else if(val=='1')
			val='区';
		else if(val=='2')
			val='县';
		else if(val=='3')
			val='镇';
		return val;
	}
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=callView('"+row.BO_WORKNUMBER+"') ><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function callView(worknum){
		var attrArray={
				title:'拨打电话',
				iconCls:'icon-help',
				width:500,
				height:210,
				href: '<%=basePath%>Main/systemcontact/departmentcontact/callview',
				queryParams:{worknum:worknum},
				buttons:[]
		};
		$.lauvan.openCustomDialog("calloutDialog",attrArray);	
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		
		<div data-options="region:'center',border:false">	
			<table id="departcontactTree" class="easyui-treegrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr>  
			            <th field="D_ID" width="100" data-options="hidden:true">部门ID</th> 
			            <th field="D_NAME" width="250">部门名称</th> 
			            <th field="D_PID" width="100" data-options="hidden:true">上级部门ID</th> 	
			            <th field="D_TYPE" width="40" data-options="formatter:formatDeptType">部门类别</th> 
			            <th field="BO_WORKNUMBER" width="100">办公电话</th> 
			            <th field="BO_FAX" width="100">传真</th> 
			            <th field="BO_EMAIL" width="100">Email</th> 
			            <th field="BO_ADDRESS" width="180">地址</th>
			            <th field="CALL" width="80" formatter="CallNumber">拨打电话</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>


