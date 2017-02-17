<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">

</script>
	  <form id="manameAdd" method="post" action="<%=basePath%>Main/materialname/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="add"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    
	    <tr>
	    <td class="sp-td1">物资名称：</td>
		<td><input name="t_Bus_Materialname.mn_name" type="text"
			class="easyui-textbox" data-options="prompt:'请输入物资名称',icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">物资类型：</td>
		<td><input class="easyui-combotree" name="t_Bus_Materialname.type"
			data-options="url:'<%=basePath%>Main/materialname/getComboTree',method:'get',required:true<c:if test="${pid!='0'}">,value:${pid }</c:if>"
			style="width:180px;"></td>
		</tr>
		<tr>
		<td class="sp-td1">型号：</td>
		<td><input name="t_Bus_Materialname.typeclass" type="text"
			class="easyui-textbox" data-options="icons:iconClear"
			style="width:180px;" /></td>
			
		<td class="sp-td1">规格：</td>
		<td><input name="t_Bus_Materialname.sizeclass" type="text"
			class="easyui-textbox" data-options="icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">计量单位：</td>
		<td><select class="easyui-combobox" name="t_Bus_Materialname.measureunit"
			panelHeight="auto" code="MAUNIT" style="width: 180px;"
			data-options="editable:false"></select></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3"><textarea name="t_Bus_Materialname.remark"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
