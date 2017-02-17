<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_planres;
	var setting_planres = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_planres
		}
	};
	
	var zNodes_planres =[
				<c:if test="${!empty root}">      	
					{ id:"${root.id}", pid:"${root.sup_id}", name:"${root.p_name}",open:true}
				</c:if>
				<c:if test="${!empty rlist}"> 
				<c:forEach items="${rlist}" var="plist" >
				,{ id:"${plist.id}", pid:"${plist.sup_id}", name:"${plist.p_name}",pacode:"${plist.p_acode}"}
				</c:forEach>
				</c:if>
	     	];
	
	function zTreeOnClick_planres(event, treeId, treeNode) {
		var tid = treeNode.id;
		if("3010"=="${codetype}"){
			tid = treeNode.pacode;
		}
		$('#planresGrid').datagrid({url:'<%=basePath%>Main/planMg/getResourceList/${codetype}-'+tid+'-${preschid}'});
	};
	$(document).ready(function(){
		
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if(item.CHECKED==1){
							$('#planresGrid').datagrid('checkRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var planres = $("#planresSelect").datalist("getData");
				var rows = planres.rows;
				var total = planres.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID==rowData.ID){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"ID":rowData.ID,"NAME":rowData.NAME});
					total++;
				}
				planres.rows = rows;
				planres.total = total;
				$("#planresSelect").datalist("loadData",planres);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var planres = $("#planresSelect").datalist("getData");
				var rows = planres.rows;
				var nplanres = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID!=rowData.ID){
						nplanres.push(rows[i]);
					}
				}
				planres.rows = nplanres;
				planres.total = nplanres.length;
				$("#planresSelect").datalist("loadData",planres);
			},
			onCheckAll:function(rows){
				//全选添加
				var planres = $("#planresSelect").datalist("getData");
				var planres_rows = planres.rows;
				var nplanres = [];
				for(var k=0;k<planres_rows.length;k++){
					nplanres.push(planres_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<planres_rows.length;j++){
						if(rows[i].ID==planres_rows[j].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nplanres.push(rows[i]);
					}
				}
				planres.rows = nplanres;
				planres.total = nplanres.length;
				$("#planresSelect").datalist("loadData",planres);
			},
			onUncheckAll:function(rows){
				//全不选
				var planres = $("#planresSelect").datalist("getData");
				var planres_rows = orgper.rows;
				var nplanres = [];
				for(var k=0;k<planres_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].ID==planres_rows[k].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nplanres.push(orgper_rows[k]);
					}
				}
				planres.rows = nplanres;
				planres.total = nplanres.length;
				$("#planresSelect").datalist("loadData",orgper);
			}
	    };
		$.lauvan.dataGrid("planresGrid",attrArray);
		$("#planresSelect").datalist({
			fit:true,
			valueField:'ID',
			textField: 'NAME'	
		});
		$.fn.zTree.init($("#planresTree"), setting_planres, zNodes_planres);
		zTree_planres = $.fn.zTree.getZTreeObj('planresTree');
	});
	
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="planresTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
	<table id="planresGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="NAME" width="150">名称</th>
				            <c:if test="${codetype=='3020' || codetype=='3030'}">
				            <th field="UCODE" width="100" CODE="MAUNIT">计量单位</th>
				            <th field="TCODE" width="150"  >型号</th>
				            <th field="SCODE" width="100"  >规格</th>
				            <th field="REMARK" width="100" >备注</th>
				            </c:if> 
				            <c:if test="${codetype=='2080'}">
				            <th field="SEX" width="50" CODE="SEX">性别</th>
				            <th field="PROFESSIONAL" width="150"  code="BYZY">专业</th>
				            <th field="JOBTITLE" width="150" code="TECHPOSE" >职称</th>
				            </c:if>
				            <c:if test="${codetype=='3010'}">
				            <th field="TEAMJOB" width="150" >队伍职责</th>
				            <th field="REMARK" width="150"  >队伍描述</th>
				            </c:if>
				        </tr> 
				    </thead> 
	</table>
</div>
	 <div data-options="region:'east',border:false" style="width:150px;">
	 <form id="planRecform" method="post" action="<%=basePath %>Main/planMg/save" style="width:100%;">
		  <input type="hidden" name="t_Bus_PlanItem.preschid" value="${preschid}"/>
	      <input type="hidden" name="t_Bus_PlanItem.planitemcode" value="${codetype}"/>
		  <input type="hidden" name="act" value="add_presource"/>
	</form>
		<div id="planresSelect" class="easyui-datalist" title="已选择应急资源" lines="true" >
			<c:if test="${!empty reslist}">
				<c:forEach items="${reslist}" var="reslist">
					<li value="${reslist.itemid}">${reslist.itemname}</li>
				</c:forEach>
			</c:if>
		</div>
		
	</div>
	
</div>	
	
	 
	
