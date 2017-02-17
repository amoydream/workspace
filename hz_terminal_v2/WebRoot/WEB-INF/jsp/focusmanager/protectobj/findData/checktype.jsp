<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

  <script>
  var basePath = '<%=basePath%>';
  $(function(){
			//清空内容
			$("#checktypeDiv").empty();
			//创建树表格
			$("#checktypeDiv").append('<table id="typetable"  cellspacing="0" cellpadding="0" ></table>');
				$("#typetable").treegrid({
					url:'<%=basePath%>Main/protectobj/getCheckData',
					idField:'ID',    
				    treeField:'CHECKNAME',
					columns:[[{title:'类型',field:'CHECKNAME',width:180}]],
					fitColumns : true,
					nowrap: false, 
			        striped: true, 
			        border: true,
			        method: 'post',
			        collapsible:false,//是否可折叠的 
			        fit: true,//自动大小 
			        singleSelect: true,
			        selectOnCheck: false,
			        checkOnSelect: false	
				});
	  });
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="checktypeDiv" style="width: 100%;height: 100%;">
			</div>
		</div>
		
	</div>


