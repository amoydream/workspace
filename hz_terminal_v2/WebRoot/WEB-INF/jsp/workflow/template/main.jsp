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
				toolbar: '#wfTemplate_tb',
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/wfTemplate/getGridData",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px;"><div id="wfimg-'+index+'"></div><table id="_wftemp_ddv-' + index + '"></table></div>';
				},
				onExpandRow: function(index,row){
					//展示流程图
					if(row.FTYPE=='00A'){
						$("#wfimg-"+index).empty();
						$.ajax({
							url:basePath+"Main/wfTemplate/getWFimg/"+row.ID,
			            	type:'post',
			            	dataType:'json',
			            	traditional:true,
			            	async: false,
			            	data:{'id':row.ID},
			            	success:function(data){
			            		var demo = $.createGooFlow($("#wfimg-"+index),property);
			        			demo.clearData();
			        			demo.$max =20;
			        			demo.loadData(data);
			            	}
						});
					}
					//展示节点内容
					$('#_wftemp_ddv-'+index).datagrid({
						url:basePath+'Main/wfTemplate/getGridDataView?id='+row.ID,
						fitColumns:true,
						singleSelect:true,
						rownumbers:true,
						loadMsg:'',
						height:'auto',
						columns:[[
							{field:'PNAME',title:'节点名称',width:200},
							{field:'PTYPE',title:'节点类型',width:150,formatter: function(value,row,index){
			                      if(value=='00A'){
				                      return '普通';
			                      }else if(value=='00H'){
			                    	  return '会签';
			                      }else{
			                    	  return value;
			                      }
		                      }},
							{field:'CHECKNAME',title:'审批人',width:300 }
						]],
						onResize:function(){
							$('#wfTemplategrid').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#wfTemplategrid').datagrid('fixDetailRowHeight',index);
							},0);
						}
					});
					$('#wfTemplategrid').datagrid('fixDetailRowHeight',index);
				}
        };
		$.lauvan.dataGrid("wfTemplategrid",attrArray);
		
	});

	function addTemplate(){
		var attrArray={
				title:'流程设计',
				width: 700,
				height: 500,
				href: basePath+"Main/wfTemplate/add"
		};
		
		$.lauvan.openCustomDialog("wftemplateDSDialog",attrArray,wfTemplate_dialogSubmit);
		
	}

	function updTemplate(){
		var row=$("#wfTemplategrid").datagrid('getSelected');
		if(row){
			var attrArray={
					title:'流程设计',
					width: 700,
					height: 500,
					href: basePath+"Main/wfTemplate/update/"+row.ID
			};
			
			$.lauvan.openCustomDialog("wftemplateDSDialog",attrArray,wfTemplate_dialogSubmit);
		}else{
			$.messager.alert('错误',"请选择流程！","error");
		}
	}

	var editRowType=undefined;
	function wfTemplate_dialogSubmit(){
  		$('#wfTemplate').form('submit',{
  			onSubmit:function(param){
  				var ttype = $("#wftemplatetype").combobox('getValue');
  				if("00A"==ttype){
  				//流程节点非空
  	  				var rows=[];
  	  				rows = $("#attrGrid").datagrid("getRows");
  	  				if(rows==null ||rows.length==0){
  	  					$.messager.alert('错误','流程节点属性值非空,请添加属性值！','error');
  	  	                return false;
  	  				}
  	  				if (editRowType != undefined) {
  		  					$("#attrGrid").datagrid("endEdit", editRowType);
  	                }
  	                var djson = JSON.stringify(rows);
  	                if(djson.indexOf("{}")>=0){
  	                	$.messager.alert('错误','请填写完整流程节点属性值信息！','error');
  	                	return false;
  	                }
	  	            for(var i=0;i<rows.length;i++){
	                      var name = "_pointid_"+i;
	                      param[name] = rows[i].ID;
	                      name = "_pointname_"+i;
	                      param[name] = rows[i].PNAME;
	                      name = "_pointtype_"+i;
	                      param[name] = rows[i].PTYPE;
	                      name = "_checkuser_"+i;
	                      param[name] = rows[i].CHECKUSER;
	                  }
	                  param.pnum = rows.length;
  				}
				return $(this).form('enableValidation').form('validate');
			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
  	
	function delTemplate(){
		var rows=$("#wfTemplategrid").datagrid('getSelected');
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:basePath+"Main/wfTemplate/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'fid':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#wfTemplategrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function wfTemplate_doSearch(){
		$('#wfTemplategrid').datagrid('load',{
			fname: $('#fname').val(),
			fstatus: $('#fstatus').combobox('getValue'),
			tcode: $('#tcode').combobox('getValue')
		});
	}
	function wfcodeformatter(value,row,index){
		return "WF"+value;
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div id="wfTemplate_tb">
		<span>名称:</span>
		<input id="fname" type="text" class="easyui-textbox" >
		<span>状态:</span>
		<select id="fstatus" class="easyui-combobox"  panelHeight="auto" code="LCZT" style="width: 100px;">
		</select>
		<span>类型:</span>
		<select id="tcode" class="easyui-combobox" code="LCLX" panelHeight="auto" style="width: 100px;"></select>
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="wfTemplate_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		<a href="javascript:void(0);" onclick="addTemplate()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:void(0);" onclick="updTemplate()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a href="javascript:void(0);" onclick="delTemplate()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="wfTemplategrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="TNAME" width="150">名称</th> 
			            <th field="ID" width="100" formatter="wfcodeformatter" >编码</th>
			            <th field="FTYPE" width="100" code="LCFS">方式</th>
			            <th field="TCODE" width="100" code="LCLX" >类型</th>
			            <th field="STATUS" width="100" code="LCZT" >状态</th>
			            <th field="REMARK" width="300">描述</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

