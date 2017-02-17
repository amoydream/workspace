<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	  
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/succorempd/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">起始时间</td>
			    	<td >
			    		<input type="hidden" value="${d.persid}" name="t_Succoremp_d.persid" />
			    		<input type="text"  name="t_Succoremp_d.starttime" value="${d.starttime}" data-options="required:true,validType:'date'" class="easyui-datebox" style="width: 200px;" />
			    	</td>
			    	<td class="sp-td1">结束时间</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.endtime" value="${d.endtime}" data-options="required:true,validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">所在单位</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.perdept" value="${d.perdept}" data-options="required:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">单位性质</td>
			    	<td >
			    		<select  name="t_Succoremp_d.deptkindid" code="ORGA"  data-options="value:'${d.deptkindid}',panelHeight:125, editable:false" class="easyui-combobox" style="width: 200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">职务</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.perduty" value="${d.perduty}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">技术方向</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.techdirec" value="${d.techdirec}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">从事工作</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.workat" value="${d.workat}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">记录人</td>
			    	<td >
			    		<input type="hidden" name="t_Succoremp_d.recid" value="${loginModel.userId}"/>
			    		<input type="text"  name="recname" value="${loginModel.userName}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">记录时间</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp_d.rectime" value="${d.rectime}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td ></td>
			    	<td >
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">技术成果</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Succoremp_d.techprod" value="${d.techprod}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">说明</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Succoremp_d.worknote" value="${d.worknote}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
