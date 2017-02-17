<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  
	 <div class="easyui-layout"  data-options="fit:true">
	 <form id="form1" method="post" action="<%=basePath %>Main/department/save" style="width:100%;margin: 0 auto;padding: 0;">
	 
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Sys_Department.d_pid" value="${pid }"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">部门名称</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.d_name" 
		    	data-options="prompt:'请输入部门名称',required:true,icons:iconClear" class="easyui-textbox"
		    	style="width: 200px;"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">部门编号</td>
		    	<td>
		    	<input type="text" name="t_Sys_Department.d_number" id="dnumber" required="true" 
		    	data-options="prompt:'请输入部门编号',icons:iconClear" class="easyui-textbox" style="width: 200px;"
		    	validType="checkCode['<%=basePath%>Main/department/ifExistCode','code']"  invalidMessage="部门编码已存在"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">部门类别</td>
		    	<td >
		    		
		    		
		    		<select class="easyui-combobox" name="t_Sys_Department.d_type" panelHeight="auto" style="width:100px;" data-options="required:true">
		    			<option value="0">市</option>
		    			<option value="1">区</option>
		    			<option value="2">县</option>
		    			<option value="3">镇</option>
		    		</select>
		    		
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真编号</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.dtmfkey" class="easyui-numberbox" 
		    		data-options="max:999,icons:iconClear"   style="width: 200px;"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注</td>
		    	<td >
		    	<textarea name="t_Sys_Department.remark" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width: 200px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">默认排序</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.orderid" class="easyui-numberbox" 
		    		data-options="precision:0,min:0,max:999,icons:iconClear"   style="width: 200px;"/>
		    	</td>
		    	</tr>
	    </table>
	   
    </form>
</div>