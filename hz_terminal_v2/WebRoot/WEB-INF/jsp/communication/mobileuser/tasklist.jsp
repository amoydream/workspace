<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script type="text/javascript">
	
	
	function task_doSearch(){
		$('#taskGrid').datagrid('load',{
			sendtime: $('#sendtimeid').datetimebox('getValue'),
		});
	}
	
	
	function sendStatus(val){
		if(val=='0'){
			return '未完成';
		}else if(val=='1'){
			return '已完成';
		}	
	}
	
	function pushStatus(val){
		if(val=='-1'){
			return '失败';
		}else if(val=='0'){
			return '推送中...';
		}else if(val=='1'){
			return '成功';
		}	
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		<div id="vip_tb">
		<span>发送时间:</span>
		<input id="sendtimeid" type="text" class="easyui-datebox" editable="false">
		<input type="hidden" id="uid" value="${userid}"/>
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="task_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		
			<table id="taskGrid" class="easyui-datagrid"  data-options="url:'Main/mobileuser/getTaskList?userid=${userid}',pagination:true,onDblClickRow:showBackList"  cellspacing="0" cellpadding="0" height="92%" width="100%"> 
			    <thead> 
			        <tr> 			       
			            <th field="TITLE" width="27%">任务标题</th> 
			            <th field="SENDUSER"  width="15%">发送人</th> 
			            <th field="POINTX"  width="15%">经度</th> 
			            <th field="POINTY"  width="15%">纬度</th> 			       
			            <th field="TIME"  width="20%">推送时间</th> 
			          <!--   <th field="STATUS"  width="7%" formatter="sendStatus">完成状态</th>  -->
			            <th field="SENDSTATUS"  width="8%" formatter="pushStatus">推送状态</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

