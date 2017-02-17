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
                  { text: '新建草稿',title:'新建草稿', iconCls: 'icon-add',handler:addMail}, '-',
                  { text: '编辑',title:'编辑邮件', iconCls: 'icon-add',handler:edMailR}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/mail/cgDel'}} 
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/mail/getEditGrid",
		onDblClickRow:function(rowIndex, rowData){
			viewMail(rowData.ID,'edit');
		}
		};
		$.lauvan.dataGrid("mailEditGrid",attrArray);
		});

	
	function mailedit_doSearch(){
		$('#mailEditGrid').datagrid('load',{
			subject: $('#editsubject').val(),
			ename:$('#editrecename').val(),
			marktime:$('#marktime').datebox('getValue')
		});
	}
	
	
	//转发邮件
	function edMailR(){
		mailAct('mailEditGrid','upd');
	}
	
	function relaEvMail_R(){
		var rows = $("#mailEditGrid").datagrid("getChecked");
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
				            	data:{'mid':mid,'eventid':re.ID,'flag':'cg_rela'},
				            	success:function(data){
				            		if(data.success){
										$.lauvan.MsgShow({msg:'关联成功！'});
				            			$("#relaEventSmsDialog").dialog('close');
				            			$("#mailEditGrid").datagrid('reload');
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
		var rows = $("#mailEditGrid").datagrid("getChecked");
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
		            	data:{'mid':mid,'flag':'cg_unrela'},
		            	success:function(data){
		            		if(data.success){
								$.lauvan.MsgShow({msg:'取消关联成功！'});
								$("#mailEditGrid").datagrid('clearSelections');
		            			$("#mailEditGrid").datagrid('clearChecked');
		            			$("#mailEditGrid").datagrid('reload');
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
	
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>主题：</span>
			<input id="editsubject" type="text" class="easyui-textbox" >
			<span>收件人：</span>
			<input id="editrecename" type="text" class="easyui-textbox" >
			<span>编辑时间：</span>
			<input id="marktime" type="text" class="easyui-datebox" data-options="editable:false,icons:iconClear" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="mailedit_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="mailEditGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="SUBJECT" width="150">主题</th>
			        	<th field="ADDRESS_TO" width="150">收件人</th> 
			            <th field="MARKTIME" width="200" >编辑时间</th>
			            <th field="EV_NAME" width="100" >关联事件</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>