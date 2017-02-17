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
<form id="troubleinfo_form" method="post" action="<%=basePath%>Main/troubleinfo/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">隐患点名称：</td>
		    <td>
		    <input id="hidtrubname" name="t_Bus_Hidtrub.hidtrubname" data-options="required:true" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">隐患点类别：</td>
		    <td>
		    <select name="t_Bus_Hidtrub.hidtrubtype" data-options="required:true,value:'${pcode}'" class="easyui-combobox" editable="false" panelHeight="auto" code="YHDLB" style="width:200px;"></select>
		    </td>
		    <td class="sp-td1">危险程度：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrubclass" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">所属单位：</td>
		    <td>
		    <input type="text" class="easyui-combotree"  name="t_Bus_Hidtrub.hidtrubdeptid" 
		    		 data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get'" style="width:200px;"/>
		    </td>
		    <td class="sp-td1">隐患点经度：</td>
		    <td>
		     <input id="pointx" name="t_Bus_Hidtrub.longitude" type="text" class="easyui-textbox" data-options="icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">隐患点纬度：</td>
		    <td>
		    <input id="pointy" name="t_Bus_Hidtrub.latitude" type="text" class="easyui-textbox" data-options="editable:'false'" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">隐患点电话：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrubtel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">隐患点传真：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrubfax" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">巡查单位：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.checkdept" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">巡查人：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrublinker" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">巡查人电话：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrublinkertel" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">巡查人手机：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrublinkermob" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">巡查日期：</td>
		    <td>
		    <input name="t_Bus_Hidtrub.hidtrubdate" type="text" class="easyui-datetimebox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">隐患点地址：</td>
		    <td colspan="3">
		    <input id="hidtrubaddr" name="t_Bus_Hidtrub.hidtrubaddr" data-options="required:true" type="text" class="easyui-textbox" style="width: 620px;"/>
		    </td>
		    </tr>
		    <tr>
			<td class="sp-td1">隐患原因：</td>
			<td colspan="5"><textarea name="t_Bus_Hidtrub.hidtrubdetail" class="textarea" data-options="validType:'length[0,1000]'"
					style="width:970px; height: 50px;"></textarea></td>
		    </tr>
		    <tr>
			<td class="sp-td1">情况说明：</td>
			<td colspan="5"><textarea name="t_Bus_Hidtrub.hidtrubresult" class="textarea" data-options="validType:'length[0,1000]'"
					style="width:970px; height: 50px;"></textarea></td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td colspan="5"><textarea name="t_Bus_Hidtrub.note" class="textarea" data-options="validType:'length[0,1000]'"
					style="width:970px; height: 50px;"></textarea></td>
		    </tr>
    </table>
</form>
