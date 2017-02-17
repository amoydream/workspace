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
 	<input type="hidden" name="act" value="add"/>
 	<input type="hidden" name="t_WeekPlan_Content.weekplanid" value="${id }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">时间：</td>
		    <td>
		     <select name="t_WeekPlan_Content.type" editable="false" panelHeight="auto" style="width:200px;" class="easyui-combobox">
								<c:forEach items="${timelist}" var="time">
								    <c:if test="${time=='001'}"> <option value="001" >上午</option></c:if>
								    <c:if test="${time=='002'}"> <option value="002" >下午</option></c:if>
								</c:forEach>
			</select>
            </td>
		    </tr>		   
	<tr>
	<td class="sp-td1">详细：</td>
	<td>  
      <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">星期一：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents1" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期二：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents2" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期三：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents3" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期四：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents4" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期五：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents5" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期六：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents6" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期日：</td>
		    <td>
		    <input name="t_WeekPlan_Content.contents7" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
	  </table>
    </td>
    </tr>
    </table>
</form>
