<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var basePath = '<%=basePath%>';
	var property = {
			width:1000,
			height:100,
			haveHead:false,
			haveTool:false,
			haveGroup:false,
			useOperStack:false,
		};
	var button = [{
		text:'存为草稿',
		iconCls:'icon-save',
		handler:function(){
			$("#instanceform").form('options').queryParams={'act':'upd'};
			$.lauvan.dialogSubmit('instanceform','wfInstanceDialog');
		}
	},{
		text:'提交',
		iconCls:'icon-ok',
		handler:function(){
			$("#instanceform").form('options').queryParams={'act':'add'};
			$.lauvan.dialogSubmit('instanceform','wfInstanceDialog');
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#wfInstanceDialog").dialog('close');
		}
	}]
	$(function(){
		var attrArray={
				toolbar: [
		                   { text: '添加',title:'申请', iconCls: 'icon-add',
			                   dialogParams:{dialogId:'wfInstanceDialog',href:basePath+"Main/wfInstance/add",width:900,
								height:500,formId:'instanceform',isNoParam:true,buttons:button}}, '-', 
		                   { text: '修改',title:'申请编辑',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'wfInstanceDialog',href:basePath+"Main/wfInstance/edit",width:900,
										height:500,formId:'instanceform',buttons:button}}, '-',
		                   { text: '删除',iconCls: 'icon-delete',ajaxParams:{url:basePath+'Main/wfInstance/delete'},handler:delInstance},'-', 
		                   { text: '回撤',iconCls: 'icon-redo',ajaxParams:{url:basePath+'Main/wfInstance/redo'},handler:redoInstance},'-', 
		                   { text: '详情',title:'详情',iconCls: 'icon-tip', 
			                   dialogParams:{dialogId:'wfInstanceDialog',href:basePath+"Main/wfInstance/getMoreDetalis",width:900,
									height:500,buttons:[{text:'关闭',iconCls:'icon-no',handler:function(){$("#wfInstanceDialog").dialog('close');}}]}}
		                  ],
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/wfInstance/getGridData",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px;"><div id="wfimgI-'+index+'"></div><div id="cdv-' + index + '"></div></div>';
				},
				onExpandRow: function(index,row){
					//展示流程图
					if(row.FTYPE=='00A'){
						$("#wfimgI-"+index).empty();
						$.ajax({
							url:basePath+"Main/wfInstance/getWFimg/"+row.ID,
			            	type:'post',
			            	dataType:'json',
			            	traditional:true,
			            	async: false,
			            	data:{'id':row.ID},
			            	success:function(data){
			            		var demo = $.createGooFlow($("#wfimgI-"+index),property);
			        			demo.clearData();
			        			demo.$max =20;
			        			demo.loadData(data);
			            	}
						});
					}
					//展示内容
					$("#cdv-"+index).load(basePath+"Main/wfInstance/getContent",{"formid":row.FORMID,"contentid":row.CONTENT,"cdiv":"_cwfdiv-"+index,"instid":row.ID},function(){
						$('#instancegrid').datagrid('fixDetailRowHeight',index);});
					
				}
        };
		$.lauvan.dataGrid("instancegrid",attrArray);
		
	});

	
	
	function delInstance(){
		var rows=$("#instancegrid").datagrid('getSelected');
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
	            			$("#instancegrid").datagrid('clearSelections');
	            			$("#instancegrid").datagrid('clearChecked');
	            			$("#instancegrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function redoInstance(){
		var rows=$("#instancegrid").datagrid('getSelected');
		var options=$(this).linkbutton("options");
		var paramsList=options.ajaxParams;
		var btext = options.text;
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲'+btext+'的数据!'});
			return;
		}
		$.messager.prompt(btext,'请输入'+btext+'原因：',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:paramsList.url,
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'id':ids,'content':r},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据'+btext+'成功'});
	            			$("#instancegrid").datagrid('clearSelections');
	            			$("#instancegrid").datagrid('clearChecked');
	            			$("#instancegrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function wfInstance_doSearch(){
		$('#instancegrid').datagrid('load',{
			title: $('#fname').val(),
			status: $('#fstatus').combobox('getValue'),
			type: $('#ftype').combobox('getValue')
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:f7f7f7;">
			<span>标题:</span>
			<input id="fname" type="text" class="easyui-textbox" >
			<span>类型:</span>
			<select id="ftype" class="easyui-combobox"  panelHeight="auto" code="LCLX" style="width: 100px;">
			</select>
			<span>状态:</span>
			<select id="fstatus" class="easyui-combobox"  panelHeight="auto" code="WFZT" style="width: 100px;">
			</select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="wfInstance_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="instancegrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="150">标题</th> 
			            <th field="CHECKNAME" width="100"  >当前操作人</th>
			            <th field="MARKTIME" width="150" >申请时间</th>
			            <th field="TCODE" width="100" code="LCLX" >类型</th>
			            <th field="STATUS" width="100" code="WFZT" >状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

