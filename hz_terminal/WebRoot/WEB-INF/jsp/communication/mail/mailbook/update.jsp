<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="linkman_form" method="post" action="<%=basePath%>Main/mailbook/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_Bus_Mailbook.id" value="${lm.id }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">姓名：</td>
		    <td><input id="lmname" name="t_Bus_Mailbook.name" type="text" class="easyui-textbox" data-options="required:true" value="${lm.name }"  style="width: 200px;"/></td>
		    <td class="sp-td1">邮箱：</td>
		    <td>
		    <input id="lmmail" name="t_Bus_Mailbook.mail" value="${lm.mail}" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">单位：</td>
		    <td>
		    <input id="lmdept" name="t_Bus_Mailbook.dept" value="${lm.dept}" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;" /></td>
		    <td class="sp-td1">职位：</td>
		    <td>
		    <input name="t_Bus_Mailbook.position" value="${lm.position}" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">备注：</td>
		    <td  colspan="3" >
		    <textarea name="t_Bus_Mailbook.remark" class="textarea"
							data-options="validType:'length[0,500]'" style="width: 590px; height: 50px;">${lm.remark}</textarea>
		    </td>
		    </tr>
    </table>
</form>
