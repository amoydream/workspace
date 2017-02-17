<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_orgfax;
	var setting_orgfax = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_orgfax
		}
	};
	
	var zNodes_orgfax =[
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
	
	function zTreeOnClick_orgfax(event, treeId, treeNode) {
		$('#efaxGrid').datagrid({url:'<%=basePath%>Main/eventProcess/getfaxnumData/'+treeNode.id});
	};
	$(document).ready(function(){
		
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if((","+'${faxnos}'+",").indexOf(","+item.FAX+",")>=0){
							$('#efaxGrid').datagrid('checkRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var orgper = $("#faxSelect").datalist("getData");
				var rows = orgper.rows;
				var total = orgper.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].FAX==rowData.FAX){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"FAX":rowData.FAX,"ADD_NAME":rowData.ADD_NAME});
					total++;
				}
				orgper.rows = rows;
				orgper.total = total;
				$("#faxSelect").datalist("loadData",orgper);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var orgper = $("#faxSelect").datalist("getData");
				var rows = orgper.rows;
				var norgper = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].FAX!=rowData.FAX){
						norgper.push(rows[i]);
					}
				}
				orgper.rows = norgper;
				orgper.total = norgper.length;
				$("#faxSelect").datalist("loadData",orgper);
			},
			onCheckAll:function(rows){
				//全选添加
				var orgper = $("#faxSelect").datalist("getData");
				var orgper_rows = orgper.rows;
				var norgper = [];
				for(var k=0;k<orgper_rows.length;k++){
					norgper.push(orgper_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<orgper_rows.length;j++){
						if(rows[i].FAX==orgper_rows[j].FAX){
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
				$("#faxSelect").datalist("loadData",orgper);
			},
			onUncheckAll:function(rows){
				//全不选
				var orgper = $("#faxSelect").datalist("getData");
				var orgper_rows = orgper.rows;
				var norgper = [];
				for(var k=0;k<orgper_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].FAX==orgper_rows[k].FAX){
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
				$("#faxSelect").datalist("loadData",orgper);
			}
	    };
		$.lauvan.dataGrid("efaxGrid",attrArray);
		$("#faxSelect").datalist({
			fit:true,
			valueField:'ADD_NAME',
			textField: 'FAX'	
		});
		$.fn.zTree.init($("#orgFaxTree"), setting_orgfax, zNodes_orgfax);
		zTree_orgfax = $.fn.zTree.getZTreeObj('orgFaxTree');
		zTree_orgfax.selectNode(zTree_orgfax.getNodeByParam("id", '${apId}', null));
	});
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="orgFaxTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
	<table id="efaxGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="ADD_NAME" width="150">名称</th> 
				            <th field="FAX" width="100" >传真号码</th>
				        </tr> 
				    </thead> 
	</table>
</div>
	 <div data-options="region:'east',border:false" style="width:150px;">
		<div id="faxSelect" class="easyui-datalist" title="已选择传真号码" lines="true" >
			<c:if test="${!empty faxsel}">
				<c:forEach items="${faxsel}" var="list">
					<li value="${list.add_name}">${list.fax}</li>
				</c:forEach>
			</c:if>
		</div>
		
	</div>
	
</div>	
	
	 
	
