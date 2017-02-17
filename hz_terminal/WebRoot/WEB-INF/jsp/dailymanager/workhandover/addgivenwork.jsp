<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="givenwork_form" method="post" action="<%=basePath%>Main/workhandover/givenworkSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input type="hidden" name="t_DutyRecord_Content.pid" value="${wh.dutyid}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">	
	<tr>
		    <td class="sp-td1">事件：</td>
		    <td>
		    <input  type="hidden" id="event_id" name="t_DutyRecord_Content.eventid"/>
		    <input id="event_name" name="t_DutyRecord_Content.eventname" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="findevent('${wh.event_id}')" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		<tr>
			<td class="sp-td1">值班纪要类型：</td>
			<td>
		<select id="controltype" name="t_DutyRecord_Content.type" class="easyui-combobox" style="width:300px;" panelHeight="auto" data-options="editable:false">
        <option value="接收信息">接收信息</option> 
        <option value="交接跟踪事项">交接跟踪事项</option>
        </select> 
			</td>
		</tr>
		<tr>
			<td class="sp-td1">编辑时间：</td>
			<td><input name="t_DutyRecord_Content.marktime" type="text"
				class="easyui-datetimebox" id="editdate" data-options="required:true" readonly="true"
				style="width: 300px;" value="${now }"></input></td>
		</tr>
		<tr>
			<td class="sp-td1">值班纪要内容：</td>
			<td><textarea name="t_DutyRecord_Content.content" id="content" class="textarea"
					style="width: 300px; height: 150px;"></textarea></td>
		</tr>
	</table>
</form>
