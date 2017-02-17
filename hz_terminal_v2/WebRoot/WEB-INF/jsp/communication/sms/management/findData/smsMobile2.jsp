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
	     		/* { id:"dept", pid:"0", name:"部门"}, */
	     		/* { id:"cluster", pid:"0", name:"群组"} */
	     		{ id:"c_0", pid:"0", name:"群组"} 
	     		//部门
	     		/* <c:forEach items="${orglist2}" var="organ2" >
	     		,{ id:"${organ2.did}", pid:"dept", name:"${organ2.dept}"}
	     		</c:forEach> */
	     		//群组
	     		<c:forEach items="${clulist}" var="clulist" >
	     		,{ id:"c_${clulist.id}", pid:"c_${clulist.pid}", name:"${clulist.name}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_sms(event, treeId, treeNode) {
		$('#smsMobileGrid').datagrid({url:'<%=basePath%>Main/smsMg/getSmsList/'+treeNode.id+"-"+treeNode.pid});
	};
	$(document).ready(function(){
		var attrArray={
				fitColumns : true,
				idField:'ID',
				fit:true,
				pagination:true,
				pageList: [20,50,100,200],
				onCheck:function(rowIndex,rowData){
				//在已勾选框添加
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = $("#_smsMobile").val();
					var smsname = $("#_smsMobname").val();
					if((","+sms+",").indexOf(","+rowData.PHONENUM+",")<0){
						if(sms!=null && sms!=''){
							sms = sms+","+rowData.PHONENUM;
						}else{
							sms = sms+rowData.PHONENUM;
						}
						$("#_smsMobile").textbox('setValue',sms);
						if(smsname!=null && smsname!=''){
							smsname = smsname+","+rowData.SMSNAME;
						}else{
							smsname = smsname+rowData.SMSNAME;
						}
						$("#_smsMobname").val(smsname);
					}
				}
			},
			onUncheck:function(rowIndex,rowData){
				//取消勾选
				if(rowData.PHONENUM!=null && rowData.PHONENUM!=''){
					var sms = ","+$("#_smsMobile").val()+",";
					var smsname = ","+$("#_smsMobname").val()+",";
					sms = sms.replace(","+rowData.PHONENUM+",",",");
					smsname = smsname.replace(","+rowData.SMSNAME+",",",");
					$("#_smsMobile").textbox('setValue',sms.length==1?"":sms.substring(1,sms.length-1));
					$("#_smsMobname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
				}
			},
			onCheckAll:function(rows){
				//全选添加
				var sms = $("#_smsMobile").val();
				var smsname = $("#_smsMobname").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if((","+sms+",").indexOf(","+rows[i].PHONENUM+",")<0){
							//sms = sms+","+rows[i].PHONENUM;
							if(sms!=null && sms!=''){
								sms = sms+","+rows[i].PHONENUM;
							}else{
								sms = sms+rows[i].PHONENUM;
							}
							if(smsname!=null && smsname!=''){
								smsname = smsname+","+rows[i].SMSNAME;
							}else{
								smsname = smsname+rows[i].SMSNAME;
							}
						}
					}
				}
				$("#_smsMobile").textbox('setValue',sms);
				$("#_smsMobname").val(smsname);
			},
			onUncheckAll:function(rows){
				//全不选
				var sms = ","+$("#_smsMobile").val()+",";
				var smsname = ","+$("#_smsMobname").val()+",";
				for(var i=0;i<rows.length;i++){
					if(rows[i].PHONENUM!=null && rows[i].PHONENUM!=''){
						if(sms.indexOf(","+rows[i].PHONENUM+",")>=0){
							sms = sms.replace(","+rows[i].PHONENUM+",",",");
							smsname = smsname.replace(","+rows[i].SMSNAME+",",",");
						}
					}
				}
				$("#_smsMobile").textbox('setValue',sms.length==1?"":sms.substring(1,sms.length-1));
				$("#_smsMobname").val(smsname.length==1?"":smsname.substring(1,smsname.length-1));
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

<div data-options="region:'north',border:false" >
	
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
    
	</div>

<div data-options="region:'center',border:false" >
	<table id="smsMobileGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="SMSNAME" width="150">名称</th> 
				            <th field="PHONENUM" width="100"  >手机</th>
				            <th field="DEPT" width="150"  >部门</th>
				            <th field="POSITION" width="100"  >职位</th>
				            <th field="REMARK" width="100" >备注</th>
				        </tr> 
				    </thead> 
	</table>
</div>

	
	</div>
	</div>
</div>	
	
	 
	
