<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script>
    var basePath = '<%=basePath%>';
    $(function(){
    var caseAttrArray={
		idField:'CAS_ID',
		fitColumns : true,
	    toolbar: [
		],
		url:basePath+"Main/cases/getData/${deptid}"
};
    $.lauvan.dataGrid("casesGrid2",caseAttrArray);
});

    function cases_doSearch(){
	$('#casesGrid2').datagrid('load',{
		caTitle: $('#caTitle').val(),
	});
}
    
 
</script>


<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false"
		style="padding: 5px;background:#f7f7f7;">
		<span>案例标题：</span> <input id="caTitle" type="text"
			class="easyui-textbox"> <a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="cases_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="casesGrid2" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="CAS_ID" data-options="hidden:true"></th>
					<th field="CODE" width="200">编号</th>
					<th field="TITLE" width="200">案例标题</th>
					<th field="ADDRESS" width="400">事发地址</th>
				</tr>
			</thead>
		</table>
	</div>
</div>





