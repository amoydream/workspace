<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_orgper;
	var setting_orgper = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_orgper
		}
	};
	
	var zNodes_orgper =[
	     		{ id:"0", pId:"0", name:"通讯簿",open:true},
	     		{ id:"yj_organ", pid:"0", name:"日常机构"},
	     		{ id:"yj_user", pid:"0", name:"日常机构人员"},
	     		{ id:"hy_organ", pid:"0", name:"应急机构"},
	     		{ id:"hy_user", pid:"0", name:"应急机构人员"}
	     		
	     		
	     		//日常机构
	     		<c:forEach items="${orglist2}" var="organ2" >
	     		,{ id:"od_${organ2.or_id}", pid:"${empty organ2.or_pid||organ2.or_pid==0 ? 'yj_organ' : organ2.pid}", name:"${organ2.or_name}"}
	     		</c:forEach>
	     		//日常机构人员
	     		<c:forEach items="${orglist2}" var="ulist2" >
	     		,{ id:"ou_${ulist2.or_id}", pid:"${empty ulist2.or_pid||ulist2.or_pid==0 ? 'yj_user' : ulist2.upid}", name:"${ulist2.or_name}"}
	     		</c:forEach>
	     		//应急办组织机构
	     		<c:forEach items="${orglist}" var="organ" >
	     		,{ id:"d_${organ.d_id}", pid:"${organ.d_pid==0?'hy_organ' : organ.pid}", name:"${organ.d_name}"}
	     		</c:forEach>
	     		//应急办人员
	     		<c:forEach items="${orglist}" var="ulist" >
	     		,{ id:"u_${ulist.d_id}", pid:"${ulist.d_pid==0 ? 'hy_user' : ulist.upid}", name:"${ulist.d_name}"}
	     		</c:forEach>
	     		//群组
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.e_id}", pid:"${clulist.e_pid==0?0 : clulist.epid}", name:"${clulist.e_name}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_orgper(event, treeId, treeNode) {
		$('#orgperGrid').datagrid({url:'<%=basePath%>Main/planMg/getSmsList/'+treeNode.id});
	};
	$(document).ready(function(){
		
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if((","+'${groupOrg.itemid}'+",").indexOf(","+item.ID+",")>=0){
							$('#orgperGrid').datagrid('checkRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var orgper = $("#orgperSelect").datalist("getData");
				var rows = orgper.rows;
				var total = orgper.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID==rowData.ID){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"ID":rowData.ID,"SMSNAME":rowData.SMSNAME});
					total++;
				}
				orgper.rows = rows;
				orgper.total = total;
				$("#orgperSelect").datalist("loadData",orgper);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var orgper = $("#orgperSelect").datalist("getData");
				var rows = orgper.rows;
				var norgper = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID!=rowData.ID){
						norgper.push(rows[i]);
					}
				}
				orgper.rows = norgper;
				orgper.total = norgper.length;
				$("#orgperSelect").datalist("loadData",orgper);
			},
			onCheckAll:function(rows){
				//全选添加
				var orgper = $("#orgperSelect").datalist("getData");
				var orgper_rows = orgper.rows;
				var norgper = [];
				for(var k=0;k<orgper_rows.length;k++){
					norgper.push(orgper_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<orgper_rows.length;j++){
						if(rows[i].ID==orgper_rows[j].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						norgper.push(rows[i]);
					}
				}
				orgper.rows = norgper;
				orgper.total = norgper.length;
				$("#orgperSelect").datalist("loadData",orgper);
			},
			onUncheckAll:function(rows){
				//全不选
				var orgper = $("#orgperSelect").datalist("getData");
				var orgper_rows = orgper.rows;
				var norgper = [];
				for(var k=0;k<orgper_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].ID==orgper_rows[k].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						norgper.push(orgper_rows[k]);
					}
				}
				orgper.rows = norgper;
				orgper.total = norgper.length;
				$("#orgperSelect").datalist("loadData",orgper);
			}
	    };
		$.lauvan.dataGrid("orgperGrid",attrArray);
		$("#orgperSelect").datalist({
			fit:true,
			valueField:'ID',
			textField: 'SMSNAME'	
		});
		$.fn.zTree.init($("#orgperTree"), setting_orgper, zNodes_orgper);
		zTree_orgper = $.fn.zTree.getZTreeObj('orgperTree');
		zTree_orgper.selectNode(zTree_orgper.getNodeByParam("id", '${apId}', null));
	});
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="orgperTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
	<table id="orgperGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="POSITION" width="100"  >岗位</th>
				            <th field="ADDRESS" width="150"  >地址</th>
				            <th field="WORKNUM" width="100"  >办公电话</th>
				            <th field="PHONENUM" width="100" >手机</th>
				            <th field="HOMENUM" width="100" >住址电话</th>
				            <th field="FAXNUM" width="100" >传真</th>
				        </tr> 
				    </thead> 
	</table>
</div>
	 <div data-options="region:'east',border:false" style="width:150px;">
		<div id="orgperSelect" class="easyui-datalist" title="已选择机构/人员" lines="true" >
			<c:if test="${!empty orgper}">
				<c:forEach items="${orgper}" var="orgper">
					<li value="${orgper.id}">${orgper.smsname}</li>
				</c:forEach>
			</c:if>
		</div>
		
	</div>
	
</div>	
	
	 
	
