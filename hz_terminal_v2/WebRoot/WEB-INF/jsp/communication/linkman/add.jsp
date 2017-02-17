<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
<form id="linkman_form" method="post" action="<%=basePath%>Main/linkman/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">姓名：</td>
		    <td><input id="lmname" name="t_Bus_Linkman.name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/></td>
		    <td class="sp-td1">手机：</td>
		    <td>
		    <input id="lmtel" name="t_Bus_Linkman.tel" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">单位：</td>
		    <td>
		    <input id="lmdept" name="t_Bus_Linkman.dept" type="text" class="easyui-textbox" data-options="required:true" style="width: 200px;" value="${deptname}"/></td>
		    <td class="sp-td1">职位：</td>
		    <td>
		    <input name="t_Bus_Linkman.position" type="text" class="easyui-textbox" style="width: 200px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">备注：</td>
		    <td  colspan="3" >
		    <textarea name="t_Bus_Linkman.remark" class="textarea"
							data-options="validType:'length[0,500]'" style="width: 590px; height: 50px;"></textarea>
		    </td>
		    </tr>
    </table>
</form>
