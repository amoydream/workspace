<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_lawrul;
	var zNodes_lawrul;
	var selectedNode_lawrul;
	//关闭dialog后onClose事件处理标记
	var closeSign = "";
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
	};

	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#lawrulGrid').datagrid({url:'<%=basePath%>Main/lawrul/getGridData',queryParams:{lr_typeid:treeNode.id}});
		selectedNode_lawrul=zTree_lawrul.getSelectedNodes()[0];
		$("#lawrulGrid").datagrid("clearSelections");
		$("#lawrulGrid").datagrid("clearChecked");
	}; 

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/lawrul/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){   
		            zNodes_lawrul = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_lawrul!=null)
		            	zTree_lawrul.destroy();
		            zTree_lawrul =$.fn.zTree.init($("#lawrultypeTree"), setting, zNodes_lawrul);
					if(!selectedNode_lawrul){
						selectedNode_lawrul=zTree_lawrul.getNodeByParam("id", '0', null);
						if(selectedNode_lawrul.children && selectedNode_lawrul.children.length>0)
							selectedNode_lawrul=selectedNode_lawrul.children[0];
					}
		            zTree_lawrul.selectNode(selectedNode_lawrul);
		            zTree_lawrul.expandNode(selectedNode_lawrul, true, false, false);
		            zTree_lawrul.setting.callback.onClick(null, zTree_lawrul.setting.treeId, selectedNode_lawrul);
		        }  
		    });
	}

	function lawrulrefreshGrid(){
		zTree_lawrul.setting.callback.onClick(null, zTree_lawrul.setting.treeId, selectedNode_lawrul);
	}
	
	$(function(){
		initTree();
		
		var attrArray={
				idField:'LR_ID',
				fitColumns : true, 
				toolbar: [ 
                          { text: '添加',title:'添加法律法规', iconCls: 'icon-add',  handler: add,permitParams:'${pert:hasperti(applicationScope.lawrulAdd, loginModel.xdlimit)}'}, '-', 
						  { text: '修改',title:'修改法律法规',iconCls: 'icon-pageedit', handler: edit,permitParams:'${pert:hasperti(applicationScope.lawrulEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',handler: del,permitParams:'${pert:hasperti(applicationScope.lawrulDelete, loginModel.xdlimit)}'}
						],
						onDblClickRow : function(rowIndex, rowData) {
							//打开详情页面
							$("#viewlawrulDialog").dialog({
								title : '法律法规详情',
								width : 800,
								height : 620,
								cache : false,
								modal : true,
								href : '<%=basePath%>Main/lawrul/view/' + rowData.LR_ID,
								buttons : []
							});
						}		
			};
		
		$.lauvan.dataGrid("lawrulGrid",attrArray);
	});

	function add(){
		var options=$(this).linkbutton("options");
		if(zTree_lawrul.getSelectedNodes()[0].id==0){
			$.lauvan.MsgShow({msg:'请选择具体的法律法规分类节点!'});
			return;
		}
		var attrArray={
				title:options.title,
				width: 800,
				height: 600,
				href: '<%=basePath%>Main/lawrul/add/'+zTree_lawrul.getSelectedNodes()[0].id,
				onClose: function () { 
					if(closeSign=="addSubmit"){
						closeSign = "";
						return;
					}
                $('#lawrulAdd').form('submit',{ 
                	      url:'<%=basePath%>Main/lawrul/addcloseDelete',
                	      onSubmit: function(){   		                	
                	          return true;
                	      },   
                	      success:function(data){
                	    	var obj=$.parseJSON(data);		                	    
                	    	if(obj.code=='success'){
      	            			$.lauvan.MsgShow({msg:'未保存的上传文件已经删除！'});
      	            			lawrulrefreshGrid();
      	            		}
                	    	if(obj.code=='error'){
                	    		$.messager.alert('错误',obj.msg);
                	    	}
                	      }   
                	 }); 					  
		           }
		};
		$.lauvan.openCustomDialog("lawrulDialog",attrArray,lawrulAdd_dialogSubmit,"lawrulAdd");
	}
	
	function lawrulAdd_dialogSubmit(){
		closeSign = "addSubmit";
		$.lauvan.dialogSubmit("lawrulAdd","lawrulDialog");
		}
	
	function edit(){
		var row=$("#lawrulGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录!'});
			return;
		}	
		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				width: 800,
				height: 620,
				href: '<%=basePath%>Main/lawrul/edit/'+row.LR_ID,
				onClose: function () { 
					if(closeSign=="editSubmit"){
						closeSign = "";
						return;
					}
	                $('#lawrulEdit').form('submit',{ 
	                	      url:'<%=basePath%>Main/lawrul/editcloseDelete',
	                	      onSubmit: function(){   		                	
	                	          return true;
	                	      },   
	                	      success:function(data){
	                	    	var obj=$.parseJSON(data);		                	    
	                	    	if(obj.code=='success'){
	      	            			$.lauvan.MsgShow({msg:'未保存的上传文件已经删除！'});
	      	            			lawrulrefreshGrid();
	      	            		}
	                	    	if(obj.code=='error'){
	                	    		$.messager.alert('错误',obj.msg);
	                	    	}
	                	      }   
	                	 }); 
					   
		            }
		};
		$.lauvan.openCustomDialog("lawrulDialog",attrArray,lawrulEdit_dialogSubmit,"lawrulEdit");
	}
	
	function lawrulEdit_dialogSubmit(){
		closeSign = "editSubmit";
		$.lauvan.dialogSubmit("lawrulEdit","lawrulDialog");		
	}
	
	
	function del(){
		var rows=$("#lawrulGrid").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(y){
		    if (y){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i] = rows[i]["LR_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/lawrul/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            			lawrulrefreshGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	function lr_doSearch(){
		$('#lawrulGrid').datagrid('load',{
			lr_title: $('#lrtitleid').val(),
			lr_typeid: $('#lrtypeid').combobox('getValue')
		});
	}

	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,border:false" style="width:230px">
			<ul id="lawrultypeTree" class="ztree"></ul>
		</div>
		<div data-options="region:'north'" style="padding: 5px;background:#f7f7f7;">
			<span>标题：</span>
			<input id="lrtitleid" type="text" class="easyui-textbox" >
			<span>类别：</span>
			<input id="lrtypeid" class="easyui-combotree" data-options="url:'<%=basePath%>Main/lawrul/getComboTree',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="lr_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="lawrulGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="LR_ID" data-options="hidden:true">ID</th> 
			            <th field="LR_TITLE"  width="180">标题</th>			       			    			          
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
    <div id="viewlawrulDialog"></div>
