<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray={
				toolbar: '#autoView_tb',
				fitColumns : true,
				idField:'ID',
				frozenColumns:[[]],
				url:basePath+"Main/autoView/getDataGrid",
				view: detailview,
				detailFormatter:function(index,row){
					return '<div style="padding:2px"><table id="_view_ddv-' + index + '"></table></div>';
				},
				onExpandRow: function(index,row){
					$('#_view_ddv-'+index).datagrid({
						url:basePath+'Main/autoView/getGridDataView?id='+row.ID,
						fitColumns:true,
						singleSelect:true,
						rownumbers:true,
						loadMsg:'',
						height:'auto',
						columns:[[
							{field:'FILEDTEXT',title:'控件名称',width:200},
			                  { field: 'UITYPE', title: '控件类型', width: 100,
			                      editor: { type: 'combobox', options: { required: true,valueField: 'label1',textField: 'value1',panelHeight:"auto",
			                	 data: [{label1: '001',value1: '时间控件'},{label1: '002',value1: '输入框'},
					                	{label1: '003',value1: '下拉框'},{label1: '004',value1: '复选框'},
					                	{label1: '005',value1: '单选框'},{label1: '006',value1: '文本框'}]
			                      } },formatter: function(value,row,index){
				                      if(value=='001'){
					                      return '时间控件';
				                      }else if(value=='002'){
				                    	  return '输入框';
				                      }else if(value=='003'){
				                    	  return '下拉框';
				                      }else if(value=='004'){
				                    	  return '复选框';
				                      }else if(value=='005'){
				                    	  return '单选框';
				                      }else if(value=='006'){
				                    	  return '文本框';
				                      }else{
				                    	  return value;
				                      }
			                      }
			                  },
			                   { field: 'ISADD', title: '是否新增', width: 50,
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
			                   },{ field: 'ISEDIT', title: '是否修改', width: 50,
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
			                   },{ field: 'ISSEARCH', title: '是否查询', width: 50,
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
			                   },{ field: 'ISVIEW', title: '是否可见', width: 50,
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
			                   {field:'STATICVAL',title:'静态参数',width:100},
			                   {field:'DEAFULVAL',title:'变量值',width:100},
			                   {field:'UIVAL',title:'变量文本',width:200}
						]],
						onResize:function(){
							$('#autoViewtable').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#autoViewtable').datagrid('fixDetailRowHeight',index);
							},0);
						}
					});
					$('#autoViewtable').datagrid('fixDetailRowHeight',index);
				}
        };
		$.lauvan.dataGrid("autoViewtable",attrArray);
		
	});

	function addView(){
		var attrArray={
				title:'新增视图',
				width: 750,
				height: 500,
				href: basePath+"Main/autoView/add",
				buttons: [{
					text:'预览',
					iconCls:'icon-tip',
					handler:function(){
						autoView_dialogSubmit2();
					}
				},{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						autoView_dialogSubmit();
						}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$dialog.dialog('close');
					}
				}]
		};
		
		$.lauvan.openCustomDialog("autoViewDialog",attrArray,autoView_dialogSubmit);
		
	}

	var editRowType=undefined;
	function autoView_dialogSubmit(){
  		$('#autoView_form').form('submit',{
  			onSubmit:function(param){
  				//属性值非空
  				var rows=[];
  				rows = $("#attrGrid").datagrid("getRows");
  				if(rows==null ||rows.length==0){
  					$.messager.alert('错误','对象非空，请选择对象！','error');
  	                return false;
  				}
  				for(var j=0;j<rows.length;j++){
	  				$("#attrGrid").datagrid("endEdit", j);
  				}
  				
                //var djson = JSON.stringify(rows);
                //if(djson.indexOf("{}")>=0){
                //	$.messager.alert('错误','请填写完整属性值信息！','error');
               // 	return false;
                //}
  				//若为下拉类型，下拉属性值非空
                for(var i=0;i<rows.length;i++){
                    var name = "_attrid_"+i;
                    param[name] = rows[i].ID;
                    name = "_attrcode_"+i;
                    param[name] = rows[i].ATTRCODE;
                    name = "_attrtext_"+i;
                    param[name] = rows[i].ATTRNAME;
                    name = "_uitype_"+i;
                    param[name] = rows[i].UITYPE;
                    name = "_isadd_"+i;
                    param[name] = rows[i].ISADD;
                    name = "_isedit_"+i;
                    param[name] = rows[i].ISEDIT;
                    name = "_issearch_"+i;
                    param[name] = rows[i].ISSEARCH;
                    name = "_isview_"+i;
                    param[name] = rows[i].ISVIEW;
                    name = "_uival_"+i;
                    param[name] = rows[i].UIVAL;
                    name = "_staticval_"+i;
                    param[name] = rows[i].STATICVAL;
                    name = "_deafulval_"+i;
                    param[name] = rows[i].DEAFULVAL;
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

	function autoView_dialogSubmit2(){
		var param=$("#autoView_form").form('getData');
		//属性值非空
			var rows=[];
			rows = $("#attrGrid").datagrid("getRows");
			if(rows==null ||rows.length==0){
				$.messager.alert('错误','对象非空，请选择对象！','error');
              return false;
			}
			for(var j=0;j<rows.length;j++){
				$("#attrGrid").datagrid("endEdit", j);
			}
			
			//若为下拉类型，下拉属性值非空
        for(var i=0;i<rows.length;i++){
            var name = "_attrid_"+i;
            param[name] = rows[i].ID;
            name = "_attrcode_"+i;
            param[name] = rows[i].ATTRCODE;
            name = "_attrtext_"+i;
            param[name] = rows[i].ATTRNAME;
            name = "_uitype_"+i;
            param[name] = rows[i].UITYPE;
            name = "_isadd_"+i;
            param[name] = rows[i].ISADD;
            name = "_isedit_"+i;
            param[name] = rows[i].ISEDIT;
            name = "_issearch_"+i;
            param[name] = rows[i].ISSEARCH;
            name = "_isview_"+i;
            param[name] = rows[i].ISVIEW;
            name = "_uival_"+i;
            param[name] = rows[i].UIVAL;
            name = "_staticval_"+i;
            param[name] = rows[i].STATICVAL;
            name = "_deafulval_"+i;
            param[name] = rows[i].DEAFULVAL;
        }
        param.fnum = rows.length;
		$("#viewDialog").dialog({
			title:'对象检索',
			width: 1000,
			height: 500,
			href: basePath+"Main/autoView/view",
			queryParams:param,
			method:'post'
			});
  	}
  	
	function delView(){
		var rows=$("#autoViewtable").datagrid('getSelected');
		if(rows==null || rows==undefined){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=rows.ID;
		       $.ajax({
	            	url:basePath+"Main/autoView/delete",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'id':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#autoViewtable").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}

	function autoView_doSearch(){
		$('#autoViewtable').datagrid('load',{
			objName: $('#objName').val(),
			viewName: $('#viewName').val()
		});
	}
	function layoutformatter(value,row,index){
		var ftext = "";
		if(value!=undefined){
			if(value.indexOf("north")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />上";
			}else{
				ftext = ftext + "<input type=\"checkbox\"  disabled=\"disabled\" >上";	
			}
			if(value.indexOf("center")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />中";
			}else{
				ftext = ftext + "<input type=\"checkbox\"  disabled=\"disabled\" />中";
			}
			if(value.indexOf("south")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />下";
			}else{
				ftext = ftext + "<input type=\"checkbox\"   disabled=\"disabled\" />下";
			}
			if(value.indexOf("west")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />左";
			}else{
				ftext = ftext + "<input type=\"checkbox\"   disabled=\"disabled\" />左";
			}
			if(value.indexOf("east")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />右";
			}else{
				ftext = ftext + "<input type=\"checkbox\"   disabled=\"disabled\" />右";
			}
		}
		return ftext;
	}
	function vtypeformatter(value,row,index){
		var ftext = "";
		if(value!=undefined){
			if(value.indexOf("00M")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />主页";
			}else{
				ftext = ftext + "<input type=\"checkbox\"  disabled=\"disabled\" >主页";	
			}
			if(value.indexOf("00A")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />新增";
			}else{
				ftext = ftext + "<input type=\"checkbox\"  disabled=\"disabled\" />新增";
			}
			if(value.indexOf("00U")>=0){
				ftext = ftext + "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\" />修改";
			}else{
				ftext = ftext + "<input type=\"checkbox\"   disabled=\"disabled\" />修改";
			}
		}
		return ftext;
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="autoView_tb">
		<span>视图名称:</span>
		<input id="viewName" type="text" class="easyui-textbox" >
		<span>对象:</span>
		<input id="objName" type="text" class="easyui-textbox" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="autoView_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		<a href="javascript:void(0);" onclick="addView()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<!-- <a href="javascript:void(0);" onclick="UpdView()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">修改</a> -->
		<a href="javascript:void(0);" onclick="delView()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>
			<table id="autoViewtable" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="ID"  data-options="hidden:true"></th> 
			            <th field="VIEW_NAME" width="100">视图名称</th>
			            <th field="DATA_SOURCE" width="100">对象</th> 
			            <th field="VIEW_TYPE" width="120" formatter="vtypeformatter">视图类型</th>
			            <th field="VIEW_LAYOUT" width="150"  formatter="layoutformatter">主页布局</th>
			            <th field="VIEW_PATH" width="100" >页面地址</th>
			            <th field="CONTROLLER" width="100" >控制类名</th>  
			            <th field="PACK_PATH" width="150" >包路径</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
<div id="viewDialog"></div>

