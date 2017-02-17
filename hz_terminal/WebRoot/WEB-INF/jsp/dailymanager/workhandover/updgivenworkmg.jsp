<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
</script>
	 <form id="givenworkmg_form" method="post" action="<%=basePath%>Main/workhandover/givenworkmgSave" style="width:100%;">
	    <input id="type" type="hidden" name="act" value="upd"/>
	     <input type="hidden" name="t_Work_Handover.id" value="${wh.id}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="sp-td1">交班人：</td>
			<td><input name="t_Work_Handover.givername" type="text"
				class="easyui-textbox" readonly="true"
				style="width: 300px;" value="${wh.givername}"></input></td>
		</tr>
		<tr>
		    <td class="sp-td1">接班人：</td>
		    <td>
		    <input  type="hidden"  value="${wh.receiveuser}"/>
		    <input id="username" name="t_Work_Handover.receivename" value="${wh.receivename }" type="text"  class="easyui-textbox" data-options="disabled:true"  style="width: 300px;"/></td>
		</tr>
		<tr>
		    <td class="sp-td1">值班主任：</td>
		    <td>
		    <input id="managername" name="t_Work_Handover.manager" value="${wh.manager }" type="text"  class="easyui-textbox" data-options="disabled:true"  style="width: 300px;"/>
		    </td>
		</tr>
		<tr>
			<td class="sp-td1">交班时间：</td>
			<td><input  type="text" 
				class="easyui-datetimebox" data-options="disabled:true"
				style="width: 300px;" value="${wh.dutydate}"></input></td>
		</tr>
		<tr>
			<td class="sp-td1">交接事项：</td>
			<td><textarea name="t_Work_Handover.bak" id="bak" class="textarea"
					style="width: 320px; height: 50px;">${wh.bak }</textarea></td>
		</tr>
		<tr>
			<td class="sp-td1">公文报送情况：</td>
			<td><textarea name="t_Work_Handover.doccontent" id="doccontentid" class="textarea"
					style="width: 320px; height: 100px;">${wh.doccontent }</textarea></td>
		</tr>
		<tr>
		<td style="background:#F1F7FF; color:#24A929; font-weight:bold;border-right:1px solid #B9CDE3; width:120px; text-align:center;font-size:12px;" colspan="2">三试三看情况</td>
		</tr>
		<tr >
		<td class="sp-td1">电话测试结果：</td>
		<td><%-- <input type="text" name="t_Work_Handover.telstatus" class="easyui-textbox" value="${wh.telstatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
		    <textarea name="t_Work_Handover.telstatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.telstatus }</textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">传真测试结果：</td>
		<td><%-- <input type="text" name="t_Work_Handover.faxstatus" class="easyui-textbox" value="${wh.faxstatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
		   <textarea name="t_Work_Handover.faxstatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.faxstatus }</textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">邮箱测试结果：</td>
		<td><%-- <input type="text" name="t_Work_Handover.emailstatus" class="easyui-textbox" value="${wh.emailstatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
		<textarea name="t_Work_Handover.emailstatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.emailstatus }</textarea>
		</td>
		</tr>
		<tr >
		<td class="sp-td1">短信测试结果：</td>
		<td>
		<%-- <input type="text" name="t_Work_Handover.smstatus" class="easyui-textbox" value="${wh.smstatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
       <textarea name="t_Work_Handover.smstatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.smstatus }</textarea>
        </td>
		</tr>
		<tr>
		<td class="sp-td1">市委OA测试结果：</td>
		<td><%-- <input type="text" name="t_Work_Handover.swoastatus" class="easyui-textbox" value="${wh.swoastatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
		<textarea name="t_Work_Handover.swoastatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.swoastatus }</textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">市府OA测试结果：</td>
		<td><%-- <input type="text" name="t_Work_Handover.sfoastatus" class="easyui-textbox" value="${wh.sfoastatus }" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> --%>
		<textarea name="t_Work_Handover.sfoastatus" class="textarea"
					style="width: 320px; height: 60px;">${wh.sfoastatus }</textarea>
		</td>
		</tr>
		</table>    	
    </form>
