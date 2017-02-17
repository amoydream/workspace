<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/teamperson/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    <input type="hidden" name="t_Bus_Team_Person.tpe_id" value="${model.tpe_id}"/>
	    <input type="hidden" name="t_Bus_Team_Person.teamid" value="${model.teamid}"/>
		<tr>
			<td class="sp-td1">人员姓名</td>
			<td><input type="text" name="t_Bus_Team_Person.tpe_name" value="${model.tpe_name}"
				data-options="required:true" class="easyui-textbox"
				style="width: 200px;" /></td>
			<td class="sp-td1">性别</td>
			<td><select name="t_Bus_Team_Person.sex" code="SEX"
				class="easyui-combobox" style="width:200px;"
				data-options="panelHeight:50,required:true,editable:false,value:'${model.sex}'">
			</select></td>
		</tr>
		<tr>
			<td class="sp-td1">民族</td>
			<td><select name="t_Bus_Team_Person.nationality"code="MZ"
				class="easyui-combobox" style="width:200px;"
				data-options="panelHeight:200,required:true,editable:false,value:'${model.nationality}'">
			</select></td>
			<td class="sp-td1">手机号码</td>
			<td><input type="text" name="t_Bus_Team_Person.phone" value="${model.phone}"
				data-options="validType:'mobile'" class="easyui-textbox"
				style="width: 200px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">人员特长</td>
			<td colspan="3"><input type="text" value="${model.speciality}"
				name="t_Bus_Team_Person.speciality" data-options=""
				class="easyui-textbox" style="width: 540px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">家庭住址</td>
			<td colspan="3"><input type="text" value="${model.address}"
				name="t_Bus_Team_Person.address" data-options=""
				class="easyui-textbox" style="width: 540px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">备注</td>
			<td colspan="3"><input type="text" name="t_Bus_Team_Person.remark" value="${model.remark}"
				data-options="multiline:true" class="easyui-textbox"
				style="width: 540px;height:80px;" /></td>
		</tr>
	    </table>
    </form>
