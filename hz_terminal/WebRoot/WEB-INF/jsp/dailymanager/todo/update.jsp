<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="todo_form" method="post" action="<%=basePath%>Main/todo/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_ThingInfo.id" value="${it.id}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">事件：</td>
		    <td>
		    <input  type="hidden" id="event_id" value="${it.code }" name="t_ThingInfo.code"/>
		    <input id="event_name" value="${it.ev_name }" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="findevent()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">事宜名称：</td>
		    <td>
		    <input id="todoname" value="${it.name }" name="t_ThingInfo.name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">接收人：</td>
		    <td>
		    <input  type="hidden" id="userid" value="${it.receiver}" name="t_ThingInfo.receiver"/>
		    <input id="username" value="${it.receivername}" name="t_ThingInfo.receivername" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="finduser()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		    <tr>
		    <tr>
			<td class="sp-td1">事宜内容：</td>
			<td><textarea id="todocontent" name="t_ThingInfo.content" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 300px; height: 50px;">${it.content}</textarea></td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td><textarea name="t_ThingInfo.note" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 300px; height: 50px;">${it.note}</textarea></td>
		    </tr>
    </table>
</form>
