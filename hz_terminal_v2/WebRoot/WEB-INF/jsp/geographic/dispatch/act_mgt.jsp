<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style>
	#feedbackBox td,#rwbox td{
		height:21px;
		padding:4px 2px;
	}
</style>
<script>

	$(function(){
		var param = {
			idField:'EVACTID',
			fitColumns: true,
			pagination: false,
			rownumbers: false,
			height:300,
			toolbar: [
					   
					  { text:'添加', title:'添加行动', iconCls: 'icon-add',
							dialogParams:{dialogId:'actDialog',
							 href:basePath+'Main/geographic/dispatch/addEventAct?instid=${instid}&planid=${planid}&phaseid=${phaseid}&eventid=${eventid}', 
							width:500, height:280, formId:'actform1', isNoParam:true}}, '-',
					  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/geographic/dispatch/delEventAct'}}, '-',
					  { text: '上移', iconCls:'icon-arrowup', handler: function(){
							var row = grid.datagrid('getSelected');
							if( !row ){
								$.lauvan.MsgShow({msg: '请选择上移行！'});
							}else{
								var index = grid.datagrid('getRowIndex', row);
								if(index >0 ){
									var upRow = grid.datagrid('getData').rows[index];
									var downRow = grid.datagrid('getData').rows[index-1];
									moveRow(upRow, downRow, index-1, index, index-1);
								}
							}
						}}, '-',
					  { text: '下移', iconCls:'icon-arrowdown', handler: function(){
							var row = grid.datagrid('getSelected');
							if(!row){
								$.lauvan.MsgShow({msg: '请选择下移行！'});
							}else{
								var index = grid.datagrid('getRowIndex', row);
								var len = grid.datagrid('getData').rows.length;
								if(index < len){
									var downRow = grid.datagrid('getData').rows[index];
									var upRow = grid.datagrid('getData').rows[index+1];
									moveRow(upRow, downRow, index, index+1, index+1);
								}
							}
					  }}
					],
			url:basePath+"Main/geographic/dispatch/getActDataGrid/${instid}-${phaseid}"
			

		};	
		
		$.lauvan.dataGrid("actGrid2", param);

		var attrArray = {
				fitColumns : true,
				idField:'D_ID',    
			    treeField:'D_NAME',
			    pagination:false,
				url:basePath+"Main/systemcontact/departmentcontact/getGridData"
		};

		$.lauvan.treeGrid("departcontactTree2",attrArray);

		var grid = $("#actGrid2");
		var data = [];
		//行移动
		function moveRow(upRow, downRow, upIndex, downIndex, selectIndex){
			upRow.ACTORDER = upRow.ACTORDER - 1;
			downRow.ACTORDER = downRow.ACTORDER +1;
			var len = data.length;
			if(len >0){
				var upRowFlag = true;
				var downRowFlag = true;
				for(var i=0; i<len; i++){
					var e = data[i];
					if(e.evactid == upRow.EVACTID){
						e.actorder = upRow.ACTORDER;
						data[i] = e;
						upRowFlag = false;
					}

					if(e.evactid == downRow.EVACTID){
						e.actorder = downRow.ACTORDER;
						data[i] = e;
						downRowFlag = false;
					}
				}
				if(upRowFlag){
					data.push({"evactid":upRow.EVACTID, "actorder":upRow.ACTORDER});
				}
				if(downRowFlag){
					data.push({"evactid":downRow.EVACTID, "actorder":downRow.ACTORDER});
				}
			}else{
				data.push({"evactid" : upRow.EVACTID, "actorder" : upRow.ACTORDER});
				data.push({"evactid" : downRow.EVACTID, "actorder" : downRow.ACTORDER});
			}
			grid.datagrid('getData').rows[downIndex] = downRow;
			grid.datagrid('getData').rows[upIndex] = upRow;
			grid.datagrid('refreshRow', upIndex);
			grid.datagrid('refreshRow', downIndex);
			grid.datagrid('selectRow', selectIndex);
			$("#actsort").show();
			$("#feedbackBox").hide();
			$("#gridbox").css("height", "100%");
		}

		//保存行动新顺序
		$("#saveActSort").on("click", function(){
			var len = data.length;
			if(len>0){
				var result = [];
				for(var i=0; i<len; i++){
					result.push(data[i].evactid +"-"+data[i].actorder);
				}
				$.post(basePath + "Main/geographic/dispatch/saveActOrder", {'data' : result}, function(result){
					$.lauvan.MsgShow({msg: result.msg});
				});
			}
		});
	});

	function addBtn(value, row, index){
		row.ACTID = row.ACTID == null?-1:row.ACTID;
		var btn = "<a class='pBtn2' href='javascript:void(0);' onclick='actDept("+row.EVACTID+")'>执行单位</a>" +
					"<a class='pBtn2' href='javascript:void(0);' onclick='czfkBtn(1, "+row.EVACTID+")'>处置反馈</a>";
		return btn;

	}

	function actDept(actid){
		$("#gridbox").hide();
		$("#feedbackBox").hide();
		$("#zxdwBox").show();

		//获取行动对应任务内容
		$("#tzbox").load(basePath+"Main/geographic/dispatch/getActionDept/?eventid=${eventid}&trainflag=${trainflag}&evactid="+actid, 
				null, 
				function(result){
			 	$.parser.parse($("#sendSmsBoxx").parent());   //渲染easyui组件
				$.get(basePath+"Main/geographic/dispatch/getActContent", 
					  {evactid : actid}, 
					  function(result){
						$("#actname").html(result.ACTNAME);
						$("#actcont").html(result.ACTCONT);
						$("#hidactid").val(result.ACTID);
						$("#hidevactid").val(result.EVACTID);
						$("#hidinstid").val(result.INSTID);
						$("#hidplanid").val(result.PRESCHID);
						$("#hidpreschid").val(result.ACTPHASE);

				});
				
		});
	}

	function hideActDept(){
		$("#gridbox").show();
		$("#zxdwBox").hide();
	}


	var rdata = null;
	function czfkBtn(flag, evactid){
		if(flag ==0){
			$("#feedbackBox").hide();
			$("#gridbox").css("height", "100%");
		}else{
			$("#actsort").hide();
			$("#feedbackBox").show();
			//查询行动对应执行部门
			$.get(basePath+"Main/geographic/dispatch/getActDept", {evactid: evactid}, function(r){
				if(r.length>0){
					rdata = r;
					$("#ep_organ").combobox({
						data: r,
						textField:'ACTDEPTNAME',
						valueField:'ID',
						onSelect: function(param){
							for(var i=0; i<rdata.length; i++){
								if(rdata[i].ID == param.ID){
									$("#ep_user").textbox('setValue', rdata[i].ACTLINKERMAN);
									$("#ep_cztel").textbox('setValue', rdata[i].ACTLINKERTEL);
									$("#ep_organval").val(rdata[i].ACTDEPTNAME);
								}
							}
						}
					});

					$("#ep_organ").combobox('select', r[0].ID);
				}else{
					//列表为空，则清楚文本框、组合框内容
					$("#ep_organ").combobox({data:[]});
					$("#ep_user").textbox('setValue', "");
					$("#ep_cztel").textbox('setValue', "");
					$("#ep_organval").val("");
				}
			});
			$("#gridbox").css("height", "55%");
		}
		//$("#actGrid2").datagrid('resize');
		
	}

	
	function formatDeptType(val,row){
		if(val=='0')
			val='市';
		else if(val=='1')
			val='区';
		else if(val=='2')
			val='县';
		else if(val=='3')
			val='镇';
		return val;
	}

	function exeAct(flag,evactid){
		var param = {
				title:'行动完成状态',
				width:300,
				height:150,
				href:'<%=basePath%>Main/geographic/dispatch/getActStatus?status='+flag+'&evactid='+evactid
		};
		$.lauvan.openCustomDialog("actStatusDialog", param, null, "form1");
	}

	function changeStatus(val, row){
		if(val == 'U'){
			val = "未执行<a href='javascript:exeAct(\"U\", "+row.EVACTID+");' class='exeActBtn' style='color:orange;'>【执行】</a>";
		}else if(val == 'E'){
			val = "正在执行<a href='javascript:exeAct(\"E\", "+row.EVACTID+ ");' style='color:orange;'>【执行】</a>";
		}else if(val == 'D'){
			val = "执行完成";
		}else if(val == 'F'){
			val = "执行失败";
		}
		return val;
	}

	function saveCZ(){
		var flag = $("#actfkform").form('validate');
		if(flag){
			$.post(basePath+"Main/eventProcess/save",
					$("#actfkform").serialize(), function(result){
					var obj = eval("("+result+")");
						if(obj.success){
						$.lauvan.MsgShow({msg:"操作成功！"});
						$("#actfkform .clearflag").textbox('setValue','');
						}else{
							$.lauvan.MsgShow({msg:obj.msg});
						}
						
			});
		}else{
			$.messager.alert('警告','请按要求填写信息！');
		}
	}


	function hideactdeptbox(flag){
		if(flag == 0){
			$("#actdeptbox").hide();
			$("#sendSmsBoxx").show();
		}else{
			$("#actdeptbox").show();
			$("#sendSmsBoxx").hide();
		}
	}
