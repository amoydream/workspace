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
	     		<c:if test="${! empty organs}">,</c:if>
	     		<c:forEach items="${organs}" var="organ" varStatus="vx">
	     		{ d_id:"${organ.d_id}", d_pid:"${empty organ.d_pid ? 0 : organ.d_pid}", name:"${organ.d_name}"
	     		}<c:if test="${fn:length(organs)!=vx.index+1}">,</c:if>
	     		</c:forEach>	
	     	];
	
	function zTreeOnClick(event, treeId, treeNode) {
		$('#usersGrid').datagrid({url:'<%=basePath%>Main/onduty/getuserbypid/'+treeNode.d_id});
	};
	var fv;
	$(document).ready(function(){
		$.fn.zTree.init($("#Orgtree"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj('Orgtree');
		zTree.selectNode(zTree.getNodeByParam("id", '${apId}', null));
		var attrArray={
				toolbar: '#user_tb',
				fitColumns : true,
				idField:'ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/onduty/getuserbypid/${pid}"
	    };
		$.lauvan.dataGrid("usersGrid",attrArray);
		
	});

</script>


<div class="pageContent" style="background: #eef4f5; padding: 0;">
	<div >
		<div>
			<div layoutH="50" style=" float:left; display:block; overflow:auto;height:405px; width:240px;border:solid 1px #B8D0D6; line-height:21px; background:#fff; margin: 5px;">
			    	<ul id="Orgtree" class="ztree"></ul> 
			</div>
			<div id="userBox" style="margin-left:246px; height:410px;margin: 5px;">
			<table id="usersGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="USER_NAME" width="100px">人员名称</th> 
			            <th field="D_NAME" width="100px">部门</th>	          
			        </tr> 
			    </thead> 
			</table>
			</div>
		</div>
		<div style="clear: both;" /></div>
</div>


