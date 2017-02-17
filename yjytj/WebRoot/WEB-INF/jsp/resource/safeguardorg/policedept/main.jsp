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
			url: "Main/policedept/getTreeData",
			autoParam:["d_id"],
			type:"post"

		}
	};
	//var zNodes = [
	 //     {d_id:"0", d_pid:"0", name:"公安机关"}
	 //     <c:if test="${! empty deptlist}">,</c:if>
	//	  <c:forEach items="${deptlist}" var="dept" varStatus="vx">
	//	  {d_id:"${dept.deptid}", d_pid:"${empty dept.superdept_id ? 0: dept.superdept_id}", name:"${dept.deptname}"}
	//	  <c:if test="${fn:length(deptlist) != vx.index+1}">,</c:if>
	//	  </c:forEach>

	//];

	function zTreeOnClick(event, treeId, treeNode){
		$('#policedept_data').datagrid({url: '<%=basePath%>Main/policedept/getGridData/' + treeNode.d_id});
		
	};
	$(function(){
		$.ajax({
			type:'get',
			url:'Main/policedept/getTreeData',
			dataType: "json",
			success: function(data){
				$.fn.zTree.init($("#depttree"), settings, data);
				zTree = $.fn.zTree.getZTreeObj('depttree');
				zTree.expandAll(true);
				zTree.selectNode(zTree.getNodeByParam("d_id", 0, null));
			},
			error:function(msg){
				alert("加载出错");
			}
		});
		
		var attrArray={
				idField:'DEPTID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加公安机关信息', iconCls: 'icon-add', handler:addPolicedept}, '-',
						  { text: '修改', title:'修改公安机关信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'policedeptDialog',href:'<%=basePath%>Main/policedept/edit',width:940,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该机关信息及其下属机关信息吗？',delParams:{url:'<%=basePath%>Main/policedept/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewPolice, id:'viewBtn'}
						],
				url:"<%=basePath%>Main/policedept/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewPolice();

				}
			};
		$.lauvan.dataGrid("policedept_data",attrArray);

		
	});

	function policedeptSrh(){
		$("#policedept_data").datagrid('load', {
			deptname: $("#policdeptname").val(),

		});
	}

	function viewPolice(){
		var row = $("#policedept_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '公安机关基本详情',
			height: 550,
			width: 940,
			href:'<%=basePath%>Main/policedept/view/' +row.DEPTID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("policedeptDialog",para,null,null);		
	}

	function addPolicedept(){ //添加公安机关
		var options = $(this).linkbutton("options");
		var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0; //获取上级机关id
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/policedept/add/'+ pid,
			width:940,
			height:600
		};
		$.lauvan.openCustomDialog("policedeptDialog", para, null, "form1");
	}
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'west', split:true" style="width:200px;">
	 	<ul id="depttree" class="ztree"></ul>
	 </div>
		<div data-options="region:'center',border:false">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>单位名称：</span>
			<input id="policdeptname" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="policedeptSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<table id="policedept_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">单位名称</th> 
			            <!-- <th field="POSTCODE" width="100">邮编</th> -->
			            <th field="DUTYTEL" width="100">值班电话</th>
			            <th field="FAX" width="100">传真</th>
			            <!-- <th field="POLICENUM" width="100">警员人数</th> -->
			            <th field="RESPPER" width="100">负责人</th>
			            <th field="ADDRESS" width="150">地址</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
