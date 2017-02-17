<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function testTel(){
	var telnum = $("#telnumberid").val();
	if(telnum==null||telnum==''){
		alert("电话号不能为空！");
		return;
	}
	call_test(telnum);
}

function sendSms(){
	var smsnum = $("#smsnumberid").val();
	if(checkNum(smsnum)==false){
		alert("您输入的手机号有误！");
		return;
	}
	var smscontent = "您好！这是系统短信功能测试消息，收到请回复！";
	$.post("Main/smsMg/save",{smsnum:smsnum,smscontent:smscontent},function(result){
		var json = eval('(' + result + ')'); 
		if(json.success){
			$.lauvan.MsgShow({msg:json.msg});	
		}else{
			$.lauvan.MsgShow({msg:json.msg});		
		}
	});
}

//验证手机号
function checkNum(num){ 
    if(!(/^1[34578]\d{9}$/.test(num))){ 
        return false; 
    } 
}
</script>
<form id="givenworkmg_form" method="post" action="<%=basePath%>Main/workhandover/givenworkmgSave"
	style="width: 100%;">
 	<input type="hidden" id="type" name="act" value="add"/>
 	<input type="hidden" name="t_Work_Handover.giveuser" value="${useraccount}"/>
 	<input type="hidden" name="t_Work_Handover.event_id" value="${blistid}"/>
 	<input type="hidden" name="t_ThingInfo.content" value="${blistname}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">	
		<tr>
			<td class="sp-td1">交班人：</td>
			<td><input name="t_Work_Handover.givername" type="text"
				class="easyui-textbox" readonly="true"
				style="width: 300px;" value="${username}"></input></td>
		</tr>
		<tr>
		    <td class="sp-td1">接班人：</td>
		    <td>
		    <input  type="hidden" id="useraccount" name="t_Work_Handover.receiveuser"/>
		    <input  type="hidden" id="receiveid" name="t_ThingInfo.receiver"/>
		    <input id="username" name="t_Work_Handover.receivename" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="finduser()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		<tr>
		    <td class="sp-td1">值班主任：</td>
		    <td>
		    <input id="managername" name="t_Work_Handover.manager" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/><a id="btn1" onclick="findmanager()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a></td>
		    </tr>
		<tr>
			<td class="sp-td1">交班时间：</td>
			<td><input name="t_Work_Handover.dutydate" type="text"
				class="easyui-datetimebox" id="handovertime" data-options="required:true"
				style="width: 300px;" value="${now }"></input></td>
		</tr>
		<tr>
			<td class="sp-td1">交接事项：</td>
			<td><textarea name="t_Work_Handover.bak" id="bak" class="textarea"
				data-options="required:true"	style="width: 320px; height: 100px;">无</textarea></td>
		</tr>
		<tr>
			<td class="sp-td1">公文报送情况：</td>
			<td><textarea name="t_Work_Handover.doccontent" id="doccontentid" class="textarea"
					style="width: 320px; height: 100px;">无</textarea></td>
		</tr>
		<tr>
		<td colspan="2" style="background:#F1F7FF; color:#24A929; font-weight:bold;border-right:1px solid #B9CDE3; width:120px; text-align:center;font-size:12px;">三试三看情况</td>
		</tr>
		<tr >
		<td class="sp-td1" rowspan="2">电话测试：</td>
		<td><span>测试：</span><input id="telnumberid" type="text" class="easyui-textbox" data-options="prompt:'请输入测试电话号',icons:iconClear" style="width: 300px;"/><button type="button" class="easyui-linkbutton" style="margin-left:10px;" onclick="testTel();">拨打</button></td>
		</tr>
		<tr><td><span>结果：</span>
		<textarea name="t_Work_Handover.telstatus" class="textarea"
					style="width: 320px; height: 60px;"></textarea>
		<!-- <input type="text" name="t_Work_Handover.telstatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		</td></tr>
		<tr>
		<td class="sp-td1">传真测试：</td>
		<td><span>结果：</span><!-- <input type="text" name="t_Work_Handover.faxstatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		<textarea name="t_Work_Handover.faxstatus" class="textarea"
					style="width: 320px; height: 60px;"></textarea>
		<button type="button" class="easyui-linkbutton" style="margin-left:10px;" onclick="fax_test();">测试</button></td>
		</tr>
		<tr>
		<td class="sp-td1" rowspan="2">短信测试：</td>
		<td><span>测试：</span><input id="smsnumberid" type="text" class="easyui-textbox" data-options="prompt:'请输入测试手机号',icons:iconClear" style="width: 300px;"/><button type="button" class="easyui-linkbutton" style="margin-left:10px;" onclick="sendSms();">发送</button></td>
		</tr>
		<tr>
		<td>
		<span>结果：</span><!-- <input type="text" name="t_Work_Handover.smstatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		<textarea name="t_Work_Handover.smstatus" class="textarea"
					style="width: 320px; height: 60px;"></textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">邮箱测试：</td>
		<td><span>结果：</span><!-- <input type="text" name="t_Work_Handover.emailstatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		<textarea name="t_Work_Handover.emailstatus" class="textarea"
					style="width: 320px; height: 60px;">正常</textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">市委OA测试：</td>
		<td><span>结果：</span><!-- <input type="text" name="t_Work_Handover.swoastatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		<textarea name="t_Work_Handover.swoastatus" class="textarea"
					style="width: 320px; height: 60px;">正常</textarea>
		</td>
		</tr>
		<tr>
		<td class="sp-td1">市府OA测试：</td>
		<td><span>结果：</span><!-- <input type="text" name="t_Work_Handover.sfoastatus" class="easyui-textbox" data-options="prompt:'请输入测试结果',icons:iconClear" style="width: 300px;"/> -->
		<textarea name="t_Work_Handover.sfoastatus" class="textarea"
					style="width: 320px; height: 60px;">正常</textarea>
		</td>
		</tr>
		<c:if test="${!empty blist}">
		<tr>
		<td class="sp-td1">当天事件：</td>
		<td>
		<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr><td class="sp-td1"  align="center">事件名称</td><td class="sp-td1">事发地点</td><td class="sp-td1">事发时间</td></tr>
		<c:forEach items="${blist }" var="buseventinfo">
		<tr>
		<td>${buseventinfo.ev_name}</td><td>${buseventinfo.ev_address}</td><td>${buseventinfo.ev_date}</td>
		</tr>
		</c:forEach>
		</table>
		</td>
		</tr>
		</c:if>
		</table>
		</form>
