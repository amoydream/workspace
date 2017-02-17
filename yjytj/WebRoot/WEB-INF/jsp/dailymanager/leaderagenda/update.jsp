<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$('#nowtime2').datebox({
    onSelect: function(date){	    	
    	$.ajax({
        	url:'<%=basePath%>Main/leaderagenda/getchangetime?time='+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate(),
        	type:'post',
        	traditional:true,
        	success:function(data){
        	document.getElementById("yyy").value=data.year;
        	document.getElementById("www").value=data.week;
        	document.getElementById("sjd2").innerText=data.year+"年"+data.week+"周（日程时间段："+data.sjd+"）";
        	}
        });   
    }
});
</script>
<form id="leaderagenda_form" method="post" action="<%=basePath%>Main/leaderagenda/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="upd"/>
 	<input type="hidden" name="t_WeekPlan.id" value="${wp.id}"/>
 	<input type="hidden" id="yyy" name="yy" value="${wp.year}"/>
 	<input type="hidden" id="www" name="ww" value="${wp.weeknum}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		    <td class="sp-td1">姓名：</td>
		    <td colspan="3">
		    <input id="uname" name="t_WeekPlan.name" type="text" class="easyui-textbox" data-options="required:true" value="${wp.name }" style="width: 600px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">日程时间：</td>
		    <td width="200px;">
            <input name="nowtime2" id="nowtime2" type="text" class="easyui-datebox" data-options="required:true" editable="false" value="${starttime}" style="width: 200px;"></input>
		    </td>
		    <td class="sp-td1">时间段：</td>
		    <td>
            <label id="sjd2">${sjd}</label>
		    </td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3"><textarea name="t_WeekPlan.remark" class="textarea"
					style="width: 600px; height: 50px;">${wp.remark }</textarea></td>
		</tr>
	</table>
</form>
