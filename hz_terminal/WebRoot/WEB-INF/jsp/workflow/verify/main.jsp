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
	$(function(){
		var attrArray={
				toolbar: [ 
		                   { text: '审批',title:'审批',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'wfVerifyDialog',href:basePath+"Main/wfVerify/verify",width:900,
										height:500,formId:'verifyform'}}
		                  ],
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/wfVerify/getDataGrid",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px;"><div id="wfimgI-'+index+'"></div><div id="cdv-' + index + '"></div></div>';
				},
				onExpandRow: function(index,row){
					//展示流程图
					if(row.FTYPE=='00A'){
						$("#wfimgI-"+index).empty();
						$.ajax({
							url:basePath+"Main/wfInstance/getWFimg/"+row.INSTID,
			            	type:'post',
			            	dataType:'json',
			            	traditional:true,
			            	async: false,
			            	success:function(data){
			            		var demo = $.createGooFlow($("#wfimgI-"+index),property);
			        			demo.clearData();
			        			demo.$max =20;
			        			demo.loadData(data);
			            	}
						});
					}
					//展示内容
					$("#cdv-"+index).load(basePath+"Main/wfInstance/getContent",{"formid":row.FORMID,"contentid":row.CONTENTID,"cdiv":"_cwfdiv-"+index,"instid":row.INSTID},
							function(){$('#verifygrid').datagrid('fixDetailRowHeight',index);});
					
				}
        };
		$.lauvan.dataGrid("verifygrid",attrArray);
		
	});

	
	function wfVerify_doSearch(){
		$('#verifygrid').datagrid('load',{
			title: $('#fname').val(),
			status: $('#fstatus').combobox('getValue'),
			applyer: $('#fapplyer').val()
		});
	}
	function ctypeformatterVER(value,row,index){
		if (value=='00S'){
			return "同意";
		}else if(value=='00X'){
			return "不同意";
		}else {
			return value;
		}
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:f7f7f7;">
			<span>标题:</span>
			<input id="fname" type="text" class="easyui-textbox" >
			<span>申请人:</span>
			<input id="fapplyer" type="text" class="easyui-textbox" >
			</select>
			<span>审批结果:</span>
			<select id="fstatus" class="easyui-combobox"  panelHeight="auto"  style="width: 100px;">
				<option value="">未处理</option>
				<option value="00S">同意</option>
				<option value="00X">不同意</option>
			</select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="wfVerify_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="verifygrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="150">标题</th> 
			            <th field="USER_NAME" width="100"  >申请人</th>
			            <th field="APPLYTIME" width="150" >申请时间</th>
			            <th field="TCODE" width="100" code="LCLX" >类型</th>
			            <th field="CHECKTYPE" width="100" formatter="ctypeformatterVER" >审批结果</th>
			            <th field="CONTENT" width="150" >审批内容</th>
			            <th field="MARKTIME" width="150" >审批时间</th> 
			            <th field="STATUS" width="100" code="WFZT">申请状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

