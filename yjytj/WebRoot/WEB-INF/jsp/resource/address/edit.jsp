<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  
  
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/address/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">联系方式</td>
			    	<td >
			    		<input type="hidden" value="${ads.add_code}" name="t_Address.add_code"/>
			    		<select name="t_Address.tele_type" data-options="editable:false,required:true,panelHeight:90,value:'${ads.tele_type}'" code="CONN" class="easyui-combobox" style="width: 200px;"></select>
			    	</td>
			    	<td class="sp-td1">联系号码</td>
			    	<td >
			    		<input type="text"  name="t_Address.tele_code" value="${ads.tele_code}" data-options="required:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">优先级别</td>
			    	<td >
			    		<input type="text"  name="t_Address.distinction" value="${ads.distinction}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td></td>
			    	<td></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">描述</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Address.tele_depict" value="${ads.tele_depict}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Address.remark" value="${ads.remark}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
