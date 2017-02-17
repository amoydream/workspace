<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={toolbar: [
						{ text: '添加',title:'添加相关附件', iconCls: 'icon-add',
						    dialogParams:{dialogId:'eventfjDialog',href:basePath+"Main/event/addfj/${eventid}",width:700,
								height:350,formId:'eventfjform',isNoParam:true}},'-',
						{ text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/event/deletefj/${eventid}'}}
		                ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/event/getFjGrid/${eventid}",
		pagination:false
		};
		$.lauvan.dataGrid("eventFjGrid",attrArray);
	});
	function actionfn(value,row,index){
		var act = "<a  href=\""+basePath+"Main/attachment/downloadFJ/"+row.ID+"\" class=\"downcls\" >"+value+"</a>";
		return act;
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="eventFjGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="200" formatter="actionfn">附件名称</th> 
			            <th field="M_TYPE" width="100"  >附件类型</th>
			            <th field="M_SIZE" width="100"  >附件大小</th>
			            <th field="USERNAME" width="100"  >上传者</th>
			            <th field="UPLOADDATE" width="150"  >上传时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
