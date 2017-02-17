<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	var dutydepartree;
	var settings = {
		data:{
			simpleData:{
			enable: true,
			idKey: "d_id",
			pIdKey: "d_pid"
			}
		},
		callback: { onClick: zTreeOnClick}
	};

	var zNodes = [
	              {d_id:"0", d_pid:"0", name:"职能部门结构"}
	              <c:if test="${! empty busorgList}">,</c:if>
		     		<c:forEach items="${busorgList}" var="busorg" varStatus="vx">
		     		{ d_id:"${busorg.or_id}", d_pid:"${empty busorg.or_pid ? 0 : busorg.or_pid}", name:"${busorg.or_name}"
		     		}<c:if test="${fn:length(busorgList)!=vx.index+1}">,</c:if>
		     		</c:forEach>	

	];

	function zTreeOnClick(event, treeId, treeNode){
		//修改显示部门信息
		$.getJSON("<%=basePath%>Main/dutydepart/getDepartInfo", 
				{departid: treeNode.d_id}, 
				function(json){
					$("#depart_name").text(json.organ.OR_NAME);
					$("#or_worknumber").text(json.organ.OR_WORKNUMBER==null?"":json.organ.OR_WORKNUMBER);
					$("#or_address").text(json.organ.OR_ADDRESS == null? "":json.organ.OR_ADDRESS);
				}

		);
		for(var i=0; i<10; i++){
			var tab = $("#dutytabs").tabs('getTab', i)
			var href = tab.panel('options').href;
			if(href){
				var index = href.indexOf('-');
				href = href.substring(0, index+1);
				href += treeNode.d_id;
			}
			//tab.panel('options').href = href;
			$("#dutytabs").tabs('update', {
				tab:tab,
				options:{
					href: href
				}
			
			});
		}
		$("#dutytabs").tabs('getSelected').panel('refresh');
		
	}

	$(function(){
		//加载zTree
		$.fn.zTree.init($("#departtree"), settings, zNodes);
		dutydepartree = $.fn.zTree.getZTreeObj('departtree');
		var node = dutydepartree.getNodeByParam("d_id", ${busorgList[0].or_id} , null);
		dutydepartree.selectNode(node);
		dutydepartree.expandNode(node);
		

	});



	</script>
			 <div class="easyui-layout"  data-options="fit:true">
			  <div data-options="region:'west', split:true" style="width:200px;">
			 	<ul id="departtree" class="ztree"></ul>
			 </div>
			<div data-options="region:'center',border:false">
			<div class="easyui-layout"  data-options="fit:true">
			 <div data-options="region:'north',border:false" style="height:95px;">
				
					 <table id="tables" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
					 	<tr>
					 		<td class="sp-td1">机构名称</td>
					 		<td id="depart_name">${busorgList[0].or_name}</td>
					 		<td class="sp-td1">办公电话</td>
					 		<td id="or_worknumber">${busorgList[0].or_worknumber}</td>
					 	</tr>
					 	<tr>
					 		<td class="sp-td1">地址</td>
					 		<td id="or_address" colspan="3">${busorgList[0].or_address}</td>
					 	</tr>
					 </table>
				
				</div>
				<div data-options="region:'center',border:false">
				<div id="dutytabs" class="easyui-tabs"  data-options="fit:true, tabPosition:'left',headerWidth:90">
					<div title="应急预案" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/plan-${busorgList[0].or_id}'">
						
					</div>
					<div title="应急物资" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/store-${busorgList[0].or_id}'">
					
					</div>
					<div title="保护对象" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/protectobj-${busorgList[0].or_id}'">
					
					</div>
					<div title="应急专家" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/expertinfo-${busorgList[0].or_id}'">
					
					</div>
					<div title="应急队伍" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/team-${busorgList[0].or_id}'">
					
					</div>
					<div title="应急装备" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/equip-${busorgList[0].or_id}'">
					
					</div>
					<div title="重大危险源" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/danger-${busorgList[0].or_id}'">
					
					</div>
					<div title="隐患点信息" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/troubleobj-${busorgList[0].or_id}'">
					
					</div>
					<div title="应急避难场所" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/shelter-${busorgList[0].or_id}'">
					
					</div>
					<div title="应急经典案例" data-options="href:'<%=basePath%>Main/dutydepart/getDutyInfo/cases-${busorgList[0].or_id}'">
					
					</div>
				</div>
				</div>
			</div>
			</div>
		</div>
</div>
