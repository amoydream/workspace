<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	var zTree_yhdlb;
	var zNodes_yhdlb;
	var selectedNode_yhdlb;
	var setting_type = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_yhdlb
		}
	};
	function zTreeOnClick_yhdlb(event, treeId, treeNode) {
		if(treeNode.id==0){
			return;
		}
		$('#troubleinfoGrid').datagrid({url:'<%=basePath%>Main/troubleinfo/getGridData',queryParams:{p_acode:treeNode.p_acode}});
		selectedNode_yhdlb=zTree_yhdlb.getSelectedNodes()[0];
		$("#troubleinfoGrid").datagrid("clearSelections");
		$("#troubleinfoGrid").datagrid("clearChecked");
	};
	function initTree_yhdlbTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/troubleinfo/getTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_yhdlb = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_yhdlb!=null)
		            	zTree_yhdlb.destroy();
		            zTree_yhdlb =$.fn.zTree.init($("#yhdlbTree"), setting_type, zNodes_yhdlb);
					if(!selectedNode_yhdlb){
						selectedNode_yhdlb=zTree_yhdlb.getNodeByParam("id", '800', null);
						if(selectedNode_yhdlb.children && selectedNode_yhdlb.children.length>0)
							selectedNode_yhdlb=selectedNode_yhdlb.children[0];
					}
		            zTree_yhdlb.selectNode(selectedNode_yhdlb);
		            zTree_yhdlb.expandNode(selectedNode_yhdlb, true, false, false);
		            zTree_yhdlb.setting.callback.onClick(null, zTree_yhdlb.setting.treeId, selectedNode_yhdlb);
		            
		        }  
		    });
		 
	}
	$(function(){
		initTree_yhdlbTree();
		var attrArray={
				//toolbar: '#troubleinfo_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addtroubleinfo,permitParams:'${pert:hasperti(applicationScope.troubleinfoadd, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updtroubleinfo,permitParams:'${pert:hasperti(applicationScope.troubleinfoupd, loginModel.xdlimit)}'}, '-',
                 /*  { text: '详情',iconCls: 'icon-eye',handler:viewtroubleinfo}, '-', */
                  { text: '删除',iconCls: 'icon-delete',handler:deltroubleinfo,permitParams:'${pert:hasperti(applicationScope.troubleinfodel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/troubleinfo/getGridData",
				onDblClickRow:viewtroubleinfo
        };
		$.lauvan.dataGrid("troubleinfoGrid",attrArray);
		
	});
	function troubleinfo_doSearch(){
		$('#troubleinfoGrid').datagrid('load',{
			p_acode:selectedNode_yhdlb.p_acode,
			troublename: $('#troublename').val()
			
		});	
	}
	function addtroubleinfo(){
		var attrArray={
				title:'新增隐患点信息',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/troubleinfo/add/'+selectedNode_yhdlb.p_acode,
		};
		
		$.lauvan.openCustomDialog("troubleinfoDialog",attrArray,troubleinfo_dialogSubmit,'troubleinfo_form');	
	}
	function updtroubleinfo(){
		var node = $("#troubleinfoGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		if(node.ISVAIL!='0'){
			$.lauvan.MsgShow({msg:'只能修改未排查的隐患信息！'});
			return;	
		}
		var attrArray={
				title:'修改隐患点信息',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/troubleinfo/upd/'+node.ID
		};
		$.lauvan.openCustomDialog("troubleinfoDialog",attrArray,troubleinfo_dialogSubmit,'troubleinfo_form');
	}
	function viewtroubleinfo(){
		var node = $("#troubleinfoGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'隐患点信息详情',
				height: 500,
				width:1000,
				href: '<%=basePath%>Main/troubleinfo/view/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("troubleinfoDialog",attrArray,null);
	}
	function troubleinfo_dialogSubmit(){
  		$('#troubleinfo_form').form('submit',{
  			onSubmit:function(param){
  			var hidtrubname=$('#hidtrubname').textbox('getValue');
  			var hidtrubaddr=$('#hidtrubaddr').textbox('getValue');			
  			if(hidtrubname==""||hidtrubaddr==""){
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
	function deltroubleinfo(){
    	/* var node= $("#troubleinfoGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
		var nodes= $("#troubleinfoGrid").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/troubleinfo/del/'+node.ID,
	            	url:'<%=basePath%>Main/troubleinfo/del?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#troubleinfoGrid").datagrid('clearSelections');
	            			$("#troubleinfoGrid").datagrid('clearChecked');
	            			$("#troubleinfoGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function isvail(value,row,index){
		var cc = value;
		if(cc=='0'){
			cc='未排查';
		}else{
			cc='已排查';
		}
		return cc;
	}
	</script>

		
 <div class="easyui-layout" data-options="fit:true">
 	 <div data-options="region:'west',split:true,border:false" style="width:20%">
			<ul id="yhdlbTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>隐患点名称（负责人）:</span>
		<input id="troublename" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="troubleinfo_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">	
			<table id="troubleinfoGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="HIDTRUBNAME" width="200">隐患点名称（负责人）</th> 
			            <th field="HIDTRUBADDR" width="400">隐患点地址</th> 
			             <th field="ISVAIL" formatter="isvail" width="100">状态</th> 
			             	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>
		</div>
		</div>
