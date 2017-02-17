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
				idField:'ARCID',
				fit:true,
				url:'<%=basePath%>Main/archive/getArchiveFileData?atype=${atype}',
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if(item.CHECKED==1){
							$('#archiveFileGrid').datagrid('checkRow', index);
						}
					});
				},
				onDblClickRow:archivedocview,
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var law = $("#arcfilesel").datalist("getData");
				var rows = law.rows;
				var total = law.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].ARCID==rowData.ARCID){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"ARCID":rowData.ARCID,"NAME":rowData.NAME});
					total++;
				}
				law.rows = rows;
				law.total = total;
				$("#arcfilesel").datalist("loadData",law);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var law = $("#arcfilesel").datalist("getData");
				var rows = law.rows;
				var nlaw = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].ARCID!=rowData.ARCID){
						nlaw.push(rows[i]);
					}
				}
				law.rows = nlaw;
				law.total = nlaw.length;
				$("#arcfilesel").datalist("loadData",law);
			},
			onCheckAll:function(rows){
				//全选添加
				var law = $("#arcfilesel").datalist("getData");
				var law_rows = law.rows;
				var nlaw = [];
				for(var k=0;k<law_rows.length;k++){
					nlaw.push(law_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<law_rows.length;j++){
						if(rows[i].ARCID==law_rows[j].ARCID){
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
				$("#arcfilesel").datalist("loadData",law);
			},
			onUncheckAll:function(rows){
				//全不选
				var law = $("#arcfilesel").datalist("getData");
				var law_rows = law.rows;
				var nlaw = [];
				for(var k=0;k<law_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].ARCID==law_rows[k].ARCID){
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
				$("#arcfilesel").datalist("loadData",law);
			}	
	    };
		$.lauvan.dataGrid("archiveFileGrid",attrArray);
		$("#arcfilesel").datalist({
			fit:true,
			valueField:'ARCID',
			textField: 'NAME'	
		});
	});
function archivedocview(){
	var node = $("#archiveFileGrid").datagrid('getSelected');
	if(!node){
		$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
		return;
	}
	window.open('<%=basePath%>Main/archive/getFileview/' + node.ARCID+'-'+node.ATYPE);
	}
function _archiveFile_doSearch(){
	$('#archiveFileGrid').datagrid('load',{
		arcname: $('#arcname').val()
	});
}
</script>

<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>文件标题：</span>
			<input id="arcname" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="_archiveFile_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
</div>
	<div data-options="region:'center',border:false" >
		<table id="archiveFileGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					            <th field="NAME" width="150">文件标题</th> 
					            <th field="ATYPE" width="100" CODE="GDFL" >归档类型</th>
					            <th field="RELATENAME" width="150"  >关联名称</th>
					            <th field="FTYPE" width="100"  >文件类型</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
	
	<div data-options="region:'east',border:false" style="width:150px;">
		<div id="arcfilesel" class="easyui-datalist" title="已选择归档文件" lines="true" >
			<c:if test="${!empty arcfilesel}">
				<c:forEach items="${arcfilesel}" var="arcfilesel">
					<li value="${arcfilesel.arcid}">${arcfilesel.name}</li>
				</c:forEach>
			</c:if>
		</div>
	</div>
	

</div>	
	
	 
	