</script>


<div class="easyui-tabs" data-options="fit:true">
	<div title="行动清单">
		<!-- 任务列表 -->
		<div id="gridbox" style="height:100%">
			<div style="height:90%" >
				<table id="actGrid2" cellspacing="0" cellpadding="0" data-options="fit:true">
						<thead>
							<tr>
								 <th field="EVACTID" data-options="hidden:true">ID</th>
								<th field="ACTNAME" width="100" >工作任务</th>
								<th field="ACTSTATUS" width="100" formatter="changeStatus">是否完成</th>
								<th field="ACTCZ" width="100" formatter="addBtn" >操作</th>
							</tr>
						</thead>
				</table>
			</div>
			<div id="actsort" style="text-align:center;padding-top:5px;height:8%;display:none;">
				<a href="javascript:void(0);" id="saveActSort" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存行动顺序</a>
			</div>
		</div>
			<!-- 反馈信息 -->
			<div id="feedbackBox" style="height:45%; display:none;">
				<form id="actfkform" method="post" action="<%=basePath %>Main/eventProcess/save" >
					<table class="sp-table" width="100%" cellpadding="0" cellspacing="0" >
						<tr>
							<td class="sp-td1">处置单位：</td>
							<td>
								<input type="hidden" name="act" value="add"/>
								<input type="hidden" name="t_Bus_EventProcess.eventid" value="${eventid}"/>
								<input type="hidden" name="t_Bus_EventProcess.ep_instflag" value="${trainflag}" />
								<input type="hidden" name="t_Bus_EventProcess.ep_organ" id="ep_organval"/>
								<select id="ep_organ" data-options="required:true" class="easyui-combobox clearflag" style="width: 110px;"></select>
							</td>
							<td class="sp-td1">处置类型：</td>
					    	<td >
					    		<select class="easyui-combobox clearflag" name="t_Bus_EventProcess.ep_type"  panelHeight="auto" code="EVPY" style="width: 110px;" data-options="editable:false,required:true" ></select>
					  		</td>
					  		<td class="sp-td1">处置人：</td>
							<td>
								<input type="text" name="t_Bus_EventProcess.ep_user" id="ep_user" data-options="prompt:'',required:true,icons:iconClear" class="easyui-textbox clearflag" style="width: 110px;"/>
							</td>
						</tr>
						<tr>
							<td class="sp-td1">处置人电话：</td>
							<td>
								<input type="text" id="ep_cztel" data-options="icons:iconClear" class="easyui-textbox clearflag" style="width: 110px;"/>
							</td>
							<td class="sp-td1">报告人：</td>
							<td>
								<input type="text" name="t_Bus_EventProcess.ep_reporter" data-options="required:true,icons:iconClear" class="easyui-textbox clearflag" style="width: 110px;"/>
							</td>
							<td class="sp-td1">报告人电话：</td>
							<td>
								<input type="text" name="t_Bus_EventProcess.ep_reporttel" data-options="icons:iconClear" class="easyui-textbox clearflag" style="width: 110px;"/>
							</td>
						</tr>
						<tr>
							<td class="sp-td1">处置时间：</td>
							<td colspan="5">
								<input type="text"  name="t_Bus_EventProcess.ep_date"  class="easyui-datetimebox "   style="width: 110px;"  data-options="editable:false,required:true,icons:iconClear,value:'${dateStr}'"/>
							</td>
						</tr>
						<tr>
							<td class="sp-td1">处置内容：</td>
							<td colspan="5">
									<textarea name="t_Bus_EventProcess.ep_content" class="textarea clearflag" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height:45px;" ></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align:center;">
								<a href="javascript:saveCZ();" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
								<a href="javascript:czfkBtn(0);" class="easyui-linkbutton" data-options="iconCls:'icon-arrowundo',plain:true">取消</a>
							</td>
						</tr>
					</table>
				</form>
		</div>
		<div id="zxdwBox" style="display:none;"> <!-- 执行单位 -->
			<div id="rwbox" style="height:30%">
				<table width="100%" cellpadding="0" cellspacing="0" class="sp-table">
					<tr>
						<td>工作任务：</td>
						<td width="35%"><span id="actname"></span></td>
						<td colspan="2" style="text-align:center;">
							<a href="javascript:hideactdeptbox(1);" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">添加单位</a>
							<a href="javascript:hideActDept();" class="easyui-linkbutton" data-options="iconCls:'icon-arrowundo',plain:true">返回</a>
						</td>
					</tr>
					<tr>
						<td>工作内容：</td>
						<td colspan="3">
							<span id="actcont"></span>
						</td>
					</tr>
				</table>
			</div>
			<div id="tzbox" style="height:70%">
			
			</div>
		</div>
	</div>
	<div title="通讯录">
	
		<table id="departcontactTree2" class="easyui-treegrid"  cellspacing="0" cellpadding="0"  data-options="fit:true"> 
			    <thead> 
			        <tr>  
			            <th field="D_ID" width="100" data-options="hidden:true">部门ID</th> 
			            <th field="D_NAME" width="250">部门名称</th> 
			            <th field="D_PID" width="100" data-options="hidden:true">上级部门ID</th> 	
			            <th field="D_TYPE" width="40" data-options="formatter:formatDeptType">部门类别</th> 
			            <th field="BO_WORKNUMBER" width="100">办公电话</th> 
			            <th field="BO_FAX" width="100">传真</th> 
			            <th field="BO_EMAIL" width="100">Email</th> 
			            <th field="BO_ADDRESS" width="180">地址</th>
			        </tr> 
			    </thead> 
			</table>
	</div>
</div>


