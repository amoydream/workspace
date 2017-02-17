<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>  
  	
  $(function() {
        var html = '<option id="0" value="0">---选择排序---</option>';
        for(var i = 1; i < 201; i++) {
	        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
        }
        document.getElementById('p_sort').innerHTML = html;
    });  

  </script>
	 
	 <form id="_epersonform" method="post" action="<%=basePath %>Main/personcontact/ePersonSave" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <table  id="table"  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">用户姓名</td>
		    	<td >
		    	<input type="text" name="t_Bus_OrganPerson.p_name"  class="easyui-textbox" style="width:260px;" value="${phname}"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">岗位</td>
		    	<td>
		    	<input class="easyui-combotree" name="p_position" data-options="url:'<%=basePath%>Main/personcontact/getTypeTree',method:'get',
		    	editable:false,multiple:true,panelHeight:'255',
		    	required:true" style="width:260px;">
		  		</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">办公电话</td>
		    	<td>
		    	<input type="text" name="t_Bus_OrganPerson.p_worknumber" id="p_worknumber" data-options="prompt:'请输入办公电话',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${worknumber}"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">手机</td>
		    	<td>
		    	<input type="text" name="t_Bus_OrganPerson.p_mobile" id="p_mobile" data-options="prompt:'请输入手机号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${phone}"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">住宅电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_OrganPerson.p_homenumber" id="bo_homenumber" data-options="prompt:'请输入住宅电话号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" /></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真</td>
		    	<td >
		    	<input type="text" name="t_Bus_OrganPerson.p_fax" id="bo_fax" data-options="prompt:'请输入传真号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${fax}"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">Email</td>
		    	<td >
		    	<input type="text" name="t_Bus_OrganPerson.p_email" id="bo_email" data-options="prompt:'请输入邮箱号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" /></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">地址</td>
		    	<td >
		    	<input type="text" name="t_Bus_OrganPerson.p_address" id="bo_address" data-options="prompt:'请输入地址',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" /></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">所属机构</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_OrganPerson.p_orid" data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',required:true" style="width:260px;">
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">排序</td>
		    	<td >
		    	    <select class="easyui-combobox" id="p_sort" name="t_Bus_OrganPerson.p_sort" style="width: 260px;">					
					</select>
		    	</td>
		    	</tr>					 		    		 
	    </table>
    </form>
