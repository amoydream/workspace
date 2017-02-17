<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				url:'<%=basePath%>Main/plan/getLawData/${prid}',
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if(item.CHECKED==1){
							$('#planlawGrid').datagrid('checkRow', index);
						}
					});
				},
				onDblClickRow:lawdocview,
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var law = $("#lawSelect").datalist("getData");
				var rows = law.rows;
				var total = law.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].LR_ID==rowData.LR_ID){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"LR_ID":rowData.LR_ID,"LR_TITLE":rowData.LR_TITLE});
					total++;
				}
				law.rows = rows;
				law.total = total;
				$("#lawSelect").datalist("loadData",law);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var law = $("#lawSelect").datalist("getData");
				var rows = law.rows;
				var nlaw = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].LR_ID!=rowData.LR_ID){
						nlaw.push(rows[i]);
					}
				}
				law.rows = nlaw;
				law.total = nlaw.length;
				$("#lawSelect").datalist("loadData",law);
			},
			onCheckAll:function(rows){
				//全选添加
				var law = $("#lawSelect").datalist("getData");
				var law_rows = law.rows;
				var nlaw = [];
				for(var k=0;k<law_rows.length;k++){
					nlaw.push(law_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<law_rows.length;j++){
						if(rows[i].LR_ID==law_rows[j].LR_ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nlaw.push(rows[i]);
					}
				}
				law.rows = nlaw;
				law.total = nlaw.length;
				$("#lawSelect").datalist("loadData",law);
			},
			onUncheckAll:function(rows){
				//全不选
				var law = $("#lawSelect").datalist("getData");
				var law_rows = law.rows;
				var nlaw = [];
				for(var k=0;k<law_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].LR_ID==law_rows[k].LR_ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nlaw.push(law_rows[k]);
					}
				}
				law.rows = nlaw;
				law.total = nlaw.length;
				$("#lawSelect").datalist("loadData",law);
			}	
	    };
		$.lauvan.dataGrid("planlawGrid",attrArray);
		$("#lawSelect").datalist({
			fit:true,
			valueField:'LR_ID',
			textField: 'LR_TITLE'	
		});
	});
function lawdocview(){
	var node = $("#planlawGrid").datagrid('getSelected');
	if(!node){
		$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
		return;
	}
	$("#viewlawrulDialog").dialog({
		title : '法律法规详情',
		width : 800,
		height : 620,
		cache : false,
		modal : true,
		href : '<%=basePath%>Main/lawrul/view/' + node.LR_ID,
		buttons : []
	});
	}
	
</script>

<div class="easyui-layout"  data-options="fit:true">

	<div data-options="region:'center',border:false" >
		<table id="planlawGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					            <th field="LR_TITLE" width="150">标题</th> 
					            <th field="LR_PUBLISHDEPT" width="100"  >部门</th>
					            <th field="LR_PUBLISHDATE" width="100"  >日期</th>
					            <th field="lr_startdate" width="100"  >生效日期</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
	
	<div data-options="region:'east',border:false" style="width:150px;">
		<div id="lawSelect" class="easyui-datalist" title="已选择法律法规" lines="true" >
			<c:if test="${!empty lawsel}">
				<c:forEach items="${lawsel}" var="lawsel">
					<li value="${lawsel.lr_id}">${lawsel.lr_title}</li>
				</c:forEach>
			</c:if>
		</div>
	</div>
	

</div>	
	
	 
	
