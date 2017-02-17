<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_sms;
	var setting_sms = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_sms
		}
	};
	
	var zNodes_sms =[
	     		{ id:"0", pId:"0", name:"通讯簿"},
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
	
	function zTreeOnClick_sms(event, treeId, treeNode) {
		$('#smsMobileGrid').datagrid({url:'<%=basePath%>Main/eventProcess/getSmsList/'+treeNode.id});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					$("#results_number", parent.document).append("<li id='list_"+rowData.ID+"'><input type='hidden' name='number' value='"+rowData.PHONENUM+"'></input><span>"+rowData.SMSNAME+"</span><span>"+rowData.PHONENUM+"</span></li>");
					$("#mobilecounts").text(parseInt($("#mobilecounts").text())+1);
					$("#results_number li").click(function() {
						$("#results_number li").removeClass("active");
						$(this).addClass("active");
					});
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if($("#results_number #list_"+rowData.ID, parent.document).length>0){				
				$("#mobilecounts").text(parseInt($("#mobilecounts").text())-1);
				$("#results_number #list_"+rowData.ID, parent.document).remove();
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#_smsMobile").val();
				var smsname = $("#_smsMobname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						$("#results_number", parent.document).append("<li id='list_"+rows[i].ID+"'><input type='hidden' name='number' value='"+rows[i].PHONENUM+"'></input><span>"+rows[i].SMSNAME+"</span><span>"+rows[i].PHONENUM+"</span></li>");
						$("#mobilecounts").text(parseInt($("#mobilecounts").text())+1);
					}
				}
				$("#results_number li").click(function() {
					$("#results_number li").removeClass("active");
					$(this).addClass("active");
				});
			},
			onUncheckAll:function(rows){
				//全不选
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						//取消勾选
						$("#mobilecounts").text(parseInt($("#mobilecounts").text())-1);
						$("#results_number #list_"+rows[i].ID, parent.document).remove();
						$("#mobilecounts").text(parseInt($("#mobilecounts").text())-1);
					}
				}
			}
	    };
		$.lauvan.dataGrid("smsMobileGrid",attrArray);
		$.fn.zTree.init($("#smsMobileTree"), setting_sms, zNodes_sms);
		zTree_sms = $.fn.zTree.getZTreeObj('smsMobileTree');
		zTree_sms.selectNode(zTree_sms.getNodeByParam("id", '${apId}', null));
	});
	
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	<ul id="smsMobileTree" class="ztree"></ul>
</div>
<div data-options="region:'center',border:false">
<div class="easyui-layout"  data-options="fit:true">

<!-- <div data-options="region:'north',border:false" >
	
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1" style="width:100px;" >已勾选手机号码</td>
		    	<td colspan="3">
		    		<input type="hidden" id="_smsMobname" name="_smsMobname" />
		    		<input type="text" id="_smsMobile" name="_smsMobile" data-options="icons:iconClear,editable:false" 
		    		class="easyui-textbox" style="width: 460px;"/>
		    	</td>
		    	</tr>
	    </table>
    
	</div> -->

<div data-options="region:'center',border:false" >
	<table id="smsMobileGrid" cellspacing="0" cellpadding="0"> 
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

	
	</div>
	</div>
</div>	
	
	 
	
