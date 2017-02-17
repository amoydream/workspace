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
                  { text: '新增短信',title:'新增短信', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'smsMgDialog',href:basePath+"Main/smsMg/add/rece",width:700,
						height:400,formId:'smsMgform',isNoParam:true}}, '-', 
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/smsMg/delete/rece'}}
                 ],
		fitColumns : true,
		idField:'MOBILEID',
		url:basePath+"Main/smsMg/getReceGridDate",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			$(document.body).append("<div id='smsViewDialog2'></div>");
			$("#smsViewDialog2").dialog({
				title:'短信详情',
				width: 800,
				height: 380,
				cache: false,
			    modal: true,
			    onClose:function(){
					$(this).dialog('destroy');
					$("#smsViewDialog2").remove();
					$('#smsReceGrid').datagrid("reload");
				},
				href: basePath+"Main/smsMg/view/rece-"+rowData.MOBILEID+"-"+rowData.SM_ID,
				buttons: []
				});	
		}
		};
		$.lauvan.dataGrid("smsReceGrid",attrArray);
		});

	
	function smsrece_doSearch(){
		$('#smsReceGrid').datagrid('load',{
			scontent: $('#scontent').val(),
			phonenum:$('#phonenum').val(),
			smobname:$('#smobname').val(),
		});
	}
	function receStateFN(value,row,index){
		if(value==1){
			return '已读';
		}else{
			return '未读';
		}
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>短信内容：</span>
			<input id="scontent" type="text" class="easyui-textbox" >
			<span>发送号码：</span>
			<input id="phonenum" type="text" class="easyui-textbox" >
			<span>发件人：</span>
			<input id="smobname" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsrece_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="smsReceGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			        	<th field="MOBILE" width="100">发送号码</th> 
			            <th field="MOBNAME" width="100">发件人</th> 
			            <th field="SIMPLECONT" width="200"  >短信内容</th>
			            <th field="MO_TIME" width="100" >接收时间</th>
			            <th field="STATE" width="100" formatter="receStateFN">是否已读</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
