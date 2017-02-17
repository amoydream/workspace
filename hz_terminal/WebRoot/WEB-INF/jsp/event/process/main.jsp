<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	var button_eproc = [{
		text:'提交反馈',
		iconCls:'icon-save',
		handler:function(){
			$("#eventProcessform").form('options').queryParams={'act':'fk'};
			$.lauvan.dialogSubmit('eventProcessform','eventProcessDialog');
		}
	},{
		text:'发送短信',
		iconCls:'icon-ok',
		handler:function(){
			//获取短信手机号码
			var phone=$("#smsnumname").val();
			var smscontent = $("#smscontent").val();
			if(phone!=null && phone!='' && phone!=undefined){
				if(smscontent!=null && smscontent!='' && smscontent!=undefined){
					$("#smsnum").val(phone);
					$("#eventProcessform").form('options').queryParams={'act':'sms'};
					$.lauvan.dialogSubmit('eventProcessform','eventProcessDialog');
				}else{
					alert("请填写汇报内容！");
				}
			}else{
				alert("请填写手机号码！");
			}
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#eventProcessDialog").dialog('close');
		}
	}]
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '反馈',title:'事件反馈信息', iconCls: 'icon-add',permitParams:"${estatus=='00D' || pert:hasperti(applicationScope.event_processAdd, loginModel.xdlimit)}",
	                   dialogParams:{dialogId:'eventProcessDialog',href:basePath+"Main/eventProcess/add/fk-${eventid}",width:1000,
						height:600,formId:'eventProcessform',isNoParam:true,buttons:button_eproc}}, '-', 
                  { text: '处置',title:'事件处置信息',iconCls: 'icon-pageedit', permitParams:"${estatus=='00D' || pert:hasperti(applicationScope.event_processAdd, loginModel.xdlimit)}",
		                   dialogParams:{dialogId:'eventProcessDialog',href:basePath+"Main/eventProcess/add/cz-${eventid}",width:800,
								height:500,formId:'eventProcessform',isNoParam:true}}, '-',
                  { text: '修改',title:'事件处置信息',iconCls: 'icon-pageedit', permitParams:"${estatus=='00D' || pert:hasperti(applicationScope.event_processUpd, loginModel.xdlimit)}",
					      dialogParams:{dialogId:'eventProcessDialog',href:basePath+"Main/eventProcess/edit",width:800,
							height:500,formId:'eventProcessform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',permitParams:"${estatus=='00D' || pert:hasperti(applicationScope.event_processDel, loginModel.xdlimit)}",
				                  ajaxParams:{url:basePath+'Main/eventProcess/delete'},handler:delEPorcess}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/eventProcess/getDataGrid/${eventid}",
		frozenColumns:[[]],
		view: detailview,
		detailFormatter:function(index,row){
			return '<div style="padding:2px;"><div id="eprocess-' + index + '"></div></div>';
		},
		onExpandRow: function(index,row){
			//展示内容
			$("#eprocess-"+index).load(basePath+"Main/eventProcess/getContent",
					{"eventid":'${eventid}',"id":row.ID},function(){
				$('#eventProcessGrid').datagrid('fixDetailRowHeight',index);});
			
		}
		};
		$.lauvan.dataGrid("eventProcessGrid",attrArray);
		//短信列表
		var attrArray_sms ={
				fitColumns : true,
				idField:'SMSID',
				url:basePath+"Main/eventProcess/getSmsGrid/${eventid}",
				frozenColumns:[[]]
				};
		$.lauvan.dataGrid("evSmsGrid",attrArray_sms);

		//传真列表
		var attrArray_fax ={
				fitColumns : true,
				idField:'FAX_ID',
				url:basePath+"Main/eventProcess/getFaxDataList/${eventid}",
				frozenColumns:[[]]
				};
		$.lauvan.dataGrid("evfaxGrid",attrArray_fax);
		});
	function delEPorcess(){
		var rows=$("#eventProcessGrid").datagrid('getSelected');
		var options=$(this).linkbutton("options");
		var paramsList=options.ajaxParams;
		var btext = options.text;
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲'+btext+'的数据!'});
			return;
		}
		$.messager.confirm(btext,'您确定'+btext+'选择的数据吗？',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:paramsList.url,
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'id':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据'+btext+'成功'});
	            			$("#eventProcessGrid").datagrid('clearSelections');
	            			$("#eventProcessGrid").datagrid('clearChecked');
	            			$("#eventProcessGrid").datagrid('reload');
	            		}
	            		else{
	            			$("#eventProcessGrid").datagrid('clearSelections');
	            			$("#eventProcessGrid").datagrid('clearChecked');
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function faxStateFN(value,row,index){
		if("S"==value){
			return "发送成功";
		}else if("F"==value){
			return "发送失败";
		}else if("U"==value){
			return "未发送";
		}else{
			return value;
		}
	}
	function FAXactionfn(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=faxView('"+row.FAX_ID+"','"+row.FAX_TASK_ID+"') >查看</a></li>"
			+"</ul>";
		return act;
	}
	function faxView(faxid,taskid){
		if(taskid!=null && taskid!='' && taskid!='null'){
			//直接打开文件
			window.open(basePath+"Main/eventProcess/getFaxView/"+taskid);
		}else{
			//下载传真文件
			$("#download_frame").attr("src", basePath+"Main/communication/ccms/fax/download?fax_id="+faxid);
		}
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div class="easyui-tabs" style="width:100%;" data-options="fit:true" >
			<div title="事件过程信息" >
				<table id="eventProcessGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="EP_DATE" width="100">处置时间</th> 
				            <th field="EP_TYPE" width="150" CODE="EVPY" >处置类型</th>
				            <th field="EP_USER" width="150"  >处置人</th>
				            <th field="EP_ORGAN" width="100"  >处置单位</th>
				            <th field="EP_CONTENT" width="200" >处置内容</th>
				        </tr> 
				    </thead> 
				</table>
			</div>
			<div title="事件短信信息" >
				<table id="evSmsGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="CALLNO" width="100">接收号码</th> 
				            <th field="CALLNAME" width="100"  >人员名称</th>
				            <th field="EV_NAME" width="150"  >事件名称</th>
				            <th field="DEPTNAME" width="150"  >部门</th>
				            <th field="SMSDATA" width="200"  >发送内容</th>
				            <th field="ISREV" width="100" >是否有回执</th>
				            <th field="SENDUSER" width="100" >操作用户</th>
				            <th field="SMSSTATE" width="100" >发送状态</th>
				            <th field="SENDTIME" width="100" >发送时间</th>
				            <th field="BAK_RD" width="100" >备注</th>
				        </tr> 
				    </thead> 
				</table>
			</div>
			<div title="事件传真信息" >
				<table id="evfaxGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="TITLE" width="100">任务标题</th> 
				            <th field="FAX_NUMBER" width="150"  >传真号码</th>
				            <th field="FAXNAME" width="150"  >接收对象</th>
				            <th field="FAXTIME" width="100"  >发送时间</th>
				            <th field="FAXST" width="100" formatter="faxStateFN">发送结果</th>
				            <th field="FAXVIEW" width="100"  formatter="FAXactionfn" >操作</th>
				        </tr> 
				    </thead> 
				</table>
			</div>
		</div>
		</div>
	</div>
