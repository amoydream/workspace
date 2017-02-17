<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>


  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/emfund/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">名称</td>
			    	<td>
			    		<input name="t_Bus_EmFund.fundname"  data-options="validType:'length[0,60]',required:true,icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">类型</td>
			    	<td>
			    		<input name="t_Bus_EmFund.firmtypecode" data-options="editable:false,required:true,icons:iconClear,panelHeight:135,method:'get', url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/YJCLBZ'" class="easyui-combotree" style="width:180px;" />
			    	</td>
			    	<td class="sp-td1">级别</td>
			    	<td>
			    		<select name="t_Bus_EmFund.levelcode" code="ZDFHJBDM" data-options="editable:false,panelHeight:145,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">密级</td>
			    	<td>
			    		<select name="t_Bus_EmFund.classcode" code="ZDFHMJDM" data-options="editable:false,editable:false,panelHeight:145,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">值班电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.dutytel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">传真</td>
			    	<td>
			    		<input name="t_Bus_EmFund.fax"  data-options="icons:iconClear,validType:'faxno'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人</td>
			    	<td>
			    		<input name="t_Bus_EmFund.respper"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">负责人办公电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.respotel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">负责人移动电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.respmtel"  data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">负责人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.resphtel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人</td>
			    	<td>
			    		<input name="t_Bus_EmFund.contactper"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人办公电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.contactotel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">联系人移动电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.contactmtel"  data-options="icons:iconClear,validType:'mobile'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">联系人住宅电话</td>
			    	<td>
			    		<input name="t_Bus_EmFund.contacthtel"  data-options="icons:iconClear,validType:'phone'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    		<td class="sp-td1">联系人电子邮箱</td>
			    	<td>
			    		<input name="t_Bus_EmFund.contactemail"  data-options="icons:iconClear,validType:'email'" class="easyui-textbox" style="width:180px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">主管单位</td>
			    	<td>
			    		<input name="t_Bus_EmFund.chargedept"  data-options="validType:'length[0,60]',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">主管单位地址</td>
			    	<td colspan="3">
			    		<input name="t_Bus_EmFund.cdeptaddress"  data-options="validType:'length[0,200]',icons:iconClear" class="easyui-textbox" style="width: 500px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">资金来源</td>
			    	<td>
			    		<select name="t_Bus_EmFund.fundsourcecode"  code="FUNDCOME" data-options="editable:false,required:true,panelHeight:75,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
			    	<td class="sp-td1">资金金额（万）</td>
			    	<td>
			    		<input name="t_Bus_EmFund.amount"  data-options="required:true,validType:'intOrFloat',icons:iconClear" class="easyui-textbox" style="width:180px;"/>
			    	</td>
			    	<td class="sp-td1">数据来源单位</td>
			    	<td>
			    		<select name="t_Bus_EmFund.sourcedeptcode"  code="ZDFHSJLYDW" data-options="editable:false,required:true,panelHeight:100,icons:iconClear" class="easyui-combobox" style="width:180px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">资金用途</td>
			    	<td colspan="5">
			    		<input name="t_Bus_EmFund.purpose"  data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 630px;height:40px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Bus_EmFund.notes" data-options="validType:'length[0,500]',multiline:true,icons:iconClear" class="easyui-textbox" style="width: 630px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
