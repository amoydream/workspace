<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript">
	var zTree;
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "d_id",
				pIdKey: "d_pid"
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
	};
	
	var zNodes =[
	     		{ d_id:"0", d_pId:"0", name:"组织机构"}    
	     		<c:if test="${! empty busorgList}">,</c:if>
	     		<c:forEach items="${busorgList}" var="busorg" varStatus="vx">
	     		{ d_id:"${busorg.or_id}", d_pid:"${empty busorg.or_pid ? 0 : busorg.or_pid}", name:"${busorg.or_name}"
	     		}<c:if test="${fn:length(busorgList)!=vx.index+1}">,</c:if>
	     		</c:forEach>	
	     	];
	
	function zTreeOnClick(event, treeId, treeNode) {
		$('#orgGrid').datagrid({url:'<%=basePath%>Main/emsperson/getBusOrgGridData/'+treeNode.d_id});
	};
	$(document).ready(function(){
		$.fn.zTree.init($("#Orgtree"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj('Orgtree');
		zTree.selectNode(zTree.getNodeByParam("id", '${apId}', null));
		var attrArray={
				fitColumns : true,
				idField:'ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/emsperson/getBusOrgGridData"
	    };
		$.lauvan.dataGrid("orgGrid",attrArray);
		
	});

</script>


<div class="pageContent" style="background: #eef4f5; padding: 0;">
	<div >
		<div>
			<div layoutH="50" style=" float:left; display:block; overflow:auto;height:405px; width:240px;border:solid 1px #B8D0D6; line-height:21px; background:#fff; margin: 5px;">
			    	<ul id="Orgtree" class="ztree"></ul> 
			</div>
			<div id="orgBox" style="margin-left:246px; height:410px;margin: 5px;">
			<table id="orgGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="OR_NAME" width="100px">机构名称</th> 
			            <th field="OR_FOX" width="100px">办公电话</th>
			            <th field="OR_WORKNUMBER">手机</th> 		          
			        </tr> 
			    </thead> 
			</table>
			</div>
		</div>
		<div style="clear: both;" /></div>
</div>


