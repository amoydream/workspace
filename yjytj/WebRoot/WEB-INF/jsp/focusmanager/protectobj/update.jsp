<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/include/inc.jsp"%>
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
<form id="protectobj_form" method="post" action="<%=basePath%>Main/protectobj/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_Bus_DefenceObj.defobjid" value="${defenceobj.defobjid}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">统一标识码：</td>
		    <td>
		    <input  name="t_Bus_DefenceObj.nucode" value="${defenceobj.nucode}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">名称：</td>
		    <td>
		    <input id="defobjname" value="${defenceobj.defobjname}" name="t_Bus_DefenceObj.defobjname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">类型代码：</td>
		    <td>
		    <input id="defobjtypecode" name="t_Bus_DefenceObj.defobjtypecode" type="hidden" value="${defenceobj.defobjtypecode}"/>
		    <input id="defobjtypename" value="${str:translate(defenceobj.defobjtypecode,'FHMBFL')}" type="text" data-options="required:true,editable:false,disabled:true" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">级别代码：</td>
		    <td>
		    <select id="levelcode" name="t_Bus_DefenceObj.levelcode" code="ZDFHJBDM" class="easyui-combobox" data-options="required:true,editable:false,value:'${defenceobj.levelcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">密级代码：</td>
		    <td>
		    <select name="t_Bus_DefenceObj.classcode" code="ZDFHMJDM" class="easyui-combobox" data-options="editable:false,value:'${defenceobj.classcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">值班电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.dutytel" value="${defenceobj.dutytel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">所属单位：</td>
		    <td>
		    <input type="text" class="easyui-combotree"  name="t_Bus_DefenceObj.deptid" value="${defenceobj.deptid }"
		    		 data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get'" style="width:200px;"/>
		    </td>
		    <td class="sp-td1">地址：</td>
		    	<td colspan="3">
		    	<input id="districtcode" value="${defenceobj.districtcode}" class="easyui-combotree" name="t_Bus_DefenceObj.districtcode" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true,icons:iconClear" style="width:200px;">
		    	(镇/街道)
		    	<input type="text" id="address" value="${defenceobj.address}" name="t_Bus_DefenceObj.address" data-options="prompt:'请输入地址',required:true,icons:iconClear" class="easyui-textbox" style="width: 352px;"/></td>
		   <%-- <td class="sp-td1">数据来源单位：</td>
		    <td>
		    <select id="sourcedeptcode" name="t_Bus_DefenceObj.sourcedeptcode" code="ZDFHSJLYDW" class="easyui-combobox" data-options="required:true,value:'${defenceobj.sourcedeptcode}',editable:false,icons:iconClear" panelHeight="100px;" style="width: 200px;"></select>
		    </td> --%>
		    </tr>
		    <tr>
		    <td class="sp-td1">传真：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.fax" value="${defenceobj.fax}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.respper" value="${defenceobj.respper}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人办公电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.respotel" value="${defenceobj.respotel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">负责人移动电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.respmtel" value="${defenceobj.respmtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人住宅电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.resphtel" value="${defenceobj.resphtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.contactper" value="${defenceobj.contactper}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人办公电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.contactotel" value="${defenceobj.contactotel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人移动电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.contactmtel" value="${defenceobj.contactmtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人住宅电话：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.contacthtel" value="${defenceobj.contacthtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人电子邮箱：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.contactemail" value="${defenceobj.contactemail}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">高层基准代码：</td>
		    <td>
		    <select  name="t_Bus_DefenceObj.elevadatumcode" code="ZDFHGCJZ" class="easyui-combobox" data-options="editable:false,value:'${defenceobj.elevadatumcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">高程：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.elevadation" value="${defenceobj.elevadation}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">主管单位：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.chargedept" value="${defenceobj.chargedept}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">主管单位地址：</td>
		    	<td colspan="3">
		    	<input name="t_Bus_DefenceObj.cdeptaddress" value="${defenceobj.cdeptaddress}" type="text" class="easyui-textbox" style="width: 610px;"/>
		    	</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">坐标系统代码：</td>
		    <td>
		    <select  name="t_Bus_DefenceObj.coordsyscode" code="ZDFHZBXT" class="easyui-combobox" data-options="editable:false,value:'${defenceobj.coordsyscode }',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="t_Bus_DefenceObj.longitude" value="${defenceobj.longitude}" type="text" class="easyui-textbox" data-options="icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="t_Bus_DefenceObj.latitude" value="${defenceobj.latitude}" type="text" class="easyui-textbox" data-options="editable:'false'" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">面积：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.area" value="${defenceobj.area}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">人数：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.personnum" value="${defenceobj.personnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">周边交通情况：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.traffic" value="${defenceobj.traffic}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">投入使用时间：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.inusedate" value="${defenceobj.inusedate}" type="text" class="easyui-datetimebox" data-options="editable:false" style="width: 200px;"/>    
		    </td>
		     <td class="sp-td1">设计使用年限：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.useyearnum" value="${defenceobj.useyearnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">应急通信方式：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.commtype" value="${defenceobj.commtype}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">受灾形式：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.disasterform" value="${defenceobj.disasterform}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">防护等级代码：</td>
		    <td>
		    <select  name="t_Bus_DefenceObj.deflevelcode" code="ZDFHFHDJ" class="easyui-combobox" data-options="value:'${defenceobj.deflevelcode }',editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">防护区域：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.defencearea" value="${defenceobj.defencearea}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">可接纳人数：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.maxpersonnum" value="${defenceobj.maxpersonnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">监测方式：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.monitmode" value="${defenceobj.monitmode}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">防护措施：</td>
		    <td>
		    <input name="t_Bus_DefenceObj.defencestep" value="${defenceobj.defencestep}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">基本情况：</td>
			<td colspan="3"><textarea  name="t_Bus_DefenceObj.description" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 545px; height: 50px;">${defenceobj.description}</textarea></td>
			<td class="sp-td1">备注：</td>
			<td><textarea  name="t_Bus_DefenceObj.notes" class="textarea" data-options="validType:'length[0,200]'"
					style="width: 200px; height: 50px;">${defenceobj.notes}</textarea></td>
		    </tr>
    </table>
</form>
