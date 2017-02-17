<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray={
				toolbar: '#autoObj_tb',
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/autoObject/getGridData",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px"><table id="ddv-' + index + '"></table></div>';
				},
				onExpandRow: function(index,row){
					$('#ddv-'+index).datagrid({
						url:basePath+'Main/autoObject/getGridDataView?tcode='+row.TABLE_CODE,
						fitColumns:true,
						singleSelect:true,
						rownumbers:true,
						loadMsg:'',
						height:'auto',
						columns:[[
							{field:'ATTRNAME',title:'字段名称',width:200},
							{field:'ATTRCODE',title:'字段编码',width:200},
			                  { field: 'ATTRTYPE', title: '字段类型', width: 100,
			                      editor: { type: 'combobox', options: { required: true,valueField: 'label1',textField: 'value1',panelHeight:"auto",
			                	 data: [{label1: '001',value1: '字符类型'},{label1: '002',value1: '数值类型'},
					                	{label1: '003',value1: '日期类型'},{label1: '004',value1: '文本类型'},
					                	{label1: '005',value1: '浮点类型'}]
			                      } },formatter: function(value,row,index){
				                      if(value=='001'){
					                      return '字符类型';
				                      }else if(value=='002'){
				                    	  return '数值类型';
				                      }else if(value=='003'){
				                    	  return '日期类型';
				                      }else if(value=='004'){
				                    	  return '文本类型';
				                      }else if(value=='005'){
				                    	  return '浮点类型';
				                      }else{
				                    	  return value;
				                      }
			                      }
			                  },
			                   { field: 'ISPKID', title: '是否主键', width: 100,
			                       editor: { type: 'checkbox',options:{  on: "1",  off: "0"  } }
				                  ,formatter: function(value,row,index){
				                	  if(value=='1'){
					                      return "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\"   >";
				                      }else if(value=='0'){
				                    	  return "<input type=\"checkbox\"  disabled=\"disabled\"  >";
				                      }else{
				                    	  return value;
				                      }
			                      }
			                   },
			                   {field:'REMARK',title:'备注',width:200}
						]],
						onResize:function(){
							$('#objtable').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#objtable').datagrid('fixDetailRowHeight',index);
							},0);
						}
					});
					$('#objtable').datagrid('fixDetailRowHeight',index);
				}
        };
		$.lauvan.dataGrid("objtable",attrArray);
		
	});

	function addOBJ(){
		var attrArray={
				title:'新增对象',
				width: 1000,
				height: 500,
				maximized:true,
				href: basePath+"Main/autoObject/add"
		};
		$.lauvan.openCustomDialog("autoObjDialog",attrArray,autoOBJ_dialogSubmit);
	}

	var editRowType=undefined;
	function autoOBJ_dialogSubmit(){
  		$('#autoDBA').form('submit',{
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
                    name = "_attrcode_"+i;
                    param[name] = rows[i].ATTRCODE;
                    name = "_acodelen_"+i;
                    param[name] = rows[i].ACODELEN
                    name = "_attrtype_"+i;
                    param[name] = rows[i].ATTRTYPE;
                    name = "_ispkid_"+i;
                    param[name] = rows[i].ISPKID;
                    name = "_remark_"+i;
                    param[name] = rows[i].REMARK;
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
  	
	function delOBJ(){
		var rows=$("#objtable").datagrid('getSelected');
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:basePath+"Main/autoObject/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'tid':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#objtable").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function autoObj_doSearch(){
		$('#objtable').datagrid('load',{
			objName: $('#objName').val(),
			objCode: $('#objCode').val()
		});
	}
	function dbaformatter(value,row,index){
		if(value!=null && value!=''){
			return value;
		}else{
			return '默认';
		}
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="autoObj_tb">
		<span>对象名称:</span>
		<input id="objName" type="text" class="easyui-textbox" >
		<span>对象编码:</span>
		<input id="objCode" type="text" class="easyui-textbox" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="autoObj_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		<a href="javascript:void(0);" onclick="addOBJ()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:void(0);" onclick="delOBJ()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>
			<table id="objtable" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="ID"  data-options="hidden:true"></th> 
			            <th field="TABLE_CODE" width="150">表名</th>
			            <th field="TABLE_NAME" width="200">表中文名</th> 
			            <th field="DBA_TYPE" width="100" >数据库类型</th> 
			            <th field="DBA_NAME" width="100" formatter="dbaformatter" >数据源</th>
			            <th field="MODEL_PATH" width="200"  >数据源</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

