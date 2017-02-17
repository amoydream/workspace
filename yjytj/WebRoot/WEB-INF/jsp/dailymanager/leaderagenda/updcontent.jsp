<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
</script>
<form id="leaderagenda_form" method="post" action="<%=basePath%>Main/leaderagenda/contentSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_WeekPlan_Content.id" value="${wc.id}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	<tr>
	<c:if test="${wc.type=='001'}">
	<td class="sp-td1">上午：</td>
	</c:if>
	<c:if test="${wc.type=='002'}">
	<td class="sp-td1">下午：</td>
	</c:if>
	<td> 
      <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">星期一：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents1" value="${wc.contents1}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期二：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents2" value="${wc.contents2}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期三：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents3" value="${wc.contents3}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期四：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents4" value="${wc.contents4}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期五：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents5" value="${wc.contents5}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期六：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents6" value="${wc.contents6}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期日：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents7" value="${wc.contents7}" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
	  </table>
    </td>
    </tr>
    </table>
</form>
