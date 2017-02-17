<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">
	
	$(function(){
		var attrArray={
				toolbar: [
		                   { text: '添加',title:'新增参数', iconCls: 'icon-add',
			                   dialogParams:{dialogId:'commonDialog',href:'<%=basePath%>Main/common/add',
			                   defVal:0,formId:'common_form'}}, '-', 
		                   { text: '修改',title:'参数编辑',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'commonDialog',href:'<%=basePath%>Main/common/edit'
					                   ,formId:'common_form'}}, '-',
		                   { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/common/delete'}},'-',
		                   { text: '转业务字典',title:'转业务字典参数',iconCls: 'icon-redo',permitParams:'${pert:hasperti(applicationScope.changeCommon, loginModel.xdlimit)}'
		                	   ,handler:function(){
	               		   		var row=$('#commonGrid').treegrid("getSelections");
			           			if(row.length==0){
			           				$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			           				return;
			           			}
			           			var ids="";
			           			var lev=1;
			           			var sup="";
			           			for(var i=0;i<row.length;i++){
				           			var l = $('#commonGrid').treegrid("getLevel",row[i].ID);
				           			if(l>2){
				           				$.lauvan.MsgShow({msg:'注意选择转换的参数不能在第2层以下！'});
				           				return;
				           			}
				           			if(i==0){
					           			lev = l;
					           			ids = row[i].ID;
					           			sup = row[i].SUP_ID;
				           			}else{
					           			if(lev>l){
					           				lev = l;
						           			ids = row[i].ID;
						           			sup = row[i].SUP_ID;
					           			}else if(lev==1){
					           				ids = ids + ","+row[i].ID;
					           			}
				           			}
			           			}
	               		   		var dialogDef={
										title:'转业务字典参数',
										href: '<%=basePath%>Main/common/changeBus?ids='+ids+"&supid="+sup
								};
								$.lauvan.openCustomDialog('commonDialog',dialogDef,null,'common_form');
	               	   	} }
		                  ],
				fitColumns : true,
				pagination:false,//分页控件
				idField:'ID',    
			    treeField:'P_NAME',
				url:"<%=basePath%>Main/common/getTreeGridData",
				onBeforeExpand:function(row){
					//动态设置展开查询的参数
			        $("#commonGrid").treegrid("options").queryParams = {"pid":row.ID};  
			        return true;
				}
        };
		$.lauvan.treeGrid("commonGrid",attrArray);
		
	});
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="commonGrid" class="easyui-treegrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" width="100" data-options="hidden:true">ID</th> 
			            <th field="P_NAME" width="250">参数名称</th> 
			            <th field="P_ACODE" width="200" >参数编码</th> 
			            <th field="SUP_ID" width="100" data-options="hidden:true">pID</th> 
			            <th field="REMARK"  width="350" >备注</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

