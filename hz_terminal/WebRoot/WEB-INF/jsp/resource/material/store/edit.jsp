<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">


</script>
	  <form id="storeEdit" method="post" action="<%=basePath%>Main/store/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="update"/>
	  <input type="hidden" name="t_Bus_Store.sto_id" value="${model.sto_id }"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">编号：</td>
		    	<td ><input name="t_Bus_Store.sto_code" value="${model.sto_code }" type="text" data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;"/>    </td>
		    	 
		  		<td class="sp-td1">物资名称：</td>
				<td >
		    		<input type="hidden" name="t_Bus_Store.materialid" id="materialid" value="${model.materialid}"/>
		    		<input type="text" id="materialname" value="${materialname}" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 150px;"/>
		    		<a id="btn" onclick="findMaterial()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
		    	</td>
		    	
		    	<tr>
		  		<td class="sp-td1">存放数量：</td>
		    	<td ><input name="t_Bus_Store.num" value="${model.num }" type="text" data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;"/>    </td>
		    	 
		    	<td class="sp-td1">所在仓库：</td>
		    	<td >
			    		<input type="hidden" name="t_Bus_Store.repertoryid" id="repertoryid" value="${model.repertoryid}"/>
			    		<input type="text" id="repertoryname" value="${repertoryname}" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 150px;"/>
			    		<a id="btn" onclick="findRepertory()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
			    </tr>
		    	
		    	<tr>
		    	<td class="sp-td1">所属单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_Store.organid"
		    		 data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'" style="width:180px;">
		    	</td>
		    	
		  		<td class="sp-td1">级别：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Store.levelcode"  panelHeight="auto" code="MALEVE" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.levelcode}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">存放地点：</td>
		    	<td ><input name="t_Bus_Store.depositplace" value="${model.depositplace }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入存放地点',icons:iconClear"  style="width:180px;"/>    </td>
		    	 
		    	<td class="sp-td1">负责人：</td>
		    	<td><input name="t_Bus_Store.master" value="${model.master }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入负责人姓名',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">负责人电话：</td>
		    	<td><input name="t_Bus_Store.mastertel" value="${model.mastertel }" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">负责人手机：</td>
		    	<td><input name="t_Bus_Store.masterphone" value="${model.masterphone }" type="text" class="easyui-textbox" 
		    	data-options="validType:'mobile',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td><input name="t_Bus_Store.linkman" value="${model.linkman }" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入联系人',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">联系人电话：</td>
		    	<td><input name="t_Bus_Store.linkmantel" value="${model.linkmantel }" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人手机：</td>
		    	<td><input name="t_Bus_Store.linkmanphone" value="${model.linkmanphone }" type="text" class="easyui-textbox" 
		    	data-options="validType:'mobile',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">联系人邮箱：</td>
		    	<td><input name="t_Bus_Store.linkmanemail" value="${model.linkmanemail}" type="text" class="easyui-textbox" 
		    	data-options="validType:'email',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">计量单位 ：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Store.measureunit"  panelHeight="auto" code="MAUNIT" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.measureunit}'" ></select>
		    	</td>
		    	
		    	<td class="sp-td1">保质期：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_Store.quaguaperiod"  class="easyui-datebox"   
		    	style="width: 180px;"  data-options="editable:false,value:'${model.quaguaperiod}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">需要更换日期：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_Store.renewtime"  class="easyui-datebox"   
		    	style="width: 180px;"  data-options="editable:false,value:'${model.renewtime}'"/>
		    	</td>
		    	
		    	<td class="sp-td1">最近更新日期：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_Store.updatetime"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="disabled:true,editable:false,value:'${model.updatetime}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">物资描述：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Store.materialdesc" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" >${model.materialdesc}</textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">备注：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Store.remark" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" >${model.remark}</textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
