<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ 
		fitColumns : true,
		idField:'ID',
		frozenColumns:[[]],
		url:basePath+"Main/eventSearch/getGridData?noevtype=07"
		};
		$.lauvan.dataGrid("_relaEventGrid",attrArray);
		});

	
	function smsEvent_doSearch2(){
		$('#_relaEventGrid').datagrid('load',{
			ename: $('#_rs_ename').val()
		});
	}
	function smsEventState(value,row,index){
		if("00A"==value){
			return '日常事件';
		}
		if("00X"==value){
			return '突发事件';
		}
		return value;
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>事件名称：</span>
			<input id="_rs_ename" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsEvent_doSearch2()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="_relaEventGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EV_NAME" width="150">事件名称</th> 
			            <th field="EV_ADDRESS" width="150"  >事发地点</th>
			            <th field="EV_DATE" width="100" >事发时间</th>
			             <th field="EV_STATUS" width="100" CODE="EVST" >事件状态</th>
			             <th field="EV_TYPE" width="100" CODE="EVTP">事件类型</th>
			            <th field="EV_STATE" width="100" formatter="smsEventState">事件性质</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

