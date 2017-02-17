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
						{ text: '发布',title:'发布手机快报', iconCls: 'icon-add',
						    dialogParams:{dialogId:'eventAppNewsDialog',href:basePath+"Main/event/appNews/${eventid}",width:700,
								height:350,formId:'evenAppNewsjform',isNoParam:true}}
		                ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/event/getAppGrid/${eventid}",
		pagination:false
		};
		$.lauvan.dataGrid("eventAppNewsGrid",attrArray);
	});
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="eventAppNewsGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="CONTENT" width="200" >快报内容</th> 
			            <th field="CREATETIME" width="100"  >发布时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
