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
			url : "Main/juddept/getTreeData",
			autoParam:["d_id"]
			
			}

		//,
		//onAsyncSuccess: function(event, treeId, msg){
		//	zTree.selectNode(zTree.getNodeByParam("d_id", 0, null));
		//}
	};
	

	function zTreeOnClick(event, treeId, treeNode){
		$('#juddept_data').datagrid({url: '<%=basePath%>Main/juddept/getGridData/' + treeNode.d_id});
		
	};
	$(function(){
		$.ajax({
			type:'get',
			url: 'Main/juddept/getTreeData',
			dataType:"json",
			success: function(data){
				$.fn.zTree.init($("#juddepttree"), settings, data);
				zTree = $.fn.zTree.getZTreeObj('juddepttree');
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
						   
						  { text:'添加', title:'添加司法行政机关信息', iconCls: 'icon-add', handler:addjuddept}, '-',
						  { text: '修改', title:'修改司法行政机关信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'juddeptDialog',href:'<%=basePath%>Main/juddept/edit',width:950,
									height:600,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',warnMsg:'您确定删除该机关信息及其下属机关信息吗？',delParams:{url:'<%=basePath%>Main/juddept/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewJuddept}
						],
				url:"<%=basePath%>Main/juddept/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewJuddept();

				}
			};
		$.lauvan.dataGrid("juddept_data",attrArray);

		
	});

	function juddeptSrh(){
		$("#juddept_data").datagrid('load', {
			juddeptname: $("#juddeptname").val(),
			levelcode: $("#judlevelcode").combobox('getValue')
		});
	}

	function viewJuddept(){
		var row = $("#juddept_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '司法行政机关基本详情',
			height: 550,
			width: 940,
			href:'<%=basePath%>Main/juddept/view/' +row.DEPTID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("juddeptDialog",para,null,null);		
	}

	function addjuddept(){ //添加司法行政机关
		var options = $(this).linkbutton("options");
		var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0; //获取上级机关id
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/juddept/add/'+ pid,
			width:950,
			height:600
		};
		$.lauvan.openCustomDialog("juddeptDialog", para, null, "form1");
	}
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'west', split:true" style="width:200px;">
	 	<ul id="juddepttree" class="ztree"></ul>
	 </div>
		<div data-options="region:'center',border:false">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>单位名称：</span>
			<input id="juddeptname" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<span>级别：</span>
			<select id="judlevelcode" class="easyui-combobox" code="ZDFHJBDM" data-options="icons:iconClear,panelHeight:125" style="width:150px;"></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="juddeptSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<table id="juddept_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="DEPTID" data-options="hidden:true">ID</th> 
			            <th field="DEPTNAME" width="100">单位名称</th>
			            <th field="DISTRICTCODE" code="EVQY" width="100">行政区域</th><%--
			            <th field="ADDRESS" width="150">地址</th>
			            --%>
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>
			            <th field="DUTYTEL" width="100">值班电话</th>
			            <th field="FAX" width="100">传真</th>
			            <th field="POLICENUM" width="100">警员人数</th>
			            <th field="RESPPER" width="100">负责人</th>
			             <th field="RESPOTEL" width="100">负责人办公电话</th>
			              <th field="CONTACTPER" width="100">联系人</th>
			             <th field="CONTACTOTEL" width="100">联系人办公电话</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
