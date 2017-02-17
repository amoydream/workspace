<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
$(function(){
	$("#_archtime").combobox('yearandmonth');
});
</script>	 
	 <form id="archiveform" method="post" action="<%=basePath %>Main/archive/save" style="width:100%;">
	    <input type="hidden" name="flag" value="folder"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">归档目录名称：</td>
		    	<td >
		    	<input type="text" name="t_Bus_Archive.archivename" data-options="prompt:'请输入归档目录名称',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">归档时间：</td>
		    	<td >
		    		<input id="_archtime" type="text" name="t_Bus_Archive.archivetime" class="easyui-combobox"
		    		 data-options="required:true,icons:iconClear" style="width: 180px;">
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		  		<td colspan="3">
		    		<textarea name="t_Bus_Archive.remark" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 560px;height: 50px;" ></textarea>
		    	</td>
		  		</tr>
		    	
	    </table>
    </form>
