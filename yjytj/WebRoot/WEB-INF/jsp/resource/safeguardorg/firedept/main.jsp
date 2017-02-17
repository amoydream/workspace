<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	var zTree;
	var settings = {
		data:{
			simpleData:{
				enable: true,
				idKey: "d_id",
				pIdKey: "d_pid"
			}
		},
		callback: { onClick: zTreeOnClick},
		async:{
			enable: true,
			url : "Main/firedept/getTreeData",
			autoParam:["d_id"]
			//,dataFilter: function(treeId, parentNode, responseData){
				//var tdata = [{'d_id':'0','d_pid':'0','name':'消防单位'}];
			//	var tdata = [];
			//	if(responseData){
			//		var tlist = responseData;
			//		for(var i=0; i < tlist.length; i++){
			//			var data = {};
			//			data.d_id = tlist[i]['DEPTID'];
			//			data.d_pid = tlist[i]['SUPERDEPT_ID'];
			//			data.name = tlist[i]['DEPTNAME'];
			//			data.isParent = tlist[i]['ISLEAF'] == 0? false: true;
			//			tdata.push(data);
			//		}
			//	}
			//	if(tdata.length == 0){
			//		parentNode.isParent = false;
			//	}
			//	return tdata;
			//}


		}
		//,
		//onAsyncSuccess: function(event, treeId, msg){
		//	var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0;
		//	zTree.selectNode(zTree.getNodeByParam("d_id", pid, null));
			//zTree.expandAll();
		//}
	};
	//var zNodes = [
	//      {d_id:"0", d_pid:"0", name:"消防单位"}
	//      <c:if test="${! empty fireList}">,</c:if>
	//	  <c:forEach items="${fireList}" var="dept" varStatus="vx">
	//	  {d_id:"${dept.deptid}", d_pid:"${dept.superdept_id}", name:"${dept.deptname}"}
	//	  <c:if test="${fn:length(fireList) != vx.index+1}">,</c:if>
	//	  </c:forEach>

	//];

	function zTreeOnClick(event, treeId, treeNode){
		$('#firedept_data').datagrid({url: '<%=basePath%>Main/firedept/getGridData/' + treeNode.d_id});
		
	};
	$(function(){
		$.ajax({
			type: 'get',
			url: 'Main/firedept/getTreeData',
			dataType: "json",
			success: function(data){
				$.fn.zTree.init($("#firedepttree"), settings, data);
				zTree = $.fn.zTree.getZTreeObj('firedepttree');
				zTree.expandAll(true);
				zTree.selectNode(zTree.getNodeByParam("d_id", 0 , null));
			},
			error:function(msg){
				alert("加载出错");
			}

		});
		var attrArray={
				idField:'DEPTID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加消防队信息', iconCls: 'icon-add', handler:addfiredept}, '-',
						  { text: '修改', title:'修改消防队信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'firedeptDialog',href:'<%=basePath%>Main/firedept/edit',width:950,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该消防队信息及其下属消防队信息吗？',delParams:{url:'<%=basePath%>Main/firedept/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewfiredept}
						],
				url:"<%=basePath%>Main/firedept/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewfiredept();

				}
			};
		$.lauvan.dataGrid("firedept_data",attrArray);

		
	});

	function firedeptSrh(){
		$("#firedept_data").datagrid('load', {
			firedeptname: $("#firedeptname").val(),
			levelcode: $("#firelevelcode").combobox('getValue')
		});
	}

	function viewfiredept(){
		var row = $("#firedept_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '消防队基本详情',
			height: 550,
			width: 940,
			href:'<%=basePath%>Main/firedept/view/' +row.DEPTID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("firedeptDialog",para,null,null);		
	}

	function addfiredept(){ //添加司法行政机关
		var options = $(this).linkbutton("options");
		var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0; //获取上级机关id
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/firedept/add/'+ pid,
			width:950,
			height:600
		};
		$.lauvan.openCustomDialog("firedeptDialog", para, null, "form1");
	}
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'west', split:true" style="width:200px;">
	 	<ul id="firedepttree" class="ztree"></ul>
	 </div>
		<div data-options="region:'center',border:false">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>单位名称：</span>
			<input id="firedeptname" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<span>级别：</span>
			<select id="firelevelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="firedeptSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<table id="firedept_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">单位名称</th>
			            <th field="DISTRICTCODE" code="EVQY" width="100">行政区域</th>
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="DUTYTEL" width="100">值班电话</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="FIRERNUM" width="100">消防员人数</th>
			            <!-- <th field="RESPPER" width="100">负责人</th>
			             <th field="RESPOTEL" width="100">负责人办公电话</th> -->
			              <th field="CONTACTPER" width="100">联系人</th>
			             <th field="CONTACTOTEL" width="100">联系人办公电话</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
