<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/transtool/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    		<td class="sp-td1">工具名称</td>
			    	<td>
			    		<input type="hidden" name="t_Bus_TransTool.toolid" value="${tool.toolid}"/>
			    		<input type="text"  name="t_Bus_TransTool.toolname" value="${tool.toolname}" data-options="icons:iconClear,validType:'length[0,60]',required:true"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">运输工具型号</td>
			    	<td>
			    		<input type="hidden"  name="t_Bus_TransTool.transtypeid" id="transtooltype" value="${tool.transtypeid}"/>
			    		<input type="text" id="transtypename" value="${tool.transtype}" data-options="icons:iconClear,required:true,editable:false" class="easyui-textbox" style="width: 170px;"/>
			    		<a id="transtypeBtn" onclick="findTranstype()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
		    	<tr>
			    	<td class="sp-td1">运输企业</td>
			    	<td>
			    		<input type="hidden"  name="t_Bus_TransTool.firmid" id="firmid" value="${tool.firmid}"/>
			    		<input type="text"  id="ttfirmname" value="${tool.firmname}" data-options="icons:iconClear,required:true,editable:false" class="easyui-textbox" style="width: 170px;"/>
			    		<a id="firmidBtn" onclick="findFirm()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
			    	<td  class="sp-td1">日常用途</td>
		    		<td>
		    			<select name="t_Bus_TransTool.usualusecode" code="YSGJRCYT" data-options="value:'${tool.usualusecode}',icons:iconClear,panelHeight:110,editable:false" class="easyui-combobox" style="width:200px;"></select>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">运送货物类型</td>
			    	<td >
			    		<select type="text"  name="t_Bus_TransTool.loadtypecode" code="YSHWLX" data-options="value:'${tool.loadtypecode}',icons:iconClear,panelHeight:110,editable:false"  class="easyui-combobox" style="width: 200px;"></select>
			    	</td>
		    		<td class="sp-td1">运输工具数量</td>
			    	<td>
			    		<input type="text"  name="t_Bus_TransTool.toolnum" value="${tool.toolnum}" data-options="icons:iconClear,validType:'length[0,8]',required:true,prompt:'请输入整数'" class="easyui-numberbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">计量单位</td>
			    	<td>
			    		<input type="text"  name="t_Bus_TransTool.measureunit" value="${tool.measureunit}" data-options="icons:iconClear,validType:'length[0,20]'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		<select name="t_Bus_TransTool.sourcedeptcode"  code="ZDFHSJLYDW" data-options="value:'${tool.sourcedeptcode}',icons:iconClear,panelHeight:135,required:true,editable:false" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">货物描述</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_TransTool.loadingdesc" value="${tool.loadingdesc}" data-options="icons:iconClear,validType:'length[0,200]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">存放地点</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Bus_TransTool.depositplace" value="${tool.depositplace}"  data-options="icons:iconClear,validType:'length[0,200]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_TransTool.notes" value="${tool.notes}" data-options="icons:iconClear,validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 540px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
