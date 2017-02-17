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
                  { text: '彻底删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/mail/realdelete'}}, '-', 
                  { text: '恢复',iconCls: 'icon-delete',delParams:{url:basePath+'Main/mail/reback'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/mail/getDelGrid",
		onDblClickRow:function(rowIndex, rowData){
			viewMail(rowData.ID,'del');
		}
		};
		$.lauvan.dataGrid("mailDelGrid",attrArray);
		});

	
	function maildel_doSearch(){
		$('#mailDelGrid').datagrid('load',{
			subject: $('#delsubject').val(),
			name:$('#delrecename').val(),
			marktime:$('#deltime').datebox('getValue'),
		});
	}

	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>主题：</span>
			<input id="delsubject" type="text" class="easyui-textbox" >
			<span>收件人：</span>
			<input id="delrecename" type="text" class="easyui-textbox" >
			<span>删除时间：</span>
			<input id="deltime" type="text" class="easyui-datebox" data-options="editable:false,icons:iconClear" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="maildel_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="mailDelGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="SENDER" width="150">发件人</th> 
			            <th field="SUBJECT" width="150">主题</th>
			        	<th field="ADDRESS_TO" width="150">收件人</th> 
			            <th field="MARKTIME" width="200"  >时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>