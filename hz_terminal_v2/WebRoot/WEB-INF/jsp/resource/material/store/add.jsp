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
	alert("地图");
}
</script>
	  <form id="storeAdd" method="post" action="<%=basePath%>Main/store/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="add"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">编号：</td>
		    	<td ><input name="t_Bus_Store.sto_code" type="text" data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;"/>    </td>
		    	 
		  		<td class="sp-td1">物资名称：</td>
    	        <td >
	    		<input type="hidden" name="t_Bus_Store.materialid" id="materialid"/>
	    		<input type="text" id="materialname" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 150px;"/>
	    		<a id="btn" onclick="findMaterial()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
	    	    </td>
		    	
		    	<tr>
		    	<td class="sp-td1">存放数量：</td>
		    	<td ><input name="t_Bus_Store.num" type="text" data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" 
		    	 style="width:180px;"/>    </td>
		  		
		  		<td class="sp-td1">所在仓库：</td>
			    	<td >
			    		<input type="hidden" name="t_Bus_Store.repertoryid" id="repertoryid"/>
			    		<input type="text" id="repertoryname" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 150px;"/>
			    		<a id="btn" onclick="findRepertory()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
		  		</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">所属单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_Store.organid" data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'" style="width:180px;">
		    	</td>
		    	
		  		<td class="sp-td1">级别：</td>
		    	<td ><select class="easyui-combobox" name="t_Bus_Store.levelcode"  panelHeight="auto" code="MALEVE" style="width: 180px;" data-options="editable:false" ></select></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">存放地点：</td>
		    	<td ><input name="t_Bus_Store.depositplace" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入存放地点',icons:iconClear"  style="width:180px;"/>    </td>
		    	 
		    	<td class="sp-td1">负责人：</td>
		    	<td><input name="t_Bus_Store.master" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入负责人姓名',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">负责人电话：</td>
		    	<td><input name="t_Bus_Store.mastertel" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">负责人手机：</td>
		    	<td><input name="t_Bus_Store.masterphone" type="text" class="easyui-textbox" 
		    	data-options="validType:'mobile',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td><input name="t_Bus_Store.linkman" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入联系人',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">联系人电话：</td>
		    	<td><input name="t_Bus_Store.linkmantel" type="text" class="easyui-textbox" 
		    	data-options="validType:'phone',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">联系人手机：</td>
		    	<td><input name="t_Bus_Store.linkmanphone" type="text" class="easyui-textbox" 
		    	data-options="validType:'mobile',icons:iconClear"  style="width:180px;"/>  </td>
		    	
		    	<td class="sp-td1">联系人邮箱：</td>
		    	<td><input name="t_Bus_Store.linkmanemail" type="text" class="easyui-textbox" 
		    	data-options="validType:'email',icons:iconClear"  style="width:180px;"/>  </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">计量单位：</td>
		    	<td ><select class="easyui-combobox" name="t_Bus_Store.measureunit"  panelHeight="auto" code="MAUNIT" style="width: 180px;" data-options="editable:false" ></select></td>
		    	
		    	<td class="sp-td1">保质期：</td>
		    	<td><input type="text"  name="t_Bus_Store.quaguaperiod"  class="easyui-datebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${nowdate}'"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">需要更换日期：</td>
		    	<td><input type="text"  name="t_Bus_Store.renewtime"  class="easyui-datebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear,value:'${nowdate}'"/></td>
		    	
		    	<td class="sp-td1">最近更新日期：</td>
		    	<td><input type="text"  name="t_Bus_Store.updatetime"  class="easyui-datetimebox"   style="width: 180px;"  data-options="disabled:true,editable:false,value:'${nowdate}'"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">物资描述：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Store.materialdesc" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">备注：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Store.remark" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
		    	
	    </table>
	    </div>
    </form>
