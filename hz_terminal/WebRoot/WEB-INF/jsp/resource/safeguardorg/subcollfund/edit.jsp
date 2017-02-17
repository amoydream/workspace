<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/subcollfund/save/${deptid}" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">现存分项资金（万）</td>
			    	<td >
			    		<input type="hidden" name="t_Bus_SubCollFund.fundid" value="${fund.fundid}" />
			    		<input name="t_Bus_SubCollFund.curpartfund" value="${fund.curpartfund}" data-options="icons:iconClear,validType:'intOrFloat',required:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		<select name="t_Bus_SubCollFund.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,value:'${fund.sourcedeptcode}',panelHeight:135,required:true,icons:iconClear" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">具体用途</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_SubCollFund.funduse" value="${fund.funduse}" data-options="icons:iconClear,validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 535px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		<input type="text"  name="t_Bus_SubCollFund.notes" value="${fund.notes}" data-options="icons:iconClear,validType:'length[0,500]',multiline:true" class="easyui-textbox" style="width: 535px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
