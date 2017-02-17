<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">

function DTClick(){
	$.lauvan.openGisDialog($("#longitude").val(),$("#latitude").val(),function(lng,lat){
		$("#longitude").textbox('setValue',lng);
		$("#latitude").textbox('setValue',lat);
	});
}

</script>
	  <form id="shelterEdit" method="post" action="<%=basePath%>Main/shelter/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="update"/>
	  <input type="hidden" name="t_Bus_Shelter.she_id" value="${model.she_id }"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">编号：</td>
		    	<td ><input name="t_Bus_Shelter.code" type="text" data-options="required:true,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;" value="${model.code }"/>    </td>
		    	 
		  		<td class="sp-td1">避难场所名称：</td>
		    	<td><input name="t_Bus_Shelter.name" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入避难场所名称',required:true,icons:iconClear"  style="width:180px;" value="${model.name }"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">类别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Shelter.type"  panelHeight="auto" code="SHTYPE" 
		    	style="width: 180px;" data-options="editable:false,required:true,value:'${model.type}'" ></select>
		    	</td>
		    	
		  		<td class="sp-td1">所属单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_Shelter.organid"
		    		 data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'" style="width:180px;">
		    	</td>
		  		</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">面积：</td>
		    	<td><input name="t_Bus_Shelter.area" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入面积',icons:iconClear"  style="width:180px;" value="${model.area }"/>  </td>
		    	
		    	<td class="sp-td1">容纳人数：</td>
		    	<td ><input name="t_Bus_Shelter.galleryful" type="text" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;" value="${model.galleryful }"/>    </td></tr>
		    	
		    	<tr>
		    	<td class="sp-td1">经度：</td>
		    	<td><input name="t_Bus_Shelter.longitude" id="longitude" type="text" class="easyui-searchbox" data-options="editable:false,searcher:DTClick,value:'${model.longitude}'"
		    	  style="width:180px;" />  </td>
		  		
		  		<td class="sp-td1">纬度：</td>
		    	<td ><input name="t_Bus_Shelter.latitude" id="latitude"  type="text" class="easyui-textbox" data-options="readonly:true"
		    	 style="width:180px;" value="${model.latitude }"/>    </td>
		    	 </tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td><input name="t_Bus_Shelter.linkman" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入联系人',icons:iconClear"  style="width:180px;" value="${model.linkman }"/>  </td>
		    	
		  		<td class="sp-td1">联系人电话：</td>
		    	<td><input name="t_Bus_Shelter.linkmantel" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;" value="${model.linkmantel }"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">避难所电话：</td>
		    	<td><input name="t_Bus_Shelter.sheltertel" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;" value="${model.sheltertel }"/>  </td>
		    	
		  		<td class="sp-td1">传真：</td>
		    	<td ><input name="t_Bus_Shelter.fax" type="text" data-options="validType:'faxno',icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;" value="${model.fax}"/>    </td>
		    	 </tr>
		    	 
		    	<tr>
		    	<td class="sp-td1">所在地址：</td>
		    	<td colspan="3"><input name="t_Bus_Shelter.address" type="text" class="easyui-textbox" 
		    	data-options="required:true,prompt:'请输入所在地址',icons:iconClear"  style="width:564px;" value="${model.address }"/>  </td>
		    	</tr>

		    	<tr>
		    	<td class="sp-td1">用途：</td>
		    	<td colspan="3"><input name="t_Bus_Shelter.use" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入用途',icons:iconClear"  style="width:564px;" value="${model.use }"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">备注</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Shelter.remark" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 564px;height: 50px;" >${model.remark }</textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
