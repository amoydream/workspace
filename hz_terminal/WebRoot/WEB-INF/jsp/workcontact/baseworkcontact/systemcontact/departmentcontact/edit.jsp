<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>   
  	function onSubmit(){
  		$('#form1').form('submit',{
  			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.success){
					$('#departDialog').dialog('close');
					refreshGrid();
				}
			}
		});
  	}

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath %>Main/systemcontact/contactbook/save" style="width:100%;">
	    <input type="hidden" name="act" value="${add }"/>
	    <input type="hidden" name="depart" value="true"/>
	    <input type="hidden" name="t_Bus_ContactBook.bo_deptid" value="${depart.d_id }"/>
	    <input type="hidden" name="t_Bus_ContactBook.bo_id" value="${book.bo_id }"/>
	    <table  id="table"  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">部门名称</td>
		    	<td >
		    	<input type="text" name="t_Sys_User.user_name"  class="easyui-textbox" style="width:180px;" value="${depart.d_name }" readonly="readonly"/></td>
		    	</tr>	    
		    	<tr>
		  		<td class="sp-td1">办公电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_worknumber" id="bo_worknumber" required="true" data-options="prompt:'请输入办公电话号',icons:iconClear" 
		    	class="easyui-textbox" style="width:180px;" value="${book.bo_worknumber }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_fax" id="bo_fax" data-options="prompt:'请输入传真号',icons:iconClear" 
		    	class="easyui-textbox" style="width:180px;" value="${book.bo_fax }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">Email</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_email" id="bo_email" data-options="prompt:'请输入邮箱号',icons:iconClear" 
		    	class="easyui-textbox" style="width:180px;" value="${book.bo_email }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">地址</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_address" id="bo_address"  data-options="prompt:'请输入地址',icons:iconClear" 
		    	class="easyui-textbox" style="width:180px;" value="${book.bo_address }"/></td>
		    	</tr>		    			 		    		 
	    </table>
    </form>
