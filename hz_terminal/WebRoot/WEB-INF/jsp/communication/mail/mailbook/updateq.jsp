<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="linkman_form" method="post" action="<%=basePath%>Main/mail/qSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_Bus_Linkman_Qun.id" value="${qun.id }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">群组姓名：</td>
		    <td><input id="lmqname" name="t_Bus_Mailbook_Qun.name" type="text" value="${qun.name }" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">联系人：</td>
		    <td>
		    <input  type="hidden" id="lmid" value="${cid }" name="t_Bus_Linkman_Qun.cid"/>
		    <input id="lmname"  type="text" value="${qname}"  readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="findlinkman()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
    </table>
</form>
