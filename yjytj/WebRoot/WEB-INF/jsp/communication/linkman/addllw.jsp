<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="linkman_form" method="post" action="<%=basePath%>Main/linkman/llwSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">群组姓名：</td>
		    <input type="hidden" name="t_Bus_Linkman_Qun.id" value="${qun.id }"/>
		    <td><input id="lmqname" value="${qun.name }" name="t_Bus_Linkman_Qun.name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    <input  type="hidden" id="lmllwid" name="llwid"/>
		    <input id="lmllwname" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="findllw()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
    </table>
</form>
