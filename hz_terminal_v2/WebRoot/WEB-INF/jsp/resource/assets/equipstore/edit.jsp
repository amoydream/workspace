<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#longitude").val(),$("#latitude").val(),function(lng,lat){
		$("#longitude").textbox('setValue',lng);
		$("#latitude").textbox('setValue',lat);
	});
}

</script>

	  <form id="equipstoreEdit" method="post" action="<%=basePath%>Main/equipstore/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="edit"/>
	  <input type="hidden" name="t_Bus_Equipstore.eqs_id" value="${model.eqs_id}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">编号：</td>
		<td><input name="t_Bus_Equipstore.code" value="${model.code}" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>
	    
	    <td class="sp-td1">装备名称：</td>
		<td >
    		<input type="hidden" name="t_Bus_Equipstore.equipnameid" id="equipnameid" value="${model.equipnameid}"/>
    		<input type="text" id="equipname" value="${equipname}" data-options="readonly:true" class="easyui-textbox" style="width: 150px;"/>
    		<a id="btn" onclick="findEquipname()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
    	</td>
		
		</tr>
		<tr>
			
		<td class="sp-td1">数量：</td>
		<td><input name="t_Bus_Equipstore.equipnum" value="${model.equipnum}" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>
		
		<td class="sp-td1">所属单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Equipstore.organid"
			data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'"
			style="width:180px;"></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">存放地址：</td>
		<td colspan="3"><input name="t_Bus_Equipstore.address" value="${model.address}" type="text"
			class="easyui-textbox" data-options="required:true,prompt:'请输入存放地址',icons:iconClear"
			style="width:534px;" /></td>
		
		</tr>
		<tr>

		<td class="sp-td1">经度：</td>
		<td><input id="longitude" name="t_Bus_Equipstore.longitude"
			value="${model.longitude}" type="text" class="easyui-textbox"
			style="width: 180px;"
			data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]" />
		</td>

		<td class="sp-td1">纬度：</td>
		<td><input id="latitude" name="t_Bus_Equipstore.latitude"
			type="text" class="easyui-textbox" style="width: 180px;"
			data-options="readonly:true" value="${model.latitude}" /></td>

		</tr>    	
		<tr>
			
		<td class="sp-td1">级别：</td>
		<td><select class="easyui-combobox" name="t_Bus_Equipstore.levelcode"
			panelHeight="auto" code="MALEVE" style="width: 180px;"
			data-options="editable:false,value:'${model.levelcode}'"></select></td>
		
		<td class="sp-td1">联系人：</td>
		<td><input name="t_Bus_Equipstore.linkman" value="${model.linkman}" type="text"
			class="easyui-textbox" data-options="icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
			
		<td class="sp-td1">联系人电话：</td>
		<td><input name="t_Bus_Equipstore.linkmantel" value="${model.linkmantel}" type="text"
			class="easyui-textbox" data-options="validType:'phone',icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">联系人手机：</td>
		<td><input name="t_Bus_Equipstore.linkmanphone" value="${model.linkmanphone}" type="text"
			class="easyui-textbox" data-options="validType:'mobile',icons:iconClear"
			style="width:180px;" /></td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">联系人邮箱：</td>
		<td><input name="t_Bus_Equipstore.linkmanemail" value="${model.linkmanemail}" type="text"
			class="easyui-textbox" data-options="validType:'email',icons:iconClear"
			style="width:180px;" /></td>
		
		<td class="sp-td1">数据来源单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Equipstore.sourcedept"
			data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.sourcedept}'"
			style="width:180px;"></td>
		
		</tr>
		<tr>
		<td class="sp-td1">保质期：</td>
		<td><input type="text" name="t_Bus_Equipstore.quaguaperiod"
			class="easyui-datebox" style="width: 180px;"
			data-options="editable:false,value:'${model.quaguaperiod}'" /></td>
		
		<td class="sp-td1">最近更新日期：</td>
		<td><input type="text" name="t_Bus_Equipstore.updatetime"
			class="easyui-datetimebox" style="width: 180px;"
			data-options="disabled:true,editable:false,value:'${model.updatetime}'" /></td>	
		</tr>
		
		<tr>
		<td class="sp-td1">运输方式：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.conveymode"
				class="textarea" data-options="prompt:'请输入运输方式或运输条件',validType:'length[0,500]'"
				style="width: 534px;height: 50px;">${model.conveymode}</textarea></td>	
		</tr>
		<tr>
		
		<td class="sp-td1">日常使用情况：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.usedesc"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 534px;height: 50px;">${model.usedesc}</textarea></td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">装备描述：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.equipdesc"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 540px;height: 50px;">${model.equipdesc}</textarea></td>	
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3"><textarea name="t_Bus_Equipstore.remark"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 540px;height: 50px;">${model.remark}</textarea></td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
    </form>
