<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
#preschOrgTree2 li span{color:black;}
#cmdtable td{
		height:21px;
		padding:4px 2px;
}
</style>
<script>
var zTree_preschOrg2;
var setting_preschOrg2 = {
	data: {
		simpleData: {
			enable: true,
			idKey: "id",
			pIdKey: "pid"
		}
	},
	callback: {
		onClick: zTreeOnClick_preschOrg2
	}
};

var zNodes_preschOrg2 =[
     		{ id:"0", pId:"0", name:"应急机构",open:true}
     		<c:forEach items="${orglist}" var="organ" >
     		,{ id:"${organ.id}", pid:"${empty organ.pid?0:organ.pid}", name:"${organ.itemname}"}
     		</c:forEach>
     	];

function zTreeOnClick_preschOrg2(event, treeId, treeNode) {
	$("#_preschOrgPid2").val(treeNode.id);
	$("#_preschOrgPname2").val(treeNode.name);
	$('#preschOrgGrid2').datagrid({url:'<%=basePath%>Main/planMg/getOrganData/'+treeNode.id});
};
	$(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				pagination:false,
				fit:true,
				url:'<%=basePath%>Main/planMg/getOrganData/${apid}'
	    };
		$.lauvan.dataGrid("preschOrgGrid2",attrArray);
		$.fn.zTree.init($("#preschOrgTree2"), setting_preschOrg2, zNodes_preschOrg2);
		zTree_preschOrg2 = $.fn.zTree.getZTreeObj('preschOrgTree2');
		var node = zTree_preschOrg2.getNodeByParam("id", '${apid}', null);
		zTree_preschOrg2.selectNode(node);
		zTree_preschOrg2.expandNode(node);
	});

	function getPoint(){
		$.lauvan.openGisDialog($("#lng").val(), $("#lat").val(), function(lng, lat){
			$("#lng").textbox('setValue', lng);
			$("#lat").textbox('setValue', lat);
		
			},{height:500});
  	}


	//保存现场指挥经纬度
  	function saveCmdPos(){
  	  	var basePath = '<%=basePath%>';
		$.post(basePath+"Main/geographic/dispatch/saveCmdPos", 
				$("#cmdposForm").serialize(), 
				function(result){
					if(result.success){
						if(cmdposLayer){
							cmdposLayer.clear();
						}else{
							cmdposLayer = map.addGraphicLayer("cmdposLayer");
						}
						$.lauvan.MsgShow({msg:"现场指挥部设置成功！"});
						var point = map.getPoint(result.lng, result.lat);
						var teampic = basePath+"plugins/gis/css/icon/flag.png";
						map.drawPicture(teampic, 25,25,point, null, null, cmdposLayer); //标注
						$("#cmdPosDialog").dialog('close'); //关闭窗口
					}else{
						$.lauvan.MsgShow({msg:result.msg});
					}

		});

  	}
</script>


<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north', border:false" style="height:270px;">
		<div class="easyui-layout"  data-options="fit:true">
			<div data-options="region:'west',border:false" style="width: 150px;">
				<ul id="preschOrgTree2" class="ztree"></ul>
			</div>
			<div data-options="region:'center',border:false">
				<input type="hidden" id="_preschOrgPid2" />
				<input type="hidden" id="_preschOrgPname2" />
				<table id="preschOrgGrid2" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					            <th field="ADD_NAME" width="100">名称</th> 
					            <th field="POSITION_NAME" width="100"  >岗位</th>
					            <th field="WORKNUM" width="100"  >办公电话</th>
					            <th field="TELPHONE" width="100" >手机</th>
					            <th field="HOMENUM" width="100" >住址电话</th>
					        </tr> 
					    </thead> 
				</table>
			</div>
		</div>	
	</div>

		
	
	<div data-options="region:'center'">
		<div style="width:648px;height:23px;line-height:23px;background:#AFE7FF;padding-left:15px;">
			现场指挥定位信息
		</div>
		<form id="cmdposForm">
			<table id="cmdtable" class="sp-table" width="100%" cellpadding="0" cellspacing="0" >
				<tr>
					<td class="sp-td1">经度：</td>
					<td>
						<input type="hidden" name="t_Bus_EventCmdpos.id" value="${ec.id}"/>
						<input type="hidden" name="t_Bus_EventCmdpos.eventid" value="${eventid}"/>
						<input type="text" id="lng" name="t_Bus_EventCmdpos.lng"  value="${ec.lng}" class="easyui-textbox"  data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" style="width:150px;"/>
					</td>
					<td class="sp-td1">维度：</td>
					<td>
						<input type="text" id="lat" name="t_Bus_EventCmdpos.lat"  value="${ec.lat}" class="easyui-textbox"  data-options="editable:false,icons:[{iconCls:'icon-world', handler:getPoint}]" style="width:150px;"/>
					</td>
				</tr>
				<tr>
					<td class="sp-td1">地址：</td>
					<td colspan="3">
						<input type="text" name="t_Bus_EventCmdpos.address" class="easyui-textbox"  value="${ec.address}" data-options="icons:iconClear" style="width:480px;"/>
					</td>
				</tr>
				<tr>
					<td class="sp-td1">备注：</td>
					<td colspan="3">
						<input type="text" name="t_Bus_EventCmdpos.remark" class="easyui-textbox"  value="${ec.remark}" data-options="icons:iconClear,multiline:true"  style="width:480px; height:35px;"/>
					</td>
				</tr>
				
			</table>
		</form>
			<div style="text-align:center;padding-top:10px;">
				<a href="javascript:saveCmdPos();" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
			</div>
	</div>

</div>