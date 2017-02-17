<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	var zTree_yhdlb2;
	var zNodes_yhdlb2;
	var selectedNode_yhdlb2;
	var setting_type2 = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_yhdlb2
		}
	};
	function zTreeOnClick_yhdlb2(event, treeId, treeNode) {
		if(treeNode.id==0){
			return;
		}
		$('#troubleinfoGrid2').datagrid({url:'<%=basePath%>Main/troubleinfo/getGridData/${deptid}',queryParams:{p_acode:treeNode.p_acode}});
		selectedNode_yhdlb2=zTree_yhdlb2.getSelectedNodes()[0];
		$("#troubleinfoGrid2").datagrid("clearSelections");
		$("#troubleinfoGrid2").datagrid("clearChecked");
	};
	function initTree_yhdlbTree2(){
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
		            zNodes_yhdlb2 = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_yhdlb2!=null)
		            	zTree_yhdlb2.destroy();
		            zTree_yhdlb2 =$.fn.zTree.init($("#yhdlbTree2"), setting_type2, zNodes_yhdlb2);
					if(!selectedNode_yhdlb2){
						selectedNode_yhdlb2=zTree_yhdlb2.getNodeByParam("id", '800', null);
						if(selectedNode_yhdlb2.children && selectedNode_yhdlb2.children.length>0)
							selectedNode_yhdlb2=selectedNode_yhdlb2.children[0];
					}
		            zTree_yhdlb2.selectNode(selectedNode_yhdlb2);
		            zTree_yhdlb2.expandNode(selectedNode_yhdlb2, true, false, false);
		            zTree_yhdlb2.setting.callback.onClick(null, zTree_yhdlb2.setting.treeId, selectedNode_yhdlb2);
		            
		        }  
		    });
		 
	}
	$(function(){
		initTree_yhdlbTree2();
		var attrArray={
				//toolbar: '#troubleinfo_tb',
				toolbar: [
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/troubleinfo/getGridData/${deptid}",
				onDblClickRow:viewtroubleinfo
        };
		$.lauvan.dataGrid("troubleinfoGrid2",attrArray);
		
	});
	function troubleinfo_doSearch(){
		$('#troubleinfoGrid2').datagrid('load',{
			p_acode:selectedNode_yhdlb2.p_acode,
			troublename: $('#troublename2').val()
			
		});	
	}

	function viewtroubleinfo(){
		var node = $("#troubleinfoGrid2").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'隐患点信息详情',
				height: 500,
				width:1200,
				href: '<%=basePath%>Main/troubleinfo/view/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("troubleinfoDialog",attrArray,null);
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
			<ul id="yhdlbTree2" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>隐患点名称（负责人）:</span>
		<input id="troublename2" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="troubleinfo_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">	
			<table id="troubleinfoGrid2"   cellspacing="0" cellpadding="0" width="100%"> 
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
