<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addrelation,permitParams:'${pert:hasperti(applicationScope.relationadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updrelation,permitParams:'${pert:hasperti(applicationScope.relationupd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:delrelation,permitParams:'${pert:hasperti(applicationScope.relationdel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,
				url:"<%=basePath%>Main/codetablerelation/getGridData"
        };
		$.lauvan.dataGrid("relationGrid",attrArray);
		
	});
	function addrelation(){
		var attrArray={
				title:'新增关联',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/codetablerelation/add',
		};
		
		$.lauvan.openCustomDialog("relationDialog",attrArray,relation_dialogSubmit,'relation_form');	
	}
	function updrelation(){
		var node = $("#relationGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改关联',
				height:300,
				width:500,
				href: '<%=basePath%>Main/codetablerelation/upd/'+node.ID
		};
		$.lauvan.openCustomDialog("relationDialog",attrArray,relation_dialogSubmit,'relation_form');
	}
	function relation_dialogSubmit(){
  		$('#relation_form').form('submit',{
  			onSubmit:function(param){
  			var relationtype=$('#relationexptype').combobox('getValue');
  			var relationbhlxcode=$('#relationbhlxcode').textbox('getValue'); 
  			var relationexptablename=$('#relationexptablename').textbox('getValue');
  			if(relationtype==""||relationbhlxcode==""||relationexptablename==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				} 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function delrelation(){
		var nodes= $("#relationGrid").datagrid('getChecked');
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
		       $.ajax({
	            	url:'<%=basePath%>Main/codetablerelation/del?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#relationGrid").datagrid('clearSelections');
	            			$("#relationGrid").datagrid('clearChecked');
	            			$("#relationGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function relation_doSearch(){
		$('#relationGrid').datagrid('load',{
			bhlxcode: $('#bhlxcode').val(),
			exptablename: $('#exptablename').val(),
			exptype:$('#relationtype').combobox('getValue')
			
		});	
	}
	</script>

		
 <div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>类型编码:</span>
		<input id=bhlxcode type="text" class="easyui-textbox" >
		<span>表名:</span>
		<input id="exptablename" type="text" class="easyui-textbox" >
		<span>类型:</span>
		<select id="relationtype" class="easyui-combobox" data-options="icons:iconClear" editable="false" panelHeight="auto" code="ZDFHBGLX" style="width:150px;"></select>		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="relation_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="relationGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="BHLXCODE" width="300">类型代码</th> 	
			            <th field="EXPTABLENAME" width="300">表名</th>
			            <th field="TYPE" code="ZDFHBGLX" width="300">类型</th>
			             	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>
