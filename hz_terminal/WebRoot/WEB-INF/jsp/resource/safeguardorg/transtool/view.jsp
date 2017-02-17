<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  </script>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    		<td class="sp-td1">工具名称</td>
			    	<td>
			    		${tool.toolname}
			    	</td>
			    	<td class="sp-td1">运输工具型号</td>
			    	<td>
			    		${tool.transtype}
			    	</td>
		    	<tr>
			    	<td class="sp-td1">运输企业</td>
			    	<td>
			    		${tool.firmname}
			    	</td>
			    	<td  class="sp-td1">日常用途</td>
		    		<td>
		    			${str:translate(tool.usualusecode, 'YSGJRCYT')}
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">运送货物类型</td>
			    	<td >
			    		${str:translate(tool.loadtypecode, 'YSHWLX')}
			    	</td>
		    		<td class="sp-td1">运输工具数量</td>
			    	<td>
			    		${tool.toolnum}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">计量单位</td>
			    	<td>
			    		${tool.measureunit}
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		${str:translate(tool.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
			    	<td colspan="3">
			    		${tool.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">货物描述</td>
			    	<td colspan="3">
			    		${tool.loadingdesc}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">存放地点</td>
			    	<td colspan="3">
			    		${tool.depositplace}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		${tool.notes}
			    	</td>
		    	</tr>
	    </table>
