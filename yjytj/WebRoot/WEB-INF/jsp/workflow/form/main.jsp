<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray={
				toolbar: '#form_tb',
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/wfForm/getGridData",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px"><table id="_wfForm_ddv-' + index + '"></table></div>';
				},
				onExpandRow: function(index,row){
					$('#_wfForm_ddv-'+index).datagrid({
						url:basePath+'Main/wfForm/getGridDataView?fcode='+row.FCODE,
						fitColumns:true,
						singleSelect:true,
						rownumbers:true,
						loadMsg:'',
						height:'auto',
						columns:[[
							{field:'ATTRNAME',title:'属性名称',width:200},
							{field:'SQLTYPE',title:'属性类型',width:150,formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '时间类型';
			                      }else if(value=='011'){
			                    	  return '日期类型';
			                      }else if(value=='002'){
			                    	  return '数值类型';
			                      }else if(value=='003'){
			                    	  return '布尔类型';
			                      }else if(value=='004'){
			                    	  return '字符类型';
			                      }else if(value=='005'){
			                    	  return '文本类型';
			                      }else if(value=='006'){
			                    	  return '下拉类型';
			                      }else{
			                    	  return value;
			                      }
		                      }},
							{field:'DEFVALUE',title:'默认标志',width:100 ,formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '申请人名称';
			                      }else if(value=='002'){
				                      return '申请部门名称';
			                      }else if(value=='003'){
			                    	  return '申请人名称（可编辑）';
			                      }else{
			                    	  return value;
			                      }
		                      }},
							{field:'NUMGS',title:'数值格式',width:100},
							{field:'SYMBOL',title:'统计标志',width:100,formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '开始时间';
			                      }else if(value=='002'){
			                    	  return '结束时间';
			                      }else{
			                    	  return value;
			                      }
		                      }},
							{field:'SELCONTENT',title:'下拉列表字段',width:200},
							{field:'SELFALG',title:'下拉其他标志',width:100,formatter: function(value,row,index){
			                      if(value=='0'){
				                      return '否';
			                      }else if(value=='1'){
			                    	  return '是';
			                      }else{
			                    	  return value;
			                      }
		                      }},
							{field:'REMARK',title:'描述',width:300}
						]],
						onResize:function(){
							$('#formgrid').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#formgrid').datagrid('fixDetailRowHeight',index);
							},0);
						}
					});
					$('#formgrid').datagrid('fixDetailRowHeight',index);
				},
				onDblClickRow:function(rowIndex, rowData){
					var attrArray={
							title:'表单设计',
							width: 1000,
							height: 500,
							href: basePath+"Main/wfForm/view/"+rowData.ID,
							buttons:[]
					};
					
					$.lauvan.openCustomDialog("formDSView",attrArray,null);
				}
        };
		$.lauvan.dataGrid("formgrid",attrArray);
		
	});

	function addForm(){
		var attrArray={
				title:'表单设计',
				width: 1000,
				height: 500,
				maximized:true,
				href: basePath+"Main/wfForm/add"
		};
		
		$.lauvan.openCustomDialog("formDSDialog",attrArray,wfForm_dialogSubmit);
		
	}

	var editRowType=undefined;
	function wfForm_dialogSubmit(){
  		$('#wf_form').form('submit',{
  			onSubmit:function(param){
  				//属性值非空
  				var rows=[];
  				rows = $("#attrGrid").datagrid("getRows");
  				if(rows==null ||rows.length==0){
  					$.messager.alert('错误','属性值非空,请添加属性值！','error');
  	                return false;
  				}
  				if (editRowType != undefined) {
	  					$("#attrGrid").datagrid("endEdit", editRowType);
                }
                var djson = JSON.stringify(rows);
                if(djson.indexOf("{}")>=0){
                	$.messager.alert('错误','请填写完整属性值信息！','error');
                	return false;
                }
              //统计开始标志和结束标志成对出现
                if(djson.indexOf("SYMBOL:001")>=0 && djson.indexOf("SYMBOL:002")<0){
                	$.messager.alert('错误','请填写统计时间的结束标志！','error');
                	return false;
                }
                if(djson.indexOf("SYMBOL:002")>=0 && djson.indexOf("SYMBOL:001")<0){
                	$.messager.alert('错误','请填写统计时间的开始标志！','error');
                	return false;
                }
  				//若为下拉类型，下拉属性值非空
                for(var i=rows.length-1;i>=0;i--){
                    var name = "_attrname_"+i;
                    param[name] = rows[i].ATTRNAME;
                    name = "_sqltype_"+i;
                    param[name] = rows[i].SQLTYPE;
                    name = "_symbol_"+i;
                    param[name] = rows[i].SYMBOL;
                    name = "_defvalue_"+i;
                    param[name] = rows[i].DEFVALUE;
                    name = "_numgs_"+i;
                    param[name] = rows[i].NUMGS;
                    name = "_selcontent_"+i;
                    param[name] = rows[i].SELCONTENT;
                    name = "_selfalg_"+i;
                    param[name] = rows[i].SELFALG;
                    name = "_remark_"+i;
                    param[name] = rows[i].REMARK;
                    if(rows[i].SQLTYPE=='006' && (rows[i].SELCONTENT==null || rows[i].SELCONTENT=='')){
                    	$.messager.alert('错误','请填写下拉列表字段！','error');
                    	return false;
                    }
                }
                param.fnum = rows.length;
  				
  				
				return $(this).form('enableValidation').form('validate');
			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
  	
	function delForm(){
		var rows=$("#formgrid").datagrid('getSelected');
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:basePath+"Main/wfForm/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'fid':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#formgrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function form_doSearch(){
		$('#formgrid').datagrid('load',{
			fname: $('#fname').val(),
			fcode: $('#fcode').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="form_tb">
		<span>表单名称:</span>
		<input id="fname" type="text" class="easyui-textbox" value="${fname}">
		<span>表单编码:</span>
		<input id="fcode" type="text" class="easyui-textbox" value="${fcode}">
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="form_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		<a href="javascript:void(0);" onclick="addForm()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:void(0);" onclick="delForm()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>
			<table id="formgrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="FNAME" width="100">表单名称</th> 
			            <th field="FCODE" width="180">表单编码</th> 
			            <th field="REMARK" width="300">描述</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>


