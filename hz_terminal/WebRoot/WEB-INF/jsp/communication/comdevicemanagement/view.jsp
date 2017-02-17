<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
function getPoint(){
	$.lauvan.openGisDialog($("#pointx").val(),$("#pointy").val(),function(lng,lat){
	});
	
}
</script>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">设备类型：</td>
		    <td>
		    ${str:translate(dif.dtype,'TXSBLX')}
		    <td class="sp-td1">设备名称：</td>
		    <td>${dif.dname }</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备编码：</td>
		    <td>
		    ${dif.dcode}</td>
		    <td class="sp-td1">设备地址：</td>
		    <td>${dif.address}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">用户名：</td>
		    <td>
		    ${dif.username}</td>
		    <td class="sp-td1">用户密码：</td>
		    <td>XXXXXXX</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备IP：</td>
		    <td>
		    ${dif.ip}</td>
		    <td class="sp-td1">设备端口：</td>
		    <td>${dif.port}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">服务名称：</td>
		    <td>
		    ${dif.servername}</td>
		    <td class="sp-td1">设备参数：</td>
		    <td>${dif.dpara}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">设备组号：</td>
		    <td>
		    ${dif.dgroup}</td>
		    <td class="sp-td1">通道号：</td>
		    <td>${dif.channel}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="t_DeviceInfo.pointx" type="text" value="${dif.pointx}" class="easyui-textbox" data-options="required:true,icons:[{iconCls:'icon-world',handler:getPoint}]" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="t_DeviceInfo.pointy" type="text" value="${dif.pointy}" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    </tr>
    </table>
