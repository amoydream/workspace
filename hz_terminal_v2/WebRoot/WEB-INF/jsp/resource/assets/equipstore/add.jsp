<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#longitude").val(),$("#latitude").val(),function(lng,lat){
		$("#longitude").textbox('setValue',lng);
		$("#latitude").textbox('setValue',lat);
	});
}

</script>
	  <form id="equipstoreAdd" method="post" action="<%=basePath%>Main/equipstore/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="add"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    
	    <tr>
	    <td class="sp-td1">存储编号：</td>
		<td><input name="t_Bus_Equipstore.code" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>
			
	    <td class="sp-td1">装备名称：</td>
    	<td >
    		<input type="hidden" name="t_Bus_Equipstore.equipnameid" id="equipnameid"/>
    		<input type="text" id="equipname" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 150px;"/>
    		<a id="btn" onclick="findEquipname()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
    	</td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">数量：</td>
		<td><input name="t_Bus_Equipstore.equipnum" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>
		
		<td class="sp-td1">所属单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Equipstore.organid"
			data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'"
			style="width:180px;"></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">存放地址：</td>
		<td colspan="3"><input name="t_Bus_Equipstore.address" type="text"
			class="easyui-textbox" data-options="required:true,prompt:'请输入存放地址',icons:iconClear"
			style="width:534px;" /></td>
		
		</tr>
		<tr>
			<td class="sp-td1">经度：</td>
			<td><input id="longitude" name="t_Bus_Equipstore.longitude"
				type="text" class="easyui-textbox" style="width: 180px;"
				data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]" />
			</td>

			<td class="sp-td1">纬度：</td>
			<td><input id="latitude" name="t_Bus_Equipstore.latitude"
				type="text" class="easyui-textbox" data-options="readonly:true"
				style="width:180px;" /></td>

		</tr>
		<tr>
		
		<td class="sp-td1">级别：</td>
		<td><select class="easyui-combobox" name="t_Bus_Equipstore.levelcode"
			panelHeight="auto" code="MALEVE" style="width: 180px;"
			data-options="editable:false"></select></td>	
		
		<td class="sp-td1">联系人：</td>
		<td><input name="t_Bus_Equipstore.master" type="text"
			class="easyui-textbox" data-options="prompt:'请输入联系人',icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
			
		<td class="sp-td1">联系人电话：</td>
		<td><input name="t_Bus_Equipstore.linkmantel" type="text"
			class="easyui-textbox" data-options="validType:'phone',icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">联系人手机：</td>
		<td><input name="t_Bus_Equipstore.linkmanphone" type="text"
			class="easyui-textbox" data-options="validType:'mobile',icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">联系人邮箱：</td>
		<td><input name="t_Bus_Equipstore.linkmanemail" type="text"
			class="easyui-textbox" data-options="validType:'email',icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">数据来源单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Equipstore.sourcedept"
			data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'"
			style="width:180px;"></td>
		
		</tr>
		<tr>
		<td class="sp-td1">保质期：</td>
		<td><input type="text" name="t_Bus_Equipstore.quaguaperiod"
			class="easyui-datebox" style="width: 180px;"
			data-options="editable:false,icons:iconClear,value:'${nowdate}'" /></td>
		
		<td class="sp-td1">最近更新时间：</td>
		<td><input type="text" name="t_Bus_Equipstore.updatetime"
			class="easyui-datetimebox" style="width: 180px;"
			data-options="editable:false,disabled:true,value:'${nowdate}'" /></td>	
		</tr>
		
		<tr>
		<td class="sp-td1">运输方式：</td>
		<td colspan="3"><input name="t_Bus_Equipstore.conveymode" type="text"
			class="easyui-textbox" data-options="prompt:'请输入运输方式或运输条件',icons:iconClear"
			style="width:534px;" /></td>
		</tr>
		<tr>
		
		<td class="sp-td1">日常使用情况：</td>
		<td colspan="3"><input name="t_Bus_Equipstore.usedesc" type="text"
			class="easyui-textbox" data-options="prompt:'请输入日常使用情况',icons:iconClear"
			style="width:534px;" /></td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">装备描述：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.equipdesc"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.remark"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
