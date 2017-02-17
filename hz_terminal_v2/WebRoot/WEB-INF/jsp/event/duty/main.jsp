<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '修改',title:'编辑值班要情纪要',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'evDutyDialog',href:basePath+"Main/eventDuty/edit",width:800,
								height:380,formId:'evdutyform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/eventDuty/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/eventDuty/getGridData",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			window.open(basePath+"Main/eventDuty/getContent/"+rowData.ID);
		}
		};
		$.lauvan.dataGrid("evDutyGrid",attrArray);
		});

	
	function evduty_doSearch(){
		$('#evDutyGrid').datagrid('load',{
			evname: $('#devname').val()
		});
	}
	function EdNoFN(value,row,index){
		return "["+row.ER_NOYEAR+"] "+row.ER_NO;
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>事件名称：</span>
			<input id="devname" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="evduty_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="evDutyGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			        	 <th field="EDNO" width="100"  formatter="EdNoFN">编号</th>
			            <th field="EVNAME" width="150">关联事件名称</th> 
			            <th field="ER_REPORTUNIT" width="100"  >上报单位</th>
			            <th field="ER_ISSUER" width="100"  >签发人</th>
			            <th field="USERNAME" width="100"  >记录人</th>
			            <th field="MARKTIME" width="100"  >创建时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
<div id="routineDialog"></div>
