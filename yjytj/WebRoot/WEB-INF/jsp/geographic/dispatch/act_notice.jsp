<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
	#deptGrid td,#deptGrid2 td{
			height:21px;
			padding:4px 2px;
	}
	
</style>

<script>

	var telVal = "";
	$(function(){
		var param = {
				fitColumns: true,
				pagination: false,
				rownumbers: false,
				url:"<%=basePath%>Main/geographic/dispatch/getActionDeptDataGrid?&evactid=${evactid}",
				onCheck: function(index, row){
					$("#linkerman").text(getCheckTxt());
				},
				onUncheck: function(index, row){
					$("#linkerman").text(getCheckTxt());
				},
				onCheckAll : function(rows){
					$("#linkerman").text(getCheckTxt());
				},
				onUncheckAll : function(rows){
					telVal = "";
					$("#linkerman").text("");
				}
			};

		$.lauvan.dataGrid("deptGrid", param);
	});

	
	
	function sendActMsg(){
		if(telVal == ''){
			$.lauvan.MsgShow({msg:'请选择通知对象！'});
		}else if($("#smsMsg").val==''){
			$.lauvan.MsgShow({msg:'短信内容不能为空！'});
		}else{
			$.post(basePath+"Main/geographic/dispatch/sendActMsg", 
					{telVal: telVal.substr(1), sendMsg:$("#smsMsg").val(), eventid : '${t.id}'}, 
					function(result){
				if(result.success){
					$.lauvan.MsgShow({msg:result.msg});
					$("#norDialog").dialog('close');
				}else{
					$.lauvan.MsgShow({msg:result.msg});
	
				}
			});
		}

	}

	function getCheckTxt(){
		var txt = "";
		telVal = "";
		var rows = $("#deptGrid").datagrid('getChecked');
		for(var i=0; i<rows.length; i++){
			txt += "，"+ rows[i].ACTLINKERMAN;
			if(rows[i].ACTLINKERTEL!=""){
				telVal += ","+rows[i].ACTLINKERTEL;
			}
		}
		return txt.length>0?txt.substr(1):txt;
	}

	function saveDept(){
		var flag = $("#actdeptFrom").form('validate');
		if(flag){
		$.post("<%=basePath %>Main/geographic/dispatch/saveActDept", 
				   $("#actdeptFrom").serialize(),
				  function(result){
	 					if(result.success){
	 						$.lauvan.MsgShow({msg:"操作成功！"});
	 						$("#deptGrid").datagrid('reload');
	 						$("#actdeptFrom .clearflag").textbox('setValue','');
	 					}else{
	 						$.lauvan.MsgShow({msg:obj.msg});
	 					}
				   });
		}else{
			$.messager.alert('警告','请按要求填写信息！');
		}
	}

	//function callTelBtn(value, row, index){
	//	row.ACTID = row.ACTID == null? -1:row.ACTID;
	//	var btn = "<a class='pBtn2' style='margin-left:1px;' href='javascript:void(0);' onclick='calldialog("+row.ACTLINKERTEL+")'>拨号</a>";
	//	return btn;
	//}

	//function calldialog(tel){
	//	if(tel ==''){
	//		$.messager.alert('提示','电话号码不能为空！');
	//	}else{
	//		$.messager.confirm('拨号',"您确定拨打电话【"+tel+"】？",function(r){
				
	//		});
	///	}
	
	//}
	
</script>


<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north', border:false" style="height:200px;">
		<table id="deptGrid" width="98%" cellspacing="0" cellpadding="0">
			 <thead> 
					<tr>
						<th field="ACTDEPTNAME" width="100">执行部门</th>
						<th field="ACTLINKERMAN" width="100">联系人</th>
						<th field="ACTLINKERTEL" width="100">联系电话</th>
						<th field="NOTE" width="150">备注</th><%--
						<th field="CZ" formatter="callTelBtn">操作</th>
					--%></tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'center'">
		<div id="sendSmsBoxx" style="margin-top:10px;">
			<strong>发送短信</strong>
			<div style="height:25px;line-height:21px;margin-left:10px;">发送人：<span id="linkerman"></span></div>
			<div style="text-align:right;margin-right:10px;">
				<input type="text" name="smsMsg" id="smsMsg" data-options="icons:iconClear, validType:'',required:true, multiline:true" class="easyui-textbox" 
						value="${t.ev_name}，请速到${t.ev_address}" style="width:545px; height:50px;"/>
				<a href="javascript:void(0);" style="margin-top:10px;" class="easyui-linkbutton" onclick="sendActMsg()" data-options="iconCls:'icon-bullettick', plain:true">发送短信</a>
			</div>
		</div>
		
		<div id="actdeptbox" style="display:none;">
			<form id="actdeptFrom">
				<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
					<tr>
				    	<td class="sp-td1">执行部门：</td>
				    	<td>
				    		<input type="hidden" id="hidplanid" name="t_Bus_Event_PreschActionDept.preschid" value=""/>
				    		<input type="hidden" id="hidactid" name="t_Bus_Event_PreschActionDept.actid" value=""/>
				    		<input type="hidden" id="hidevactid" name="t_Bus_Event_PreschActionDept.evactid" value=""/>
				    		<input type="hidden" id="hidinstid" name="t_Bus_Event_PreschActionDept.instid" value="${instid}"/>
				    		<input type="hidden" id="hidpreschid" name="t_Bus_Event_PreschActionDept.actphase" value="${phaseid}"/>
				    		<input type="hidden" name="t_Bus_Event_PreschActionDept.eventid" value="${eventid}"/>
				    		<input class="easyui-combotree clearflag" name="t_Bus_Event_PreschActionDept.actdeptid" 
				    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',required:true" style="width:110px;">
			    
				    	</td>
				    	<td class="sp-td1">联系人：</td>
				    	<td>
				    		<input  name="t_Bus_Event_PreschActionDept.actlinkerman" type="text" class="easyui-textbox clearflag" data-options="required:true"  style="width: 110px;"/> 
				    	</td>
				    	<td class="sp-td1">联系电话：</td>
				    	<td>
				    		<input  name="t_Bus_Event_PreschActionDept.actlinkertel" type="text" class="easyui-textbox clearflag" data-options="required:true"  style="width: 110px;"/> 
				    	</td>
			    	</tr>
			    	<tr>
				  		<td class="sp-td1">任务说明：</td>
				    	<td colspan="5">
				    		<textarea name="t_Bus_Event_PreschActionDept.note" class="textbox easyui-validatebox clearflag" 
				    		data-options="validType:'length[0,200]'"  style="width:400px;height: 40px;"></textarea> 
				    	</td>
			    	</tr>
			    	<tr>
						<td colspan="6" style="text-align:center;">
							<a href="javascript:saveDept();" id="saveDeptBtn" class="easyui-linkbutton " data-options="iconCls:'icon-save',plain:true">保存</a>
							<a href="javascript:hideactdeptbox(0);" id="hidactdeptBtn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">取消</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>


