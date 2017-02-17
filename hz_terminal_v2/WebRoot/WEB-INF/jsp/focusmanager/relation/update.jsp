<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
</script>
<form id="relation_form" method="post" action="<%=basePath%>Main/codetablerelation/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_Bus_Exp_Relation.id" value="${exp.id }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">设备类型：</td>
		    <td>
		    <select id="relationexptype" name="t_Bus_Exp_Relation.type" data-options="required:true,value:'${exp.type }'" class="easyui-combobox" editable="false" panelHeight="auto" code="ZDFHBGLX" style="width:200px;"></select></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">类型代码：</td>
		    <td>
		    <input id="relationbhlxcode" value="${exp.bhlxcode}" name="t_Bus_Exp_Relation.bhlxcode" data-options="required:true" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">表名：</td>
		    <td>
		    <input id="relationexptablename" value="${exp.exptablename}" name="t_Bus_Exp_Relation.exptablename" data-options="required:true" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
    </table>
</form>
