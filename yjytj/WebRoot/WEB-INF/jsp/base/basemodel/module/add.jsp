<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  <script>
  <%@ include file="/include/inc.jsp"%>
    
  	function openSelectIcon(){
  		$("#iconDialog").dialog('open');
  		//icon.jsp定义的一个变量
  		iconCallbacks.add(function(){
  	  		var iconClass=$('#icon').val();
			$("#iconlink").linkbutton({iconCls:iconClass});
			$("#iconclass").val(iconClass);
			$("#iconDialog").dialog('close');
  	  	});
  	}

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath %>Main/module/save" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Sys_Module.p_id" value="${pid }"/>
	    <table  id="table"  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">模块标识</td>
		    	<td >
		    	<input type="text" name="t_Sys_Module.mark" id="mark" data-options="prompt:'请输入字母、下划线或数字组合',required:true,icons:iconClear" class="easyui-textbox" style="width:70%;"
		    	validType="checkCode['<%=basePath%>Main/module/ifExsitMark','mark']"  invalidMessage="模块标识已存在" /></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">模块名称</td>
		    	<td >
		    	<input type="text" name="t_Sys_Module.name" required="true" data-options="prompt:'请输入模块名称',icons:iconClear" class="easyui-textbox" style="width:70%;"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">模块地址</td>
		    	<td >
		    	<input type="text" name="t_Sys_Module.address" data-options="icons:iconClear" class="easyui-textbox" style="width:70%;"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">顺序索引</td>
		    	<td >
		    	<input type="text" name="t_Sys_Module.orderindex" required="true"  class="easyui-textbox" style="width:70%;" data-options="validType:'integer'"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">模块类型</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Sys_Module.modeltype" data-options="required:true,panelHeight:45,width:100,editable:false">
		    			<option value="0">模块</option>
		    			<option value="1">功能点</option>
		    		</select>
		    		
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">页面链接</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Sys_Module.opentype" data-options="panelHeight:45,width:100,editable:false">
		    			<option value="0">内部链接</option>
		    			<option value="1">外部链接</option>
		    		</select>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">模块状态</td>
		    	<td>
		    		<select class="easyui-combobox" name="t_Sys_Module.usable" data-options="panelHeight:45,width:100,editable:false">
		    			<option value="1">启用</option>
		    			<option value="0">禁用</option>
		    		</select>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">模块图标</td>
		    	<td >
		    		<input type="hidden" name="t_Sys_Module.iconclass" id="iconclass"/>
		    		<a class="easyui-linkbutton" id="iconlink" title="选择图标" onclick="openSelectIcon();"></a>
		    		<div id="iconDialog" class="easyui-dialog" data-options="closed:true,title:'选择图标',iconCls:'icon-applicationviewtile',modal:true">
		    			<c:import url="icon.jsp"/>
		    		</div>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述</td>
		    	<td >
		    		
		    		 <textarea name="t_Sys_Module.Description" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:70%;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
