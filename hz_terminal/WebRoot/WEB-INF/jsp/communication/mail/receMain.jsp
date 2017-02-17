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
                  { text: '新增邮件',title:'新增邮件', iconCls: 'icon-add',handler:addMail}, '-',
                  { text: '转发',title:'转发邮件', iconCls: 'icon-add',handler:zfMailR}, '-',
                  { text: '回复',title:'回复', iconCls: 'icon-add',handler:replyMail}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/mail/receDel'}}, '-', 
                  { text: '关联事件',iconCls: 'icon-edit',handler:relaEvMail_R},'-',
                  { text: '取消关联事件',iconCls: 'icon-delete',handler:unrelaEvMail_R}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/mail/getReceGrid",
		onDblClickRow:function(rowIndex, rowData){
			viewMail(rowData.ID,'rece');
		}
		};
		$.lauvan.dataGrid("mailReceGrid",attrArray);
		});

	
	function mailrece_doSearch(){
		$('#mailReceGrid').datagrid('load',{
			subject: $('#mrsubject').val(),
			sname:$('#msendname').val(),
			sendtime:$('#mrsendtime').datebox('getValue'),
		});
	}
	
	//转发邮件
	function replyMail(){
		mailAct('mailReceGrid','reply');
	}
	
	//转发邮件
	function zfMailR(){
		mailAct('mailReceGrid','zfrece');
	}
	
	function relaEvMail_R(){
		var rows = $("#mailReceGrid").datagrid("getChecked");
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
			return;
		}else{
			//var ids = "";
			var mid = "";
			for(var i=0;i<rows.length;i++){
				if(i==0){
					//ids=rows[i].MOBILEID;
					mid=rows[i].ID;
				}else{
					//ids=ids+","+rows[i].MOBILEID;
					mid=mid+","+rows[i].ID;
				}
			}
			
			$(document.body).append("<div id='relaEventSmsDialog'></div>");
			$("#relaEventSmsDialog").dialog({
				title:'关联事件',
				width: 800,
				height: 400,
				href: basePath+"Main/mail/getMailEvent",
				onClose:function(){
					$(this).dialog('destroy');
				},
				buttons: [{text:'确定',
					iconCls:'icon-ok',
					handler:function(){
			    		var re = $("#_relaEventGrid").datagrid("getSelected");
			    		if(re){
			    			$.ajax({
				            	url:basePath+"Main/mail/relaEvent",
				            	type:'post',
				            	dataType:'json',
				            	traditional:true,
				            	data:{'mid':mid,'eventid':re.ID,'flag':'rece_rela'},
				            	success:function(data){
				            		if(data.success){
										$.lauvan.MsgShow({msg:'关联成功！'});
				            			$("#relaEventSmsDialog").dialog('close');
				            			$("#mailReceGrid").datagrid('reload');
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
	
	function unrelaEvMail_R(){
		var rows = $("#mailReceGrid").datagrid("getChecked");
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
			return;
		}else{
			var mid = "";
			for(var i=0;i<rows.length;i++){
				if(i==0){
					//ids=rows[i].MOBILEID;
					mid=rows[i].ID;
				}else{
					//ids=ids+","+rows[i].MOBILEID;
					mid=mid+","+rows[i].ID;
				}
			}
			$.messager.confirm('取消关联',"您确定取消短信关联的事件？",function(r){
				if(r){
					$.ajax({
		            	url:basePath+"Main/mail/relaEvent",
		            	type:'post',
		            	dataType:'json',
		            	traditional:true,
		            	data:{'mid':mid,'flag':'rece_unrela'},
		            	success:function(data){
		            		if(data.success){
								$.lauvan.MsgShow({msg:'取消关联成功！'});
								$("#mailReceGrid").datagrid('clearSelections');
		            			$("#mailReceGrid").datagrid('clearChecked');
		            			$("#mailReceGrid").datagrid('reload');
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
	
	function mailEventLFN(value,row,index){
		return _eventEditFN(row.EVENTID,row.EV_STATE,value,'mailrece_doSearch()');
	}
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>主题：</span>
			<input id="mrsubject" type="text" class="easyui-textbox" >
			<span>发件人：</span>
			<input id="msendname" type="text" class="easyui-textbox" >
			<span>接收时间：</span>
			<input id="mrsendtime" type="text" class="easyui-datebox" data-options="editable:false,icons:iconClear" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="mailrece_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="mailReceGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			        	<th field="SENDER" width="150">发件人</th> 
			            <th field="SUBJECT" width="150">主题</th> 
			            <th field="SEND_TIME" width="200"  >时间</th>
			            <th field="EV_NAME" width="100" formatter="mailEventLFN" >关联事件</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>