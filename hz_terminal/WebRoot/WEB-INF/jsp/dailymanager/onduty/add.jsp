<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="onduty_form" method="post" action="<%=basePath%>Main/onduty/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input type="hidden" name="type" value="${type }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<tr>
		    <td class="sp-td1">姓名：</td>
		    <td>
		    <input  type="hidden" id="useraccount"/>
		    <input id="username" name="t_LeaderDuty.leadername" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="finduser()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		<tr>
		<tr>
		    <td class="sp-td1">部门：</td>
		    <td>
		    <input id="dept" name="t_LeaderDuty.dept" type="text" class="easyui-textbox" data-options="required:true" readonly="true" style="width: 300px;"/></td>
		    </tr>
		<tr>
		<tr>
		    <td class="sp-td1">电话：</td>
		    <td>
		    <input id="tel" name="t_LeaderDuty.phone" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		<tr>
		<tr>
			<td class="sp-td1">值班日期：</td>
			<td><input name="t_LeaderDuty.dutydate" type="text"
				class="easyui-datebox" id="dutydate" data-options="required:true" editable="false" <c:if test="${type=='g'}">readonly="true"</c:if>
				style="width: 300px;"<c:if test="${type=='g'}">value="${dateStr}"</c:if> <c:if test="${type=='c'}">value="${now}"</c:if>></input></td>
		</tr>	
		<tr>
			<td class="sp-td1">值班性质：</td>
			<td>
		<select id="dutypost" name="t_LeaderDuty.dutypost" class="easyui-combobox" style="width:300px;" panelHeight="auto" data-options="editable:false">
        <option value="0001">带班领导</option> 
        <option value="0002">值班领导</option>
        <option value="0003">值班干部</option>
        </select> 
			</td>
		</tr>
          <tr>
			<td class="sp-td1">值班类型：</td>
			<td>
		<select id="dutytype" name="t_LeaderDuty.dutytype" class="easyui-combobox" style="width:300px;" panelHeight="auto" data-options="editable:false">
        <option value="0001">工作日</option> 
        <option value="0002">节假日</option>
        </select> 
			</td>
		</tr>
		<tr>
			<td class="sp-td1">是否为模板：</td>
			<td>
		<select name="moudle" class="easyui-combobox" style="width:300px;" panelHeight="auto" data-options="editable:false">
        <option value="n">否</option> 
        <option value="y">是</option>
        </select> 
			</td>
		</tr>
	</table>
</form>
