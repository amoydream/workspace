<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/chemistryinfo/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">CASNO</td>
			    	<td >
			    		<input type="text" name="t_Chemistryinfo.casno"  data-options="required:true" class="easyui-textbox" style="width: 200px;" />
			    	</td>
			    	<td class="sp-td1">化学品名称</td>
			    	<td >
			    		<input type="text"  name="t_Chemistryinfo.chemname" data-options="required:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">化学品俗名</td>
			    	<td >
			    		<input type="text"  name="t_Chemistryinfo.column1" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">化学品英文名称</td>
			    	<td>
			    		<input type="text"  name="t_Chemistryinfo.chemnameen" data-options="required:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">化学品英文简称</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.achemliasen" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">un编号</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.unno" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">危险货物号</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.dangno" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">rtecsh号</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.rtecsno" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">分子式</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.moleform" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">分子量</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.moleweight" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">生效日期</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.effectdate" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">企业名称</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpname" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业编号</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpno" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">企业地址</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpaddr" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业邮编</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpzip" data-options="validType:'zip'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">企业应急电话</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpemstel" data-options="validType:'phone'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">企业传真</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpfax" data-options="validType:'faxno'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">企业邮箱</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.corpemail" data-options="validType:'email'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">技术说明书编码</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.explanno" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">备注</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.note" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">记录人</td>
		    		<td >
		    			<input type="hidden" name="t_Chemistryinfo.recordman" value="${loginModel.userId}"/>
			    		<input type="text"  name=""  value="${loginModel.userName}" data-options="" readonly="true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">记录时间</td>
		    		<td >
			    		<input type="text"  name="t_Chemistryinfo.recordtime" value="${nowdate}" data-options="readonly:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
