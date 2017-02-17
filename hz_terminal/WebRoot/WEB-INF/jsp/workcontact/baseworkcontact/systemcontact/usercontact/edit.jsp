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
					$('#editDialog').dialog('close');
					refreshGrid();
				}else{
					$.messager.alert('错误',obj.msg,'error');
				}
			}
		});
  	}

  </script>
	 <form id="form1" method="post" action="<%=basePath %>Main/systemcontact/contactbook/save" style="width:100%;">
	    <input type="hidden" name="act" value="${add }"/>
	    <input type="hidden" name="t_Bus_ContactBook.bo_userid" value="${user.user_id }"/>
	    <input type="hidden" name="t_Bus_ContactBook.bo_id" value="${book.bo_id }"/>
	    <input type="hidden" name="dept_id" value="${user.dept_id }"/>
	    <table  id="table"  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">用户姓名</td>
		    	<td >
		    	<input type="text" name="t_Sys_User.user_name"  class="easyui-textbox" style="width:230px;" value="${user.user_name }" readonly="readonly"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">岗位</td>
		    	<td >
		    	<input class="easyui-combotree" name="bo_position" data-options="url:'<%=basePath%>Main/systemcontact/usercontact/getTypeTree',method:'get',
		    	editable:false,multiple:true,panelHeight:'auto',
		    	required:true,value:'${book.bo_position}'" style="width:230px;">		
		  		</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">办公电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_worknumber" id="bo_worknumber" data-options="prompt:'请输入办公电话号',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_worknumber }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">手机</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_mobile" id="bo_mobile" data-options="prompt:'请输入手机号',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_mobile }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">住宅电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_homenumber" id="bo_homenumber" data-options="prompt:'请输入住宅电话号',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_homenumber }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_fax" id="bo_fax" data-options="prompt:'请输入传真号',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_fax }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">Email</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_email" id="bo_email" data-options="prompt:'请输入邮箱号',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_email }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">地址</td>
		    	<td >
		    	<input type="text" name="t_Bus_ContactBook.bo_address" id="bo_address" data-options="prompt:'请输入地址',icons:iconClear" 
		    	class="easyui-textbox" style="width:230px;" value="${book.bo_address }"/></td>
		    	</tr>		    			 		    		 
	    </table>
    </form>
