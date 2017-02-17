<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function getPoint(){
	$.lauvan.openGisDialog($("#pointx").val(),$("#pointy").val(),function(lng,lat){
		$("#pointx").textbox('setValue',lng);
		$("#pointy").textbox('setValue',lat);
	});
	
}
</script>
<form id="danger_form" method="post" action="<%=basePath%>Main/danger/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">统一标识码：</td>
		    <td>
		    <input  name="t_Bus_Danger.nucode" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">名称：</td>
		    <td>
		    <input id="dangername"  name="t_Bus_Danger.dangername" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">类型代码：</td>
		    <td>
		    <input id="dangertypecode" name="t_Bus_Danger.dangertypecode" type="hidden"/>
		    <input id="dangertypename"  type="text" data-options="required:true,editable:false" class="easyui-textbox" style="width: 200px;"/><a id="btn1" onclick="finddangertype()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">级别代码：</td>
		    <td>
		    <select id="levelcode"  name="t_Bus_Danger.levelcode" code="ZDFHJBDM" class="easyui-combobox" data-options="required:true,editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">密级代码：</td>
		    <td>
		    <select name="t_Bus_Danger.classcode" code="ZDFHMJDM" class="easyui-combobox" data-options="editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">值班电话：</td>
		    <td>
		    <input name="t_Bus_Danger.dutytel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">所属单位：</td>
		    <td>
		    <input type="text" class="easyui-combotree"  name="t_Bus_Danger.deptid" 
		    		 data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get'" style="width:200px;"/>
		    </td>
		    <td class="sp-td1">地址：</td>
		    	<td colspan="3">
		    	<input id="districtcode" class="easyui-combotree" name="t_Bus_Danger.districtcode" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true,icons:iconClear" style="width:200px;">
		    	(镇/街道)
		    	<input type="text" id="address" name="t_Bus_Danger.address" data-options="prompt:'请输入地址',required:true,icons:iconClear" class="easyui-textbox" style="width: 352px;"/></td>
		   <!-- <td class="sp-td1">数据来源单位：</td>
		    <td>
		    <select id="sourcedeptcode" name="t_Bus_Danger.sourcedeptcode" code="ZDFHSJLYDW" class="easyui-combobox" data-options="required:true,editable:false,icons:iconClear" panelHeight="100px;" style="width: 200px;"></select>
		    </td> -->
		    </tr>
		    <tr>
		    <td class="sp-td1">传真：</td>
		    <td>
		    <input name="t_Bus_Danger.fax" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人：</td>
		    <td>
		    <input name="t_Bus_Danger.respper" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人办公电话：</td>
		    <td>
		    <input name="t_Bus_Danger.respotel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">负责人移动电话：</td>
		    <td>
		    <input name="t_Bus_Danger.respmtel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人住宅电话：</td>
		    <td>
		    <input name="t_Bus_Danger.resphtel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    <input name="t_Bus_Danger.contactper" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人办公电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contactotel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人移动电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contactmtel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人住宅电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contacthtel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人电子邮箱：</td>
		    <td>
		    <input name="t_Bus_Danger.contactemail" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">高层基准代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.elevadatumcode" code="ZDFHGCJZ" class="easyui-combobox" data-options="editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">高程：</td>
		    <td>
		    <input name="t_Bus_Danger.elevadation" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">主管单位：</td>
		    <td>
		    <input name="t_Bus_Danger.chargedept" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">主管单位地址：</td>
		    	<td colspan="3">
		    	<input name="t_Bus_Danger.cdeptaddress" type="text" class="easyui-textbox" style="width: 610px;"/>
		    	</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">坐标系统代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.coordsyscode" code="ZDFHZBXT" class="easyui-combobox" data-options="editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="t_Bus_Danger.longitude" type="text" class="easyui-textbox" data-options="icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="t_Bus_Danger.latitude" type="text" class="easyui-textbox" data-options="editable:'false'" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">面积：</td>
		    <td>
		    <input name="t_Bus_Danger.area" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">人数：</td>
		    <td>
		    <input name="t_Bus_Danger.personnum" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">周边交通情况：</td>
		    <td>
		    <input name="t_Bus_Danger.traffic" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">投入使用时间：</td>
		    <td>
		    <input name="t_Bus_Danger.inusedate" type="text" class="easyui-datetimebox" data-options="editable:false" style="width: 200px;"/>    
		    </td>
		     <td class="sp-td1">设计使用年限：</td>
		    <td>
		    <input name="t_Bus_Danger.useyearnum" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">应急通信方式：</td>
		    <td>
		    <input name="t_Bus_Danger.commtype" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">可能灾害形式：</td>
		    <td>
		    <input name="t_Bus_Danger.possibledanger" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">危险等级代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.hazardlevelcode" code="WXDJDM" class="easyui-combobox" data-options="editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">影响范围：</td>
		    <td>
		    <input name="t_Bus_Danger.effectarea" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">威胁人数：</td>
		    <td>
		    <input name="t_Bus_Danger.maxpersonnum" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">监测方式：</td>
		    <td>
		    <input name="t_Bus_Danger.monitmode" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">治理措施：</td>
		    <td>
		    <input name="t_Bus_Danger.treatstep" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">基本情况：</td>
			<td colspan="3"><textarea  name="t_Bus_Danger.description" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 545px; height: 50px;"></textarea></td>
			<td class="sp-td1">备注：</td>
			<td><textarea  name="t_Bus_Danger.notes" class="textarea" data-options="validType:'length[0,200]'"
					style="width: 200px; height: 50px;"></textarea></td>
		    </tr>
    </table>
</form>
