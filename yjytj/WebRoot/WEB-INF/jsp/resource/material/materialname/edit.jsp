<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	  <form id="manameEdit" method="post" action="<%=basePath%>Main/materialname/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="edit"/>
	  <input type="hidden" name="t_Bus_Materialname.mn_id" value="${model.mn_id}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">物资名称：</td>
		<td><input name="t_Bus_Materialname.mn_name" value="${model.mn_name}" type="text"
			class="easyui-textbox" data-options="prompt:'请输入物资名称',required:true,icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">物资类型：</td>
		<td><input class="easyui-combotree" name="t_Bus_Materialname.type" 
		    data-options="required:true,url:'<%=basePath%>Main/materialname/getComboTree',method:'get',editable:false,value:'${model.type}'" style="width:180px;"></td>
		</tr>
		<tr>
		<td class="sp-td1">型号：</td>
		<td><input name="t_Bus_Materialname.typeclass" value="${model.typeclass}" type="text"
			class="easyui-textbox" data-options="icons:iconClear"
			style="width:180px;" /></td>
			
		<td class="sp-td1">规格：</td>
		<td><input name="t_Bus_Materialname.sizeclass" value="${model.sizeclass}" type="text"
			class="easyui-textbox" data-options="icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
		<td class="sp-td1">计量单位：</td>
		<td><select class="easyui-combobox" name="t_Bus_Materialname.measureunit"
			panelHeight="auto" code="MAUNIT" style="width: 180px;"
			data-options="editable:false,value:'${model.measureunit}'"></select></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3"><textarea name="t_Bus_Materialname.remark"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;">${model.remark}</textarea></td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
