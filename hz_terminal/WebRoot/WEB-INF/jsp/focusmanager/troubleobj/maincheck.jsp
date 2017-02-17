<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript">	
	var zTree_yhdlbcheck;
	var zNodes_yhdlbcheck;
	var selectedNode_yhdlbcheck;
	var setting_type = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_yhdlbcheck
		}
	};
	function zTreeOnClick_yhdlbcheck(event, treeId, treeNode) {
		if(treeNode.id==0){
			return;
		}
		$('#troublecheckGrid').datagrid({url:'<%=basePath%>Main/troubleinfo/getcheckGridData',queryParams:{p_check:treeNode.p_acode}});
		selectedNode_yhdlbcheck=zTree_yhdlbcheck.getSelectedNodes()[0];
		$("#troublecheckGrid").datagrid("clearSelections");
		$("#troublecheckGrid").datagrid("clearChecked");
	};
	function initTree_yhdlbcheckTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/troubleinfo/getTree',
					error : function() {
						alert('请求失败');
					},
					success : function(data) {
						zNodes_yhdlbcheck = data; //把后台封装好的简单Json格式赋给treeNodes  
						if (zTree_yhdlbcheck != null)
							zTree_yhdlbcheck.destroy();
						zTree_yhdlbcheck = $.fn.zTree.init(
								$("#yhdlbcheckTree"), setting_type,
								zNodes_yhdlbcheck);
						if (!selectedNode_yhdlbcheck) {
							selectedNode_yhdlbcheck = zTree_yhdlbcheck
									.getNodeByParam("id", '325', null);
							if (selectedNode_yhdlbcheck.children
									&& selectedNode_yhdlbcheck.children.length > 0)
								selectedNode_yhdlbcheck = selectedNode_yhdlbcheck.children[0];
						}
						zTree_yhdlbcheck.selectNode(selectedNode_yhdlbcheck);
						zTree_yhdlbcheck.expandNode(selectedNode_yhdlbcheck,
								true, false, false);
						zTree_yhdlbcheck.setting.callback.onClick(null,
								zTree_yhdlbcheck.setting.treeId,
								selectedNode_yhdlbcheck);

					}
				});

	}
	$(function() {
		initTree_yhdlbcheckTree();
		var attrArray = {
			fitColumns : true,
			idField : 'ID',
			rownumbers : true,
			frozenColumns : [ [] ],
			url : "<%=basePath%>Main/troubleinfo/getcheckGridData",
			onDblClickRow : function(rowIndex, rowData) {
				var attrArray = {
					title : '防护目标详情',
					width : 1200,
					height : 500,
					href : '<%=basePath%>Main/troubleinfo/view/' + rowData.ID,
					buttons : [ {
						text : '隐患点排查',
						iconCls : 'icon-save',
						handler : function() {
							$.messager.confirm('排查','您确定排查此隐患点吗？',function(r){
							    if (r){
							       $.ajax({
						            	url:'<%=basePath%>Main/troubleinfo/check/'+ rowData.ID,
						            	type:'post',
						            	traditional:true,
						            	success:function(data){
						            		if(data.success){
						            			$.lauvan.MsgShow({msg:'隐患点排查成功'});
						            			$("#proobjtableView").dialog('close');
						            			$("#troublecheckGrid").datagrid('reload');
						            		}
						            		else{
						            			$.messager.alert('错误',data.msg,data.errorcode);
						            		}
						            	}
						            });
							    }
							});	
						}
					}, {
						text : '关闭',
						iconCls : 'icon-no',
						handler : function() {
							$("#proobjtableView").dialog('close');
						}
					} ]
				};

				$.lauvan.openCustomDialog("proobjtableView", attrArray, null);
			}
		};
		$.lauvan.dataGrid("troublecheckGrid", attrArray);

	});
	function troublecheck_doSearch() {
		$('#troublecheckGrid').datagrid('load', {
			p_check : selectedNode_yhdlbcheck.p_acode,
			checkname : $('#checkname').val()

		});
	}
	function isvail(value, row, index) {
		var cc = value;
		if (cc == '0') {
			cc = '未排查';
		} else {
			cc = '已排查';
		}
		return cc;
	}
</script>


<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,border:false"
		style="width: 20%">
		<ul id="yhdlbcheckTree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',border:false"
				style="padding: 5px; background: #f7f7f7;">
				<span>隐患点名称（负责人）:</span> <input id="checkname" type="text"
					class="easyui-textbox"> <a href="javascript:void(0);"
					class="easyui-linkbutton" onclick="troublecheck_doSearch()"
					data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<div data-options="region:'center',border:false">
				<table id="troublecheckGrid" cellspacing="0" cellpadding="0"
					width="100%">
					<thead>
						<tr>
							<th field="HIDTRUBNAME" width="200">隐患点名称（负责人）</th>
							<th field="HIDTRUBADDR" width="400">隐患点地址</th>
							<th field="ISVAIL" formatter="isvail" width="100">状态</th>

						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
