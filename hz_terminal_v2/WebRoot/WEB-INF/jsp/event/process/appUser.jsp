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
				url:'<%=basePath%>Main/mobileuser/getGridData',
				onLoadSuccess:function(data){
					$.each(data.rows, function(index, item){
						if((','+'${zhduid}'+',').indexOf(","+item.ID+",")>=0){
							$('#zhdUserGrid').datagrid('checkRow', index);
						}
					});
				},
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				var zhd = $("#zhdSelect").datalist("getData");
				var rows = zhd.rows;
				var total = zhd.total;
				var flag = true;
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID==rowData.ID){
						flag = false;
						break;
					}
				}
				if(flag){
					rows.push({"ID":rowData.ID,"REALNAME":rowData.REALNAME});
					total++;
				}
				zhd.rows = rows;
				zhd.total = total;
				$("#zhdSelect").datalist("loadData",zhd);
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				var zhd = $("#zhdSelect").datalist("getData");
				var rows = zhd.rows;
				var nzhd = [];
				for(var i=0;i<rows.length;i++){
					if(rows[i].ID!=rowData.ID){
						nzhd.push(rows[i]);
					}
				}
				zhd.rows = nzhd;
				zhd.total = nzhd.length;
				$("#zhdSelect").datalist("loadData",zhd);
			},
			onCheckAll:function(rows){
				//全选添加
				var zhd = $("#zhdSelect").datalist("getData");
				var zhd_rows = zhd.rows;
				var nzhd = [];
				for(var k=0;k<zhd_rows.length;k++){
					nzhd.push(zhd_rows[k]);
				}
				for(var i=0;i<rows.length;i++){
					var flag = true;
					for(var j=0;j<zhd_rows.length;j++){
						if(rows[i].ID==zhd_rows[j].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nzhd.push(rows[i]);
					}
				}
				zhd.rows = nzhd;
				zhd.total = nzhd.length;
				$("#zhdSelect").datalist("loadData",zhd);
			},
			onUncheckAll:function(rows){
				//全不选
				var zhd = $("#zhdSelect").datalist("getData");
				var zhd_rows = zhd.rows;
				var nlaw = [];
				for(var k=0;k<zhd_rows.length;k++){
					var flag = true;
					for(var i=0;i<rows.length;i++){
						if(rows[i].ID==law_rows[k].ID){
							flag = false;
							break;
						}
					}
					if(flag){
						nzhd.push(zhd_rows[k]);
					}
				}
				zhd.rows = nzhd;
				zhd.total = nzhd.length;
				$("#zhdSelect").datalist("loadData",zhd);
			}	
	    };
		$.lauvan.dataGrid("zhdUserGrid",attrArray);
		$("#zhdSelect").datalist({
			fit:true,
			valueField:'ID',
			textField: 'REALNAME'	
		});
	});
	
</script>

<div class="easyui-layout"  data-options="fit:true">

	<div data-options="region:'center',border:false" >
		<table id="zhdUserGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					             <th field="USERNAME" width="200">用户名</th> 
					            <th field="REALNAME" width="200">名称</th>	
					            <th field="DEPPOSNAME" width="400">职位</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
	
	<div data-options="region:'east',border:false" style="width:150px;">
		<div id="zhdSelect" class="easyui-datalist" title="已选择任务接收人" lines="true" >
			<c:if test="${!empty ulist}">
				<c:forEach items="${ulist}" var="ulist">
					<li value="${ulist.id}">${ulist.realname}</li>
				</c:forEach>
			</c:if>
		</div>
	</div>
	

</div>	
	
	 
	
