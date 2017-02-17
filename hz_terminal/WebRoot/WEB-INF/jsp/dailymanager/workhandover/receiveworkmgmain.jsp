<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	   "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
	 };   
	 if(/(y+)/.test(fmt))   
	   fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	   if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	}
	$(function(){
		var attrArray={
				//toolbar: '#receiveworkmg_tb',
				toolbar: [
                  { text: '接班', iconCls: 'icon-add',handler:receiveworkmg,permitParams:'${pert:hasperti(applicationScope.receivework, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				view: detailview,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/workhandover/getgivenGridData/r",
				onDblClickRow :workmgview,
				 detailFormatter:function(index,row){
				return '<div style="padding:2px"><table id="wh2-' + row.ID + '"></table></div>';
			},
			onExpandRow: function(index,row){
				$('#wh2-'+row.ID).datagrid({
					url:'<%=basePath%>Main/workhandover/getgivenGridDataview?id='+row.ID,
					fitColumns:true,
					singleSelect:true,
					rownumbers:true,
					loadMsg:'',
					height:'auto',
					columns:[[
						{field:'EVENTNAME',title:'事件名称',width:200},
						{field:'D_NAME',title:'事发单位',width:200},
						{field:'CONTENT',title:'基本信息',width:300},
						{field:'TYPE',title:'类型',width:200},
						{field:'MARKTIME',title:'纪要时间',width:300},
						{field:'operation',title:'操作',formatter:function operation(value,row,index){
							var id=row.ID;
							var cc="";
							cc="<table width=\"100%\"><tr><td width=\"100%\"><a href=\"javascript:void(0);\" onclick=\"workview("+id+")\">详情</a></td></tr></table>";
							return cc;
						},width:200}
					]],
					onResize:function(){
						$('#receiveworkmgGrid').datagrid('fixDetailRowHeight',index);
					},
					onLoadSuccess:function(){
						setTimeout(function(){
							$('#receiveworkmgGrid').datagrid('fixDetailRowHeight',index);
						},0);
					}
				});
				$('#receiveworkmgGrid').datagrid('fixDetailRowHeight',index);
			}  
        };
		$.lauvan.dataGrid("receiveworkmgGrid",attrArray);
		
	});
	function workview(id){
		var attrArray={
				title:'值班纪要详情',
				height: 400,
				width:700,
				href: '<%=basePath%>Main/workhandover/workview/'+id,
				buttons:[]
		};
		$.lauvan.openCustomDialog("workmgDialog",attrArray,null,null);		
	}
	function workmgview(){
		var node = $("#receiveworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'交班信息详情',
				height: 300,
				width:700,
				href: '<%=basePath%>Main/workhandover/workmgview/'+node.ID,
				buttons:[]
		};
		$.lauvan.openCustomDialog("workmgDialog",attrArray,null,null);		
}
	function receiveworkmg_doSearch(){
		$('#receiveworkmgGrid').datagrid('load',{
			givenname: $('#givenname1').val(),
			receivename: $('#receivename1').val()
			
		});
	}
	function receiveworkmg(){
		var node = $("#receiveworkmgGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲接班的记录！'});
			return;
		}
		if(node.GETDUTY){
			$.lauvan.MsgShow({msg:'此记录已接班，不能重复接班！'});
			return;	
		}
		var myDate = new Date().Format("yyyy-MM-dd hh:mm:ss"); 
		$.messager.confirm('接班','接班时间为：'+myDate+'，您确定接班吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/workhandover/receivework/'+node.ID,
	            	type:'post',
	            	data:{"time":myDate},
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'接班成功'});
	            			$("#receiveworkmgGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>交班人:</span>
		<input id="givenname1" type="text" class="easyui-textbox" >
		<span>接班人:</span>
		<input id="receivename1" type="text" class="easyui-textbox" >		
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="receiveworkmg_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		
		<!-- <div id="receiveworkmg_tb">
		
		<a href="javascript:void(0);" onclick="receiveworkmg()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">接班</a>
        </div> -->
		
			<table id="receiveworkmgGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="GIVERNAME" width="100">交班人</th> 
			            <th field="RECEIVENAME" width="100">接班人</th> 
			            <th field="DUTYDATE" width="200">交班时间</th> 
			            <th field="BAK" width="200">备注</th> 
			            <th field="GETDUTY"  width="200" >接班时间</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
