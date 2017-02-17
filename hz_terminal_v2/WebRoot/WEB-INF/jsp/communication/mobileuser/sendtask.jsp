<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function getPoint(){
	$.lauvan.openGisDialog($("#pointx").val(),$("#pointy").val(),function(lng,lat){
		$("#pointx").textbox('setValue',lng);
		$("#pointy").textbox('setValue',lat);
	});
	
}
</script>
<form id="sendtasktom_form" method="post" action="<%=basePath%>Main/mobileuser/taskSave"
	style="width: 100%;">
	<input type="hidden" name="ids" value="${ids }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">标题：</td>
		    <td colspan="3">
		    <input  type="text" id="sendtasktitle" class="easyui-textbox" name="s_Bas_SendTask.title" data-options="required:true"  style="width: 550px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="s_Bas_SendTask.pointx" type="text" class="easyui-textbox" data-options="required:true,icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="s_Bas_SendTask.pointy" type="text" class="easyui-textbox" data-options="required:true,editable:'false'" style="width: 200px;"/></td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">描述：</td>
		    <td colspan="3">
		    <textarea id="sendtaskcontent" name="s_Bas_SendTask.content" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 550px; height: 50px;"></textarea>
            </td> 
		    </tr>
    </table>
</form>
