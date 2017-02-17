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
		    <td class="sp-td1">隐患点名称：</td>
		    <td style="width:20%">
		    ${hidtrub.hidtrubname}
		    </td>
		    <td class="sp-td1">隐患点类别：</td>
		    <td style="width:20%">
		     ${str:translate(hidtrub.hidtrubtype,'YHDLB')}
		    </td>
		    <td class="sp-td1">危险程度：</td>
		    <td style="width:20%">
		    ${hidtrub.hidtrubclass}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">所属单位：</td>
		    <td>
		    ${hidtrub.hidtrubdept }
		    </td>
		     <td class="sp-td1">隐患点经度：</td>
		    <td>
		     <input id="pointx" name="t_Bus_Hidtrub.longitude" value="${hidtrub.longitude}"  type="text" class="easyui-textbox" data-options="icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">隐患点纬度：</td>
		    <td>
		    <input id="pointy" name="t_Bus_Hidtrub.latitude" value="${hidtrub.latitude}" type="text" class="easyui-textbox" data-options="editable:'false'" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">隐患点电话：</td>
		    <td>
		    ${hidtrub.hidtrubtel}
		    </td>
		    <td class="sp-td1">隐患点传真：</td>
		    <td>
		    ${hidtrub.hidtrubfax}
		    </td>
		    <td class="sp-td1">巡查单位：</td>
		    <td>
		    ${hidtrub.checkdept}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">巡查人：</td>
		    <td>
		    ${hidtrub.hidtrublinker}
		    </td>
		    <td class="sp-td1">巡查人电话：</td>
		    <td>
		    ${hidtrub.hidtrublinkertel}
		    </td>
		    <td class="sp-td1">巡查人手机：</td>
		    <td>
		    ${hidtrub.hidtrublinkermob}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">巡查日期：</td>
		    <td>
		    ${hidtrub.hidtrubdate}
		    </td>
		    <td class="sp-td1">隐患点地址：</td>
		    <td colspan="3">
		    ${hidtrub.hidtrubaddr}
		    </td>
		    </tr>
		    <tr>
			<td class="sp-td1">隐患原因：</td>
			<td colspan="5">${hidtrub.hidtrubdetail}</td>
		    </tr>
		    <tr>
			<td class="sp-td1">情况说明：</td>
			<td colspan="5">${hidtrub.hidtrubresult}</td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td colspan="5">${hidtrub.note}</td>
		    </tr>
    </table>
