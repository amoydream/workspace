<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$('#nowtime1').datebox({
    onSelect: function(date){	    	
    	$.ajax({
        	url:'<%=basePath%>Main/leaderagenda/getchangetime?time='+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate(),
        	type:'post',
        	traditional:true,
        	success:function(data){
        	document.getElementById("yy").value=data.year;
        	document.getElementById("ww").value=data.week;
        	document.getElementById("sjd1").innerText=data.year+"年"+data.week+"周（日程时间段："+data.sjd+"）";
        	}
        });   
    }
});
</script>
<form id="leaderagenda_form" method="post" action="<%=basePath%>Main/leaderagenda/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input type="hidden" id="yy" name="yy" value="${year }"/>
 	<input type="hidden" id="ww" name="ww" value="${week }"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">姓名：</td>
		    <td colspan="3">
		    <input id="uname" name="t_WeekPlan.name" type="text" class="easyui-textbox" data-options="required:true"  style="width: 600px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">日程时间：</td>
		    <td width="200px;">
            <input name="nowtime1" id="nowtime1" type="text" class="easyui-datebox" data-options="required:true" editable="false" value="${now}" style="width: 200px;"></input>
		    </td>
		    <td class="sp-td1">时间段：</td>
		    <td>
            <label id="sjd1">${time}</label>
		    </td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3"><textarea name="t_WeekPlan.remark" class="textarea"
					style="width: 600px; height: 50px;"></textarea></td>
		</tr>
	<tr>
	<td class="sp-td1">上午：</td>
	<td colspan="3">
	<div id="am" class="easyui-panel" title="AM"     
        style="width:600px;height:325px;padding:5px;background:#fafafa;"   
        data-options="closable:false,    
                collapsible:true,minimizable:false,maximizable:false">   
      <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">星期一：</td>
		    <td>
		    <input name="am1" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期二：</td>
		    <td>
		    <input name="am2" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期三：</td>
		    <td>
		    <input name="am3" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期四：</td>
		    <td>
		    <input name="am4" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期五：</td>
		    <td>
		    <input name="am5" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期六：</td>
		    <td>
		    <input name="am6" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期日：</td>
		    <td>
		    <input name="am7" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
	  </table>
    
    </div>
    </td>
    </tr>
    <tr>
	<td class="sp-td1">下午：</td>
	<td colspan="3">
	<div id="pm" class="easyui-panel" title="PM"     
        style="width:600px;height:325px;padding:5px;background:#fafafa;"   
        data-options="closable:false, collapsed:true,   
                collapsible:true,minimizable:false,maximizable:false">   
      <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    <tr>
		    <td class="sp-td1">星期一：</td>
		    <td>
		    <input name="pm1" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期二：</td>
		    <td>
		    <input name="pm2" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期三：</td>
		    <td>
		    <input name="pm3" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期四：</td>
		    <td>
		    <input name="pm4" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期五：</td>
		    <td>
		    <input name="pm5" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期六：</td>
		    <td>
		    <input name="pm6" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
		    <tr>
		    <td class="sp-td1">星期日：</td>
		    <td>
		    <input name="pm7" type="text" class="easyui-textbox" style="width: 400px;"/></td>
		    </tr>
	  </table>
    
    </div>
    </td>
    </tr>
    </table>
</form>
