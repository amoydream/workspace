<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  var flagForDeptAdd=true;
	window.setTimeout(function(){
	  		$("#dnumber").next("span").children("input").eq(0).bind("blur",judgeCode);
	  	},1000);

	function judgeCode(){
		$.lauvan.judgeField('<%=basePath%>Main/department/ifExistCode',{code:$('#dnumber').val().trim(),did:$('#did').val()},
					'dnumber','部门编码已存在',function(flag){flagForDeptAdd=flag;});
	}
  

  </script>
	 <div class="easyui-layout"  data-options="fit:true">
	 <form id="form1" method="post" action="<%=basePath %>Main/department/save" style="width:100%;margin: 0 auto;padding: 0;">
	    <input type="hidden" name="act" value="update"/>
	    <input type="hidden" name="t_Sys_Department.d_id" id="did" value="${dept.d_id }"/>
	    <input type="hidden" name="t_Sys_Department.d_pid" id="did" value="${dept.d_pid }"/>
	    <table   id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td  class="sp-td1">部门名称</td>
		    	<td>
		    	<input type="text" name="t_Sys_Department.d_name" data-options="prompt:'请输入部门名称',required:true,icons:iconClear"
		    	 class="easyui-textbox" value="${dept.d_name }" style="width: 200px;" /></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">部门编号</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.d_number" id="dnumber" required="true" data-options="prompt:'请输入部门编号',icons:iconClear" 
		    	class="easyui-textbox" value="${dept.d_number }"  style="width: 200px;" 
		    	validType="checkCode['<%=basePath%>Main/department/ifExistCode','code','did','#did']"  invalidMessage="部门编码已存在"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">部门类别</td>
		    	<td>
		    		
		    		
		    		<select class="easyui-combobox" name="t_Sys_Department.d_type" style="width:100px;"  panelHeight="auto" data-options="required:true">
		    			<option value="0"  <c:if test="${dept.d_type=='0' }">selected</c:if>>市</option>
		    			<option value="1"  <c:if test="${dept.d_type=='1' }">selected</c:if>>区</option>
		    			<option value="2"  <c:if test="${dept.d_type=='2' }">selected</c:if>>县</option>
		    			<option value="3"  <c:if test="${dept.d_type=='3' }">selected</c:if>>镇</option>
		    		</select>
		    		
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真编号</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.dtmfkey" class="easyui-numberbox" 
		    		data-options="max:999,icons:iconClear,value:'${dept.dtmfkey}'" style="width: 200px;"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td  class="sp-td1">备注</td>
		    	<td>
		    	<textarea name="t_Sys_Department.remark"   class="textbox easyui-validatebox"
		    	data-options="validType:'length[0,200]'"  style="width: 200px;height: 50px;" >${dept.remark}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">默认排序</td>
		    	<td >
		    	<input type="text" name="t_Sys_Department.orderid" class="easyui-numberbox" 
		    		data-options="precision:0,min:0,max:999,icons:iconClear,value:'${dept.orderid}'"   style="width: 200px;"/>
		    	</td>
		    	</tr>
	    </table>
    </form>
    </div>