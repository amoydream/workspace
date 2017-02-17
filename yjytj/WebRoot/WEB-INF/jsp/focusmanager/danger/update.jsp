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
<form id="danger_form" method="post" action="<%=basePath%>Main/danger/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_Bus_Danger.dangerid" value="${danger.dangerid}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">统一标识码：</td>
		    <td>
		    <input  name="t_Bus_Danger.nucode" value="${danger.nucode}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">名称：</td>
		    <td>
		    <input id="dangername" value="${danger.dangername}" name="t_Bus_Danger.dangername" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">类型代码：</td>
		    <td>
		    <input id="dangertypecode" name="t_Bus_Danger.dangertypecode" type="hidden" value="${danger.dangertypecode}"/>
		    <input id="dangertypename" value="${str:translate(danger.dangertypecode,'WXYFXYHQFL')}" type="text" data-options="required:true,editable:false,disabled:true" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">级别代码：</td>
		    <td>
		    <select id="levelcode" name="t_Bus_Danger.levelcode" code="ZDFHJBDM" class="easyui-combobox" data-options="required:true,editable:false,value:'${danger.levelcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">密级代码：</td>
		    <td>
		    <select name="t_Bus_Danger.classcode" code="ZDFHMJDM" class="easyui-combobox" data-options="editable:false,value:'${danger.classcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">值班电话：</td>
		    <td>
		    <input name="t_Bus_Danger.dutytel" value="${danger.dutytel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">所属单位：</td>
		    <td>
		    <input type="text" class="easyui-combotree"  name="t_Bus_Danger.deptid" value="${danger.deptid }"
		    		 data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get'" style="width:200px;"/>
		    </td>
		    <td class="sp-td1">地址：</td>
		    	<td colspan="3">
		    	<input id="districtcode" value="${danger.districtcode}" class="easyui-combotree" name="t_Bus_Danger.districtcode" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true,icons:iconClear" style="width:200px;">
		    	(镇/街道)
		    	<input type="text" id="address" value="${danger.address}" name="t_Bus_Danger.address" data-options="prompt:'请输入地址',required:true,icons:iconClear" class="easyui-textbox" style="width: 352px;"/></td>
		   <%-- <td class="sp-td1">数据来源单位：</td>
		    <td>
		    <select id="sourcedeptcode" name="t_Bus_Danger.sourcedeptcode" code="ZDFHSJLYDW" class="easyui-combobox" data-options="required:true,value:'${danger.sourcedeptcode}',editable:false,icons:iconClear" panelHeight="100px;" style="width: 200px;"></select>
		    </td> --%>
		    </tr>
		    <tr>
		    <td class="sp-td1">传真：</td>
		    <td>
		    <input name="t_Bus_Danger.fax" value="${danger.fax}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人：</td>
		    <td>
		    <input name="t_Bus_Danger.respper" value="${danger.respper}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人办公电话：</td>
		    <td>
		    <input name="t_Bus_Danger.respotel" value="${danger.respotel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">负责人移动电话：</td>
		    <td>
		    <input name="t_Bus_Danger.respmtel" value="${danger.respmtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">负责人住宅电话：</td>
		    <td>
		    <input name="t_Bus_Danger.resphtel" value="${danger.resphtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    <input name="t_Bus_Danger.contactper" value="${danger.contactper}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人办公电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contactotel" value="${danger.contactotel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人移动电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contactmtel" value="${danger.contactmtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">联系人住宅电话：</td>
		    <td>
		    <input name="t_Bus_Danger.contacthtel" value="${danger.contacthtel}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人电子邮箱：</td>
		    <td>
		    <input name="t_Bus_Danger.contactemail" value="${danger.contactemail}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">高层基准代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.elevadatumcode" code="ZDFHGCJZ" class="easyui-combobox" data-options="editable:false,value:'${danger.elevadatumcode}',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">高程：</td>
		    <td>
		    <input name="t_Bus_Danger.elevadation" value="${danger.elevadation}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">主管单位：</td>
		    <td>
		    <input name="t_Bus_Danger.chargedept" value="${danger.chargedept}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">主管单位地址：</td>
		    	<td colspan="3">
		    	<input name="t_Bus_Danger.cdeptaddress" value="${danger.cdeptaddress}" type="text" class="easyui-textbox" style="width: 610px;"/>
		    	</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">坐标系统代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.coordsyscode" code="ZDFHZBXT" class="easyui-combobox" data-options="editable:false,value:'${danger.coordsyscode }',icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">经度：</td>
		    <td>
		    <input id="pointx" name="t_Bus_Danger.longitude" value="${danger.longitude}" type="text" class="easyui-textbox" data-options="icons:[{iconCls:'icon-world',handler:getPoint}],editable:'false'" style="width: 200px;"/></td>
		    <td class="sp-td1">纬度：</td>
		    <td><input id="pointy" name="t_Bus_Danger.latitude" value="${danger.latitude}" type="text" class="easyui-textbox" data-options="editable:'false'" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">面积：</td>
		    <td>
		    <input name="t_Bus_Danger.area" value="${danger.area}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">人数：</td>
		    <td>
		    <input name="t_Bus_Danger.personnum" value="${danger.personnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">周边交通情况：</td>
		    <td>
		    <input name="t_Bus_Danger.traffic" value="${danger.traffic}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">投入使用时间：</td>
		    <td>
		    <input name="t_Bus_Danger.inusedate" value="${danger.inusedate}" type="text" class="easyui-datetimebox" data-options="editable:false" style="width: 200px;"/>    
		    </td>
		     <td class="sp-td1">设计使用年限：</td>
		    <td>
		    <input name="t_Bus_Danger.useyearnum" value="${danger.useyearnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">应急通信方式：</td>
		    <td>
		    <input name="t_Bus_Danger.commtype" value="${danger.commtype}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		     <tr>
		    <td class="sp-td1">可能灾害形式：</td>
		    <td>
		    <input name="t_Bus_Danger.possibledanger" value="${danger.possibledanger}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">危险等级代码：</td>
		    <td>
		    <select  name="t_Bus_Danger.hazardlevelcode" code="WXDJDM" class="easyui-combobox" data-options="value:'${danger.hazardlevelcode }',editable:false,icons:iconClear" panelHeight="auto" style="width: 200px;"></select>
		    </td>
		    <td class="sp-td1">影响范围：</td>
		    <td>
		    <input name="t_Bus_Danger.effectarea" value="${danger.effectarea}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">威胁人数：</td>
		    <td>
		    <input name="t_Bus_Danger.maxpersonnum" value="${danger.maxpersonnum}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">监测方式：</td>
		    <td>
		    <input name="t_Bus_Danger.monitmode" value="${danger.monitmode}" type="text" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    <td class="sp-td1">治理措施：</td>
		    <td>
		    <input name="t_Bus_Danger.treatstep" type="text" value="${danger.treatstep}" class="easyui-textbox" style="width: 200px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">基本情况：</td>
			<td colspan="3"><textarea  name="t_Bus_Danger.description" class="textarea" data-options="validType:'length[0,1000]'"
					style="width: 545px; height: 50px;">${danger.description}</textarea></td>
			<td class="sp-td1">备注：</td>
			<td><textarea  name="t_Bus_Danger.notes" class="textarea" data-options="validType:'length[0,200]'"
					style="width: 200px; height: 50px;">${danger.notes}</textarea></td>
		    </tr>
    </table>
</form>
