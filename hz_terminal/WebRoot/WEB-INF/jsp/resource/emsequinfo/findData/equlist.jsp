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
		data:{
			simpleData:{
				enable:true,
				idKey: "d_id",
				pIdKey: "d_pid"
			}
		},
		callback:{
			onClick: zTreeOnClick
		}

	};

	var zNodes = [
	              <c:forEach items ="${list}" var="l" varStatus="vx">
	              	{d_id:"${l.id}", d_pid:"${l.sup_id}", name:"${l.p_name}"}
	              	<c:if test="${fn:length(list) != vx.index+1}">,</c:if>
	              </c:forEach>
		 ];

	function zTreeOnClick(event, treeId, treeNode) {
		$('#equGrid').datagrid({url:'<%=basePath%>Main/equipname/getGridData/',queryParams:{pid:treeNode.d_id}});
	};

	$(document).ready(function(){
		$.fn.zTree.init($("#equtree"), setting, zNodes);
		zTree = $.fn.zTree.getZTreeObj('equtree');
		zTree.selectNode(zTree.getNodeByParam("id", 0, null));
		var attrArray={
				fitColumns : true,
				idField:'EQU_ID',
				rownumbers:false, 
				frozenColumns:[[]],
				url:"<%=basePath%>Main/equipname/getGridData"
	    };
		$.lauvan.dataGrid("equGrid",attrArray);
		
	});
	
</script>


<div class="pageContent" style="background: #eef4f5; padding: 0;">
	<div >
		<div>
			<div layoutH="50" style=" float:left; display:block; overflow:auto;height:405px; width:240px;border:solid 1px #B8D0D6; line-height:21px; background:#fff; margin: 5px;">
			    	<ul id="equtree" class="ztree"></ul> 
			</div>
			<div id="equBox" style="margin-left:246px; height:410px;margin: 5px;">
			<table id="equGrid"  cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			        	 <th field="EQN_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" width="100">装备名称</th>
			            <th field="MEASUREUNIT" CODE="MAUNIT" width="100">计量单位</th>
			            <th field="REMARK" width="100">备注</th>
			        </tr> 
			    </thead> 
			</table>
			</div>
		</div>
		<div style="clear: both;" /></div>
</div>


