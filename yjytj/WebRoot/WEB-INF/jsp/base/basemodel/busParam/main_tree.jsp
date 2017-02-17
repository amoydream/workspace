<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	var _ztree_PARAM = {};
	_ztree_PARAM['name']='${ztreename}';
	_ztree_PARAM['setting']= {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: function(event, treeId, treeNode) {
				//清空参数
				$('#_pname_'+'${ztreename}').textbox("setValue","");
				$('#'+'${ztreename}'+"_grid").datagrid("options").queryParams={};
				$('#'+'${ztreename}'+"_grid").datagrid({url:'<%=basePath%>Main/busParam/getGridData?searchid=${apId}&pid='+treeNode.id});
				$("#_selNodeID_"+'${ztreename}').val(treeNode.id);
			}
		},
		async: {
			enable: true,
			url: "Main/busParam/getTreeData",
			autoParam:["id"],
			otherParam:{"rootid":"${apId}"},
			dataFilter: function(treeId, parentNode, responseData){
				var tdata =[]
			   	if (responseData) {
			   		var tlist = responseData;
			   	    for(var i =0; i < tlist.length; i++) {
			   	    	var data={};
			   	        data.id = tlist[i]['ID'];
			   	        data.pid = tlist[i]['SUP_ID'];
			   	        data.name = tlist[i]['P_NAME'];
			   	        data.isParent=tlist[i]['ISLEAF']==0?false:true;
			   	        tdata.push(data);
			   	     }
			   	 }
			   	 return tdata;
			}
		}
	};
	
	_ztree_PARAM['data'] =[
	             <c:if test="${empty root}">      	
	     		{ id:"0", pid:"0", name:"参数管理"}
	     		</c:if>
	     		<c:if test="${!empty root}">      	
		     		{ id:"${root.id}", pid:"${root.sup_id}", name:"${root.p_name}",open:true}
		     	</c:if>
		     	<c:if test="${!empty rlist}"> 
	     		<c:forEach items="${rlist}" var="plist" >
	     		,{ id:"${plist.id}", pid:"${plist.sup_id}", name:"${plist.p_name}"}
	     		</c:forEach>
	     		</c:if>
	     	];
	
	
	$(document).ready(function(){
		var attrArray={
				toolbar: [
		                   { text: '添加', iconCls: 'icon-add',
		                	   handler: function(){
									var selnode = $("#_selNodeID_"+'${ztreename}').val();
									$('#'+'${ztreename}'+"_grid").datagrid("options").queryParams
									var dialogDef={
											title:'新增参数',
											href: '<%=basePath%>Main/busParam/add/'+selnode+"-${ztreename}-${ztreename}"
									};
									$.lauvan.openCustomDialog('busParamDialog',dialogDef,null,'busParam_form');
		                	   }}, '-', 
		                   { text: '修改',iconCls: 'icon-pageedit', 
				                   handler:function(){
		                		   		var row=$('#'+'${ztreename}'+"_grid").datagrid("getSelected");
				           				if(!row){
				           					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
				           					return;
				           				}
		                		   var dialogDef={
											title:'参数编辑',
											href: '<%=basePath%>Main/busParam/edit/'+row.ID+"-${ztreename}"
									};
									$.lauvan.openCustomDialog('busParamDialog',dialogDef,null,'busParam_form');
		                	   	}}, '-',
		                   { text: '删除',iconCls: 'icon-delete',warnMsg:"您确定删除该节点以及节点下的所有子节点？"
						         ,delParams:{url:'<%=basePath%>Main/busParam/delete/'+_ztree_PARAM['name']}}
		                  ],
				fitColumns : true,
				idField:'ID',
				fit:true,
				url:'<%=basePath%>Main/busParam/getGridData?searchid=${apId}&pid=${apId}'
	    };
		$.lauvan.dataGrid('${ztreename}'+"_grid",attrArray);
		$.fn.zTree.init($("#"+'${ztreename}'), _ztree_PARAM['setting'], _ztree_PARAM['data']);
		_ztree_PARAM['tree'] = $.fn.zTree.getZTreeObj('${ztreename}');
		_ztree_PARAM['tree'].selectNode(_ztree_PARAM['tree'].getNodeByParam("id", "${apId}", null));

		$('#_'+'${ztreename}'+'_search').bind('click', function(){    
			$('#'+'${ztreename}'+"_grid").datagrid('load',{
				pname: $('#_pname_'+'${ztreename}').val(),
				flag:'search'
			});   
	    });
	});
	
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="${ztreename}" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
	<div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<input type="hidden" id="_selNodeID_${ztreename}" value="${apId}"/>
			<span>参数名称：</span>
			<input id="_pname_${ztreename}" type="text" class="easyui-textbox" >
			<a id="_${ztreename}_search" href="javascript:void(0);" class="easyui-linkbutton"   data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false" >
			<table id="${ztreename}_grid" cellspacing="0" cellpadding="0"> 
						    <thead> 
						        <tr> 
						           <th field="ID" width="100" data-options="hidden:true">ID</th> 
						            <th field="P_NAME" width="250">参数名称</th> 
						            <th field="P_ACODE" width="200" >参数编码</th> 
						            <th field="SUP_ID" width="100" data-options="hidden:true">pID</th> 
						            <th field="REMARK"  width="350" >备注</th> 
						        </tr> 
						    </thead> 
			</table>
		</div>
	</div>
</div>
</div>	
	
	 
	
