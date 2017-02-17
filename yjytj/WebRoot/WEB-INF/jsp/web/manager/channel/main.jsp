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
		url : "Main/channel/getTreeData",
		autoParam:["d_id"],
		type:"post"
	//	dataFilter: function(treeId, parentNode, responseData){
	//		var tdata = [];
	//		if(responseData){
	//			var tlist = responseData;
	//			for(var i=0; i < tlist.length; i++){
	//				var data = {};
	//				data.d_id = tlist[i]['CHANNELID'];
	//				data.d_pid = tlist[i]['PARENTID'];
	//				data.name = tlist[i]['CHANNELNAME'];
	//				tdata.push(data);
	//			}
	//		}
	//		return tdata;
	//	}
		}
	};

	var zNodes = [
	              {d_id:"0", d_pid:"0", name:"网站栏目"}
	              <c:if test="${! empty channelList}">,</c:if>
	              <c:forEach items="${channelList}" var="channel" varStatus="vx">
	              	{d_id:"${channel.channelid}", d_pid:"${channel.parentid}", name:"${channel.channelname}"}
	              	<c:if test="${fn:length(channelList) != vx.index+1}">,</c:if>
	              </c:forEach>

	];

	function zTreeOnClick(event, treeId, treeNode){
		$("#channel_data").datagrid({url: '<%=basePath%>Main/channel/getGridData/' + treeNode.d_id});
		$("#channel_data").datagrid("clearSelections");
		$("#channel_data").datagrid("clearChecked");
	}
	$(function(){
		//加载zTree
		$.ajax({
			type:'get',
			url:'<%=basePath%>Main/channel/getTreeData',
			dataType:"json",
			success: function(data){
				$.fn.zTree.init($("#channeltree"), settings, data);
				zTree = $.fn.zTree.getZTreeObj('channeltree');
				var node = zTree.getNodeByParam("d_id", 0, null);
				zTree.expandNode(node);
				zTree.selectNode(node);
						
			},
			error: function(msg){
				$.messager.alert('错误',"网站栏目树加载失败！");
			}
		});
		var attrArray={
				idField:'CHANNELID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加栏目信息', iconCls: 'icon-add', handler:addchannel}, '-',
						  { text: '修改', title:'修改栏目信息',iconCls: 'icon-pageedit',handler:editchannel}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/channel/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewchannel}
						],
				url:"<%=basePath%>Main/channel/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewchannel();

				}
			};
		$.lauvan.dataGrid("channel_data",attrArray);

	});

	function viewchannel(){
		var row = $("#channel_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '栏目详情',
			height: 450,
			width: 660,
			href:'<%=basePath%>Main/channel/view/' + row.CHANNELID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("channelDialog",para,null,null);	
	}
	var channeleditor;
	function addchannel(){
		var options = $(this).linkbutton("options");
		var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0;
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/channel/add/' + pid,
			width:730,
			height:500,
			onClose:function(){
			//if(channeleditor!=null && channeleditor!=undefined){
			//	channeleditor.blur();
			//}
			KindEditor.remove('textarea[name="c.content"]');
			$(this).dialog('destroy');
			$("#channelDialog").remove();
		}
		};
		$.lauvan.openCustomDialog("channelDialog", para, null, "form1");
	}

	function editchannel(){
		var options = $(this).linkbutton("options");
		var row = $("#channel_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/channel/edit/' + row.CHANNELID,
			width:730,
			height:500,
			onClose:function(){
			//if(channeleditor!=null && channeleditor!=undefined){
			//	channeleditor.blur();
			//}
			KindEditor.remove('textarea[name="c.content"]');
			$(this).dialog('destroy');
			$("#channelDialog").remove();
		}
		};
		$.lauvan.openCustomDialog("channelDialog", para, null, "form1");
	}
	function isDisplay(val, row){
		if(val == 1){
			return '是';
		}else{
			return '否';
		}
	}
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
			  <div data-options="region:'west', split:true" style="width:200px;">
			 	<ul id="channeltree" class="ztree"></ul>
			 </div>
			<div data-options="region:'center',border:false">
			<table id="channel_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="CHANNELID" data-options="hidden:true">ID</th> 
			            <th field="CHANNELNAME" width="100">栏目名称</th> 
			            <th field="CHANNELPATH" width="100">访问路径</th>
			            <th field="ISDISPLAY" width="100" data-options="formatter:isDisplay">是否显示</th>
			            <th field="PRIORITY" width="100">排列顺序</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
