<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/teamequip/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    <input type="hidden" name="t_Bus_Team_Equip.teq_id" value="${model.teq_id}"/>
	    <input type="hidden" name="t_Bus_Team_Equip.teamid" value="${model.teamid}"/>
		<tr>
			<td class="sp-td1">装备名称：</td>
		    <td >
    		<input type="hidden" name="t_Bus_Team_Equip.equipnameid" id="equipnameid" value="${model.equipnameid}"/>
    		<input type="text" id="equipname" value="${equipname}" data-options="readonly:true" class="easyui-textbox" style="width: 150px;"/>
    		<a id="btn" onclick="findEquipname()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
    	    </td>
			<td class="sp-td1">拥有数量：</td>
			<td><input name="t_Bus_Team_Equip.num" value="${model.num}" type="text"
				data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
				class="easyui-numberbox" style="width:180px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">联系人：</td>
			<td><input name="t_Bus_Team_Equip.linkman" value="${model.linkman}" type="text"
				data-options="icons:iconClear" class="easyui-textbox"
				style="width:180px;" /></td>

			<td class="sp-td1">联系人电话：</td>
			<td><input name="t_Bus_Team_Equip.linkmantel" value="${model.linkmantel}" type="text"
				class="easyui-textbox" data-options="icons:iconClear"
				style="width:180px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">联系人手机：</td>
			<td><input name="t_Bus_Team_Equip.linkmanphone" value="${model.linkmanphone}" type="text"
				class="easyui-textbox" data-options="icons:iconClear"
				style="width:180px;" /></td>

			<td class="sp-td1">最近更新时间</td>
			<td><input type="text" name="t_Bus_Team_Equip.updatetime"
				data-options="editable:false,disabled:true,value:'${model.updatetime}'"
				class="easyui-datebox" style="width: 180px;" /></td>

		</tr>
		<tr>
			<td class="sp-td1">停放地址</td>
			<td colspan="3"><input name="t_Bus_Team_Equip.address"
				type="text" value="${model.address}" class="easyui-textbox" data-options="icons:iconClear"
				style="width:523px;" /></td>

		</tr>
		<tr>
			<td class="sp-td1">装备描述</td>
			<td colspan="3"><textarea name="t_Bus_Team_Equip.equipdesc"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 523px;height: 50px;">${model.equipdesc}</textarea></td>
		</tr>
		<tr>
			<td class="sp-td1">备注</td>
			<td colspan="3"><textarea name="t_Bus_Team_Equip.remark"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 523px;height: 50px;">${model.remark}</textarea></td>
		</tr>
	    </table>
    </form>
