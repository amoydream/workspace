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
                  { text: '添加',title:'添加信息专报', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'eventReoprtDialog',href:basePath+"Main/eventReport/add/${eventid}",width:700,
						height:350,formId:'eventReportform',isNoParam:true}}, '-', 
                  { text: '修改',title:'编辑信息专报',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'eventReoprtDialog',href:basePath+"Main/eventReport/edit",width:700,
								height:350,formId:'eventReportform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/eventReport/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/eventReport/getDataGrid/${eventid}",
		pagination:false,
		autoRowHeight:true,
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			window.open(basePath+"Main/eventReport/view/"+rowData.ID+"-0")
		} 
		};
		$.lauvan.dataGrid("eventReportGrid",attrArray);
		});
function ernoFN(value,row,index){
	return "["+row.ER_NOYEAR+"] "+row.ER_NO;
}
function ERactionfn(value,row,index){
	//var act = '<ul class="specil_button"><li class="s_b_1"><a href="#">编辑</a></li>'
	//	+'<li class="s_b_2"><a href="#">删除</a></li>'
	//	+'<li class="s_b_3"><a href="#">专报</a></li></ul>';
	var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\""+basePath+"Main/eventReport/view/"+row.ID+"-0\" target=\"_blank\" >信息专报</a></li>"
			+"<li class=\"s_b_3\">"
			+"<a  href=\""+basePath+"Main/eventReport/view/"+row.ID+"-1\" target=\"_blank\" class=\"zbcls\" >值班要情快报</a></li></ul>";
	return act;
}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="eventReportGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="ERNO" width="100" formatter='ernoFN'>编号</th> 
			            <th field="ER_REPORTUNIT" width="150"  >上报单位</th>
			            <th field="ER_DATE" width="150"  >报告时间</th>
			            <th field="ER_ISSUER" width="100"  >签发人</th>
			            <th field="ERACTION" width="180" formatter="ERactionfn" >操作</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
