<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '新增短信',title:'新增短信', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'smsMgDialog',href:basePath+"Main/smsMg/add/send",width:700,
						height:400,formId:'smsMgform',isNoParam:true}}, '-', 
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/smsMg/delete/send'}}, '-', 
                  { text: '关联事件',iconCls: 'icon-edit',handler:relaEvent},'-',
                  { text: '取消关联事件',iconCls: 'icon-delete',handler:unrelaEvent}
                 ],
		fitColumns : true,
		idField:'MOBILEID',
		url:basePath+"Main/smsMg/getSendGridDate",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			$(document.body).append("<div id='smsMgDialog'></div>");
			$("#smsMgDialog").dialog({
				title:'短信详情',
				width: 800,
				height: 450,
				cache: false,
				onClose:function(){
					$(this).dialog('destroy');
				},
			    modal: true,
				href: basePath+"Main/smsMg/add/onemore-"+rowData.MOBILEID,
				buttons: [{
					text:'重新发送',
					iconCls:'icon-save',
					handler:function(){
						$.lauvan.dialogSubmit('smsMgform','smsMgDialog');
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#smsMgDialog").dialog('close');
					}
				}]
				});	
		}
		};
		$.lauvan.dataGrid("smsSendGrid",attrArray);
		});

	
	function smssend_doSearch(){
		$('#smsSendGrid').datagrid('load',{
			scontent: $('#scontent_s').val(),
			phonenum:$('#phonenum_s').val(),
			smobname:$('#smobname_s').val(),
		});
	}
	function receFN(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\""+basePath+"Main/smsMg/view/send-"+row.MOBILEID+"-"+row.SM_ID+"\" target=\"_blank\" >查看</a></li></ul>";
	return act;
	}
	function sendStateFN(value,row,index){
		if(value=='F'){
			return '失败';
		}else if(value=='V'){
			return '发送中';
		}else{
			return '成功';
		}
	}
	function sendRPTFN(value,row,index){
		if(value==null|| value==''){
			return '';
		}else{
			var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
				+"<a href=\"javascript:void(0);\" onclick=\"openRPT_sms("+value+")\" >查看</a></li></ul>";
			return act;
		}
	}
	function openRPT_sms(smid){
		$(document.body).append("<div id='_RPT_smsDialog'></div>");
		$("#_RPT_smsDialog").dialog({
			title:'短信回执详情',
			width: 700,
			height: 350,
			modal: true,
			cache: false,
			onClose:function(){
				$(this).dialog('destroy');
			},
			href: basePath+"Main/smsMg/getRPTview/"+smid
		});
	}
	function sendRECFN(value,row,index){
		if(value==null|| value==''){
			return '';
		}else{
			var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
				+"<a href=\"javascript:void(0);\" onclick=\"openRECE_sms('"+row.MOBILEID+"','"+value+"')\" >查看</a></li></ul>";
			return act;
		}
	}
	function openRECE_sms(id,smid){
		$(document.body).append("<div id='_RECE_smsDialog'></div>");
		$("#_RECE_smsDialog").dialog({
			title:'短信详情',
			width: 800,
			height: 550,
			modal: true,
			cache: false,
			onClose:function(){
				$(this).dialog('destroy');
			},
			href: basePath+"Main/smsMg/view/send-"+id+"-"+smid,
		});
	}
	
	function relaEvent(){
		var rows = $("#smsSendGrid").datagrid("getChecked");
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
			return;
		}else{
			var ids = "";
			var smid = "";
			for(var i=0;i<rows.length;i++){
				if(i==0){
					ids=rows[i].MOBILEID;
					smid=rows[i].SM_ID;
				}else{
					ids=ids+","+rows[i].MOBILEID;
					smid=smid+","+rows[i].SM_ID;
				}
			}
			$(document.body).append("<div id='relaEventSmsDialog'></div>");
			$("#relaEventSmsDialog").dialog({
				title:'关联事件',
				width: 800,
				height: 400,
				href: basePath+"Main/smsMg/getSmsEvent",
				onClose:function(){
					$(this).dialog('destroy');
				},
				buttons: [{text:'确定',
					iconCls:'icon-ok',
					handler:function(){
			    		var re = $("#_relaEventGrid").datagrid("getSelected");
			    		if(re){
			    			$.ajax({
				            	url:basePath+"Main/smsMg/relaEvent",
				            	type:'post',
				            	dataType:'json',
				            	traditional:true,
				            	data:{'smid':smid,'eventid':re.ID},
				            	success:function(data){
				            		if(data.success){
										$.lauvan.MsgShow({msg:'关联成功！'});
				            			$("#relaEventSmsDialog").dialog('close');
				            			$("#smsSendGrid").datagrid('reload');
				            		}
				            		else{
				            			$("#_relaEventGrid").datagrid('clearSelections');
				            			$("#_relaEventGrid").datagrid('clearChecked');
				            			$.messager.alert('错误',data.msg,data.errorcode);
				            		}
				            	}
				            });
			    		}else{
				    		alert("请选择要关联的事件！");
			    		}
					}}]
				});
		}
	}
	
	function unrelaEvent(){
		var rows = $("#smsSendGrid").datagrid("getChecked");
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
			return;
		}else{
			var ids = "";
			var smid = "";
			for(var i=0;i<rows.length;i++){
				if(i==0){
					ids=rows[i].MOBILEID;
					smid=rows[i].SM_ID;
				}else{
					ids=ids+","+rows[i].MOBILEID;
					smid=smid+","+rows[i].SM_ID;
				}
			}
			$.messager.confirm('取消关联',"您确定取消短信关联的事件？",function(r){
				if(r){
					$.ajax({
		            	url:basePath+"Main/smsMg/relaEvent",
		            	type:'post',
		            	dataType:'json',
		            	traditional:true,
		            	data:{'smid':smid,'flag':'unrelate'},
		            	success:function(data){
		            		if(data.success){
								$.lauvan.MsgShow({msg:'取消关联成功！'});
								$("#smsSendGrid").datagrid('clearSelections');
		            			$("#smsSendGrid").datagrid('clearChecked');
		            			$("#smsSendGrid").datagrid('reload');
		            		}
		            		else{
		            			$.messager.alert('错误',data.msg,data.errorcode);
		            		}
		            	}
      				});
				}
			});
		}
	}
	function smsEventLFN(value,row,index){
		return _eventEditFN(row.EVENTID,row.EV_STATE,value,'smssend_doSearch()');
	}
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>短信内容：</span>
			<input id="scontent_s" type="text" class="easyui-textbox" >
			<span>接收号码：</span>
			<input id="phonenum_s" type="text" class="easyui-textbox" >
			<span>收件人：</span>
			<input id="smobname_s" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smssend_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="smsSendGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			        	<th field="SIMPLEPHONE" width="150">接收号码</th> 
			            <th field="SIMPLEPNAME" width="150">收件人</th> 
			            <th field="SIMPLECONT" width="200"  >短信内容</th>
			            <th field="SEND_TIME" width="100" >发送时间</th>
			            <th field="SEND_USER" width="100" >发送人</th>
			            <th field="SEND_STATE" width="100" formatter="sendStateFN">发送状态</th>
			            <th field="REPSMID" width="60" formatter="sendRPTFN">回执</th>
			             <!-- <th field="RECSMID" width="50" formatter="sendRECFN">回复</th> -->
			            <th field="EV_NAME" width="100" formatter="smsEventLFN" >关联事件</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
<div id="smsViewDialog"></div>