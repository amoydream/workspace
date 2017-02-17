<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">
	$(function(){
		var dateStr=document.getElementById("dateStr").value;
		var attrArray={
				toolbar: '#onduty_tb',
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/onduty/getdutyGridData/"+dateStr
        };
		$.lauvan.dataGrid("ondutyGrid",attrArray);
		
	});
	
	function onduty_doSearch(){
		$('#ondutyGrid').datagrid('load',{
			name: $('#ondutyname').val()
		});
	}
	function updonduty(){
		var node = $("#ondutyGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改值班信息',
				height: 400,
				width:600,
				href: '<%=basePath%>Main/onduty/ondutyupd/'+node.ID
		};
		$.lauvan.openCustomDialog("ondutyDialog",attrArray,onduty_dialogSubmit,'onduty_form');
	}
	function delonduty(){
    	/* var node= $("#ondutyGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#ondutyGrid").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/onduty/ondutydel/'+node.ID,
	            	url:'<%=basePath%>Main/onduty/ondutydel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#ondutyGrid").datagrid('clearSelections');
	            			$("#ondutyGrid").datagrid('clearChecked');
	            			$("#ondutyGrid").datagrid('reload');
	            			var view = $('#calendarxx').fullCalendar('getView');
	            			var mainTab=$("#mainTab");
	            			var startDate = $("#startDate").datebox('getValue');
	            			var tab = mainTab.tabs('getSelected');
	            			tab.panel('refresh','Main/onduty/index?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name);
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
 <span>值班人员:</span>
		<input id="ondutyname" type="text" class="easyui-textbox" >
		<input id="dateStr" type="hidden" value="${dateStr }" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="onduty_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
 </div>
		<div data-options="region:'center',border:false">
		<div id="onduty_tb" style="padding: 0px;">
		<table>
		<tr>
		<%-- <c:if test="${!pert:hasperti(applicationScope.ondutyadd, loginModel.xdlimit)}"> --%>
		<td>		
		<a href="javascript:void(0);" onclick="addondyty('g','${dateStr}')" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		</td>
		<td><div class="datagrid-btn-separator"></div></td>
		<%-- </c:if> --%>
		<%-- <c:if test="${!pert:hasperti(applicationScope.ondutyupd, loginModel.xdlimit)}"> --%>
		<td>
		<a href="javascript:void(0);" onclick="updonduty()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		</td>
		<td><div class="datagrid-btn-separator"></div></td>
		<%-- </c:if> --%>
		<%-- <c:if test="${!pert:hasperti(applicationScope.ondutydel, loginModel.xdlimit)}"> --%>
		<td>
		<a href="javascript:void(0);" onclick="delonduty()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>		
		</td>
		<%-- </c:if> --%>
		</tr>
		</table>
		</div>
		
			<table id="ondutyGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="LEADERNAME" width="100">值班人员</th> 
			            <th field="DEPT" width="100">部门</th> 
			            <th field="PHONE" width="100">电话</th> 
			            <th field="DUTYDATE" width="100">值班日期</th> 
			            <th field="DUTYPOSTN"  width="100" >值班性质</th> 
			            <th field="DUTYTYPEN"  width="100" >值班类型</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
