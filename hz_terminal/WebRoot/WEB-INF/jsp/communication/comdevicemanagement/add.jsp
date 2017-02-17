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
<form id="device_form" method="post" action="<%=basePath%>Main/comdevicemanagement/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">设备类型：</td>
		    <td>
		    <select name="t_DeviceInfo.dtype" data-options="required:true,value:'${pcode}'" class="easyui-combobox" editable="false" panelHeight="auto" code="TXSBLX" style="width:200px;"></select></td>
		    <td class="sp-td1">设备名称：</td>
		    <td><input id="dname" name="t_DeviceInfo.dname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备编码：</td>
		    <td>
		    <input name="t_DeviceInfo.dcode" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    <td class="sp-td1">设备地址：</td>
		    <td><input name="t_DeviceInfo.address" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">用户名：</td>
		    <td>
		    <input name="t_DeviceInfo.username" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    <td class="sp-td1">用户密码：</td>
		    <td><input name="t_DeviceInfo.pass" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备IP：</td>
		    <td>
		    <input id="dip" name="t_DeviceInfo.ip" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    <td class="sp-td1">设备端口：</td>
		    <td><input name="t_DeviceInfo.port" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">服务名称：</td>
		    <td>
		    <input name="t_DeviceInfo.servername" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    <td class="sp-td1">设备参数：</td>
		    <td><input name="t_DeviceInfo.dpara" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备组号：</td>
		    <td>
		    <input id="dgroup" name="t_DeviceInfo.dgroup" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    <td class="sp-td1">通道号：</td>
		    <td><input id="dchannel" name="t_DeviceInfo.channel" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="t_DeviceInfo.pointx" type="text" class="easyui-textbox" data-options="required:true,icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="t_DeviceInfo.pointy" type="text" class="easyui-textbox" data-options="required:true,editable:'false'" style="width: 200px;"/></td>
		    </tr>
    </table>
</form>
