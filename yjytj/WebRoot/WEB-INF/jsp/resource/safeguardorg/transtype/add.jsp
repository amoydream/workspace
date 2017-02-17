<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/transtype/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">运输工具型号</td>
			    	<td colspan="3">
			    		<input name="t_Bus_TransType.transtype"  data-options="icons:iconClear,validType:'length[0,60]',required:true" class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">生产企业</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_TransType.producevender" data-options="icons:iconClear,validType:'length[0,60]'" class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">载重</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_TransType.transload" data-options="icons:iconClear,validType:'length[0,50]'"  class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">使用燃料</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_TransType.usefuel" data-options="icons:iconClear,validType:'length[0,50]'"  class="easyui-textbox" style="width: 540px;"/>
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">运输方式</td>
			    	<td >
			    		<input type="text"  name="t_Bus_TransType.transwaycode" code="YSFS" data-options="icons:iconClear,editable:false,panelHeight:135"  class="easyui-combobox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		<select name="t_Bus_TransType.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,panelHeight:135,required:true,icons:iconClear" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_TransType.notes" data-options="icons:iconClear,validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
