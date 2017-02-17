<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray={
				//toolbar: '#proobjtable_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addproobjtable,permitParams:'${pert:hasperti(applicationScope.protableadd, loginModel.xdlimit)}'}, '-', 
                  { text: '删除',iconCls: 'icon-delete',handler:delproobjtable,permitParams:'${pert:hasperti(applicationScope.protabledel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',/* 
				frozenColumns:[[]], */
				url:basePath+"Main/protectobjtable/getGridData",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px"><table id="_proobjtable_ddv-' + index + '"></table></div>';
				},
				onExpandRow: function(index,row){
					$('#_proobjtable_ddv-'+index).datagrid({
						url:basePath+'Main/protectobjtable/getGridDataView?fcode='+row.FCODE,
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
		                    { field: 'ATTRSIZE', title: '属性大小', width: 100},
		                    { field: 'ISNULL', title: '是否非空', width: 100,formatter: function(value,row,index){
				                 if(value=='1'){
			                    	  return '是';
			                      }else if(value=='0'){
			                    	  return '否';
			                      }else{
			                    	  return value;
			                      }
				                 }},
				            { field: 'ISVIEW', title: '是否展示', width: 100,formatter: function(value,row,index){
				                 if(value=='1'){
			                    	  return '是';
			                      }else if(value=='0'){
			                    	  return '否';
			                      }else{
			                    	  return value;
			                      }
				                 }},
							{field:'NUMGS',title:'数值格式',width:100},
							{field:'SELCONTENT',title:'下拉列表字段',width:200},
							{field:'SELVALUE',title:'下拉列表对应值',width:200},
							{field:'SELFALG',title:'是否读取参数',width:100,formatter: function(value,row,index){
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
							$('#proobjtablegrid').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#proobjtablegrid').datagrid('fixDetailRowHeight',index);
							},0);
						}
					});
					$('#proobjtablegrid').datagrid('fixDetailRowHeight',index);
				},
				onDblClickRow:function(rowIndex, rowData){
					var attrArray={
							title:'表单设计',
							width: 1000,
							height: 500,
							href: basePath+"Main/protectobjtable/view/"+rowData.ID,
							buttons:[]
					};
					
					$.lauvan.openCustomDialog("proobjtableView",attrArray,null);
				}
        };
		$.lauvan.dataGrid("proobjtablegrid",attrArray);
		
	});

	function addproobjtable(){
		var attrArray={
				title:'表单设计',
				width: 1000,
				height: 500,
				maximized:true,
				href: basePath+"Main/protectobjtable/add"
		};
		
		$.lauvan.openCustomDialog("proobjtableDialog",attrArray,proobjtable_dialogSubmit);
		
	}

	var editRowType=undefined;
	function proobjtable_dialogSubmit(){
  		$('#proobjtable').form('submit',{
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
  				//若为下拉类型，下拉属性值非空
                for(var i=rows.length-1;i>=0;i--){
                    var name = "_attrname_"+i;
                    param[name] = rows[i].ATTRNAME;
                    name = "_sqltype_"+i;
                    param[name] = rows[i].SQLTYPE;
                    name = "_attrsize_"+i;
                    param[name] = rows[i].ATTRSIZE;
                    name = "_isnull_"+i;
                    param[name] = rows[i].ISNULL;
                    name = "_isview_"+i;
                    param[name] = rows[i].ISVIEW;
                    name = "_numgs_"+i;
                    param[name] = rows[i].NUMGS;
                    name = "_selcontent_"+i;
                    param[name] = rows[i].SELCONTENT;
                    name = "_selvalue_"+i;
                    param[name] = rows[i].SELVALUE;
                    name = "_selfalg_"+i;
                    param[name] = rows[i].SELFALG;
                    name = "_remark_"+i;
                    param[name] = rows[i].REMARK;
                    if(rows[i].SQLTYPE=='002'||rows[i].SQLTYPE=='004'||rows[i].SQLTYPE=='006'){
                    if(rows[i].ATTRSIZE!=null||rows[i].ATTRSIZE!=''){
                    if(rows[i].SQLTYPE=='002'){
                    var sizelist=rows[i].ATTRSIZE.split(",");
                    if(sizelist.length==1){
                    if(isNaN(rows[i].ATTRSIZE)||parseInt(rows[i].ATTRSIZE)>21){
                        $.messager.alert('错误','属性大小必须为数字且小于21！','error');
                        return false;	
                     }	
                    }else if(sizelist.length==2){
                    if(isNaN(sizelist[0])||sizelist[0]>21){
                    	$.messager.alert('错误','长度必须为数字且小于21！','error');
                        return false;	
                    }	
                    if(isNaN(sizelist[1])||sizelist[1]>5){
                    	$.messager.alert('错误','精度必须为数字且小于5！','error');
                        return false;
                    }
                    }
                    }else{
                    if(isNaN(rows[i].ATTRSIZE)||parseInt(rows[i].ATTRSIZE)>=4000){
                    	$.messager.alert('错误','属性大小必须为数字且小于4000！','error');
                    	return false;	
                    }	
                    }	
                    }	
                    }
                    if(rows[i].SQLTYPE=='006' && (rows[i].SELCONTENT==null || rows[i].SELCONTENT=='')){
                    	$.messager.alert('错误','请填写下拉列表字段！','error');
                    	return false;
                    }
                    if(rows[i].SQLTYPE=='006' &&rows[i].SELFALG==null?true:rows[i].SELFALG=='0'&& (rows[i].SELVALUE==null || rows[i].SELVALUE=='')){
                    	$.messager.alert('错误','请填写下拉列表对应值字段！','error');
                    	return false;
                    }
                    var contentlist=rows[i].SELCONTENT.split(",");
                    var valuelist=rows[i].SELVALUE.split(",");
                    if(contentlist.length!=valuelist.length){
                    	$.messager.alert('错误','下拉列表字段个数与下拉列表对应值字段个数不一致！','error');
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
  	
	function delproobjtable(){
		/* var rows=$("#proobjtablegrid").datagrid('getSelected');
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#proobjtablegrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	//var ids=rows.ID;
		       $.ajax({
	            	url:basePath+"Main/protectobjtable/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	//data:{'fid':ids},
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#proobjtablegrid").datagrid('clearSelections');
	            			$("#proobjtablegrid").datagrid('clearChecked');
	            			$("#proobjtablegrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function proobjtable_doSearch(){
		$('#proobjtablegrid').datagrid('load',{
			formname: $('#formname').val(),
			formcode: $('#formcode').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
  <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
        <span>表单名称:</span>
		<input id="formname" type="text" class="easyui-textbox">
		<span>表单编码:</span>
		<input id="formcode" type="text" class="easyui-textbox">
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="proobjtable_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
  </div>
		<div data-options="region:'center',border:false">
			<table id="proobjtablegrid" cellspacing="0" cellpadding="0"> 
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


