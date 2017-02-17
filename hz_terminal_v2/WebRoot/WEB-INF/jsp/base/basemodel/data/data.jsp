<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  var zTree2;
	var zNodes2;
	var setting2 = {
	check: {
		enable: true
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onCheck: zTreeOnCheck
		}
	};
	function zTreeOnCheck(event, treeId, treeNode) {
	    var nodes = zTree2.getCheckedNodes(true);
	    var strId = "";
	    for(var i=0; i<nodes.length; i++){
		    if(nodes[i].check_Child_State!=1){
			    var pnode = nodes[i].getParentNode();
			    if(pnode==null || pnode.check_Child_State!=2){
			    	strId = strId + ","+nodes[i].id;
			    }
		    	
		    }
	    }
	    if(strId!=""){
		    strId = strId.substring(1);
	    }
	    $("#selids").val(strId);
	}
  var zNodes2 =[
	     		<c:forEach items="${dlist}" var="organ" varStatus="vx">
	     		{ id:"${organ.d_id}", pid:"${empty organ.d_pid ? 0 : organ.d_pid}", name:"${organ.d_name}"
		     		,checked:"${empty organ.checked ? false : organ.checked}"
	     		}<c:if test="${fn:length(deptTree)!=vx.index+1}">,</c:if>
	     		</c:forEach>	
	     	];
	$(function(){
		//生成树
		$.fn.zTree.init($("#otherdeptTree"), setting2, zNodes2);
		zTree2 = $.fn.zTree.getZTreeObj('otherdeptTree');
		zTree2.expandAll(true);
	});
  </script>
<div class="easyui-layout"  data-options="fit:true">
	 <form id="dataserviceform" method="post" action="<%=basePath %>Main/dataService/dataRoleSave" style="width:100%;">
	 <input type="hidden" id="selids" name="selid" value="${selids}"/>
	 <input type="hidden"  name="deptid" value="${d.d_id}"/>
	 <input type="hidden"  name="serviceid" value="${s.id}"/>
	 <div data-options="region:'north',border:false" style="padding: 5px;">
	   <span>部门：${d.d_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   <span>业务：${s.servicename}</span></br>
	  </div>
		<div data-options="region:'center',split:true,border:false">
			<ul id="otherdeptTree" class="ztree"></ul>
		</div>
		
    </form>
</div>