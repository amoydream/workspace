<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script>
	$(function(){
		var param = {
				fitColumns : true,
				url:"<%=basePath%>Main/planMg/getResourceData",
				queryParams:{preschid:'${preschid}'}
		};
		var newParam = $.extend(true,{}, param, {queryParams:{code:'3020'},
					onDblClickRow: function(rowIndex, rowData){
						var row = $("#wzGrid").datagrid('getSelected');
						if(!row){
							$.lauvan.MsgShow({msg: '请选择欲查看的记录！'});
							return;
						}
						var para = {
							title:'详情',
							height: 300,
							width: 550,
							href: '<%=basePath%>Main/equipname/getview/' + row.ITEMID,
							buttons: []
						};
						$.lauvan.openCustomDialog("viewDialog", para, null, null);
			}
		});
		$.lauvan.dataGrid("wzGrid", newParam); //应急物资
		
		newParam = $.extend(true,{}, param, {queryParams:{code:'2080'},
				onDblClickRow: function(rowIndex, rowData){
					var row = $("#zjGrid").datagrid('getSelected');
					if(!row){
						$.lauvan.MsgShow({msg: '请选择欲查看的记录！'});
						return;
					}
					var para = {
						title:'详情',
						height:450,
						width: 650,
						href:'<%=basePath%>Main/expert/getview/' + row.ITEMID,
						buttons:[]
					};
					$.lauvan.openCustomDialog("viewDialog", para, null, null);
				}
			});
		$.lauvan.dataGrid("zjGrid", newParam); //应急专家

		newParam = $.extend(true,{}, param, {queryParams:{code:'3010'},
				onDblClickRow: function(rowIndex, rowData){
					var row = $("#dwGrid").datagrid('getSelected');
					if(!row){
						$.lauvan.MsgShow({msg :'请选择欲查看的记录！'});
						return;
					}
					var para = {
							title:'详情',
							height: 500,
							width: 750,
							href: '<%=basePath%>Main/team/getview/' + row.ITEMID,
							buttons:[]
						};
						$.lauvan.openCustomDialog("viewDialog", para, null, null);
					
				}
				});
		$.lauvan.dataGrid("dwGrid", newParam); //应急队伍


		newParam = $.extend(true,{}, param, {queryParams:{code:'3030'},
						onDblClickRow: function(rowIndex, rowData){
							var row = $("#zbGrid").datagrid('getSelected');
							if(!row){
								$.lauvan.MsgShow({msg: '请选择欲查看的记录！'});
								return ;
							}
							var para = {
								title:'详情',
								height: 300,
								width: 550,
								href: '<%=basePath%>Main/equipname/getview/' + row.ITEMID,
								buttons:[]
							};
							$.lauvan.openCustomDialog("viewDialog", para, null, null);
					}});
		$.lauvan.dataGrid("zbGrid", newParam); //应急装备
	});
</script>
	<div class="easyui-tabs" data-options="fit:true">
		<div title="应急物资">
			 <table id="wzGrid" cellspacing="0" cellpadding="0" data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="ITEMNAME" width="150">名称</th> 
			            <th field="TCODE" width="100"  >型号</th>
			        </tr> 
			    </thead> 
			</table>
		</div>
		
		<div title="应急专家">
			 <table id="zjGrid" cellspacing="0" cellpadding="0" data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="ITEMNAME" width="150">姓名</th> 
			            <th field="REMARK" width="100"  >备注</th>
			        </tr> 
			    </thead> 
			</table>
		</div>
	
		<div title="应急队伍">
			 <table id="dwGrid" cellspacing="0" cellpadding="0" data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="ITEMNAME" width="150">名称</th> 
			            <th field="TEAMJOB" width="100">队伍职责</th>
			        </tr> 
			    </thead> 
			</table>
		</div>
		<div title="应急装备">
			<table id="zbGrid" cellspacing="0" cellpadding="0" data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="ITEMNAME" width="150">名称</th> 
			            <th field="REMARK" width="100"  >备注</th>
			        </tr> 
			    </thead> 
			</table>
		</div>
	</div>
