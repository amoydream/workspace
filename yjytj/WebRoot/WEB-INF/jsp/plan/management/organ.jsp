<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_preschOrg;
	var setting_preschOrg = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschOrg
		},
		async: {
			enable: true,
			url: "Main/planMg/getOrganTreeData?preschid=${preschid}",
			autoParam:["id"],
			dataFilter: function(treeId, parentNode, responseData){
				var tdata =[]
			   	if (responseData) {
			   		var tlist = responseData;
			   	    for(var i =0; i < tlist.length; i++) {
			   	    	var data={};
			   	        data.id = tlist[i]['ID'];
			   	        data.pid = tlist[i]['PID'];
			   	        data.name = tlist[i]['ITEMNAME'];
			   	        data.isParent=tlist[i]['ISLEAF']==0?false:true;
			   	        tdata.push(data);
			   	     }
			   	 }
			   	 return tdata;
			}
		}
	};
	
	var zNodes_preschOrg =[
	     		{ id:"0", pId:"0", name:"应急机构",open:true}
	     		<c:forEach items="${orglist}" var="organ" >
	     		,{ id:"${organ.id}", pid:"${empty organ.pid?0:organ.pid}", name:"${organ.itemname}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschOrg(event, treeId, treeNode) {
		$("#_preschOrgPid").val(treeNode.id);
		$("#_preschOrgPname").val(treeNode.name);
		$('#preschOrgGrid').datagrid({url:'<%=basePath%>Main/planMg/getOrganData/'+treeNode.id});
	};
	$(document).ready(function(){
		var attrArray={
				<c:if test="${empty flag}">
				toolbar: [
		                  { text: '创建分组', iconCls: 'icon-add',
		                	  handler: function(){
		                	  		var pid = $("#_preschOrgPid").val();
		                	  		var dialogDef={
		                	  				title:'创建应急机构分组信息',
											width:700,
											height:350,
											href: '<%=basePath%>Main/planMg/add/organ-'+pid+"-${preschid}"
									};
									$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
		                  		}}, '-', 
		                  { text: '修改分组',iconCls: 'icon-pageedit', 
		                  		handler: function(){
		                	  		var pid = $("#_preschOrgPid").val();
		                	  		if(pid==null || pid==undefined ||pid==0){
		                	  			$.lauvan.MsgShow({msg:'请选择应急机构分组!'});
			            				return;
		                	  		}
		                	  		var dialogDef={
		                	  				title:'编辑应急机构分组信息',
											width:700,
											height:350,
											href: '<%=basePath%>Main/planMg/edit/organ-'+pid+"-${preschid}"
									};
									$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
		                  		}}, '-',
		                  { text: '删除分组',iconCls: 'icon-delete',
		                  		handler: function(){
			                  		var pname = $("#_preschOrgPname").val();
			                  		var pid = $("#_preschOrgPid").val();
		                  			$.messager.confirm('删除',"您确定删除【"+pname+"】分组",function(r){
			                  			if(r){
			                  				$.ajax({
			            		            	url:'<%=basePath%>Main/planMg/delete/organ',
			            		            	type:'post',
			            		            	dataType:'json',
			            		            	traditional:true,
			            		            	data:{'groupid':pid},
			            		            	success:function(data){
			            		            		if(data.success){
			            		            			$.lauvan.MsgShow({msg:'数据删除成功'});
			            		            			$("#preschOrgGrid").datagrid('clearSelections');
			            		            			$("#preschOrgGrid").datagrid('clearChecked');
			            		            			$("#preschOrgGrid").datagrid('reload');
			            		            			//刷新树
			    		            					var treeObj =  $.fn.zTree.getZTreeObj("preschOrgTree");
			    		            					if(data.reloadid!=null && ""!=data.reloadid && data.reloadid>0){
			    		            						var node = treeObj.getNodeByParam(data.idkey, data.reloadid, null);
			    		            						treeObj.reAsyncChildNodes(node, "refresh");
			    		            						treeObj.selectNode(node);
			    		            					}else{
			    		            						treeObj.reAsyncChildNodes(null, "refresh");
			    		            					}
			            		            		}else{
			            		            			$.messager.alert('错误',data.msg,data.errorcode);
			            		            		}
			            		            	}
			                  				});
			                  			}
		                  			});
		                  		}},'-',
		                  { text: '选择机构/人员', iconCls: 'icon-add',
		                	  handler: function(){
		                	  		var pid = $("#_preschOrgPid").val();
		                	  		if(pid==null || pid==undefined || pid==0){
		                	  			$.lauvan.MsgShow({msg:'请选择应急机构分组!'});
			            				return;
		                	  		}
		                	  		var dialogDef={
		                	  				title:'选择机构/人员',
											width:800,
											height:600,
											href: '<%=basePath%>Main/planMg/getOrganTree/'+pid+'-orgper2'
									};
									$.lauvan.openCustomDialog('planMgDialog',dialogDef,orgperSave);
		                  		}},'-',
		                  { text: '删除机构/人员',iconCls: 'icon-delete',
			                  		handler: function(){
				                  		var pid = $("#_preschOrgPid").val();
				                  		var rows=$("#preschOrgGrid").datagrid('getChecked');
				                  		if(rows.length==0){
				            				$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
				            				return;
				            			}
			                  			$.messager.confirm('删除',"您确定删除该机构/人员",function(r){
				                  			if(r){
				                  				var ids=[];
				            			        for(var i=0;i<rows.length;i++){
				            						ids[i]=rows[i].ID;
				            					}
				                  				$.ajax({
				            		            	url:'<%=basePath%>Main/planMg/delete/orgper',
				            		            	type:'post',
				            		            	dataType:'json',
				            		            	traditional:true,
				            		            	data:{'groupid':pid,'ids':ids},
				            		            	success:function(data){
				            		            		if(data.success){
				            		            			$.lauvan.MsgShow({msg:'数据删除成功'});
				            		            			$("#preschOrgGrid").datagrid('clearSelections');
				            		            			$("#preschOrgGrid").datagrid('clearChecked');
				            		            			$("#preschOrgGrid").datagrid('reload');
				            		            		}else{
				            		            			$.messager.alert('错误',data.msg,data.errorcode);
				            		            		}
				            		            	}
				                  				});
				                  			}
			                  			});
			                  	}}
		                 ],
		                 </c:if>
				fitColumns : true,
				idField:'ID',
				pagination:false,
				fit:true
	    };
		$.lauvan.dataGrid("preschOrgGrid",attrArray);
		$.fn.zTree.init($("#preschOrgTree"), setting_preschOrg, zNodes_preschOrg);
		zTree_preschOrg = $.fn.zTree.getZTreeObj('preschOrgTree');
		zTree_preschOrg.selectNode(zTree_preschOrg.getNodeByParam("id", '${apId}', null));
	});
	function orgperSave(){
		var orgper = $("#orgperSelect2").datalist("getData");
		var rows = orgper.rows;
		if(rows){
			var orgperid="";
			var orgpername="";
			for(var i=0;i<rows.length;i++){
				if(i==0){
					orgperid=rows[i].ID;
					orgpername=rows[i].SMSNAME;
				}else{
					orgperid=orgperid+","+rows[i].ID;
					orgpername=orgpername+","+rows[i].SMSNAME;
				}
			}
    		$("#_planorganid").val(orgperid);
    		$("#_planorganname").textbox('setValue',orgpername);
    		$("#_planOrgperDialog").dialog('close');
    		$('#orgperform').form('submit', {   
    		onSubmit: function(param){    
    			 param.organid = orgperid;    
    		     param.organname = orgpername;   
    	    },    
    	    success:function(data){ 
				$.lauvan.reflash(data);    
    	    }}); 
		}else{
    		alert("请选择应急机构/人员！");
		}
	}
	function option(value,row,index){
		var tel=row.WORKNUM;
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=\"calltel('"+tel+"')\">拨打电话</a></li></ul>";
	return act;	
	}
	function calltel(tel){
		$.messager.confirm('拨号',"您确定拨打电话【"+tel+"】？",function(r){
			
		});
	}
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 200px;">
		<ul id="preschOrgTree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',border:false">
	<input type="hidden" id="_preschOrgPid" />
	<input type="hidden" id="_preschOrgPname" />
		<table id="preschOrgGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					            <th field="ADD_NAME" width="150">名称</th> 
					            <th field="POSITION_NAME" width="100"  >岗位</th>
					            <th field="ADDRESS" width="150"  >地址</th>
					            <th field="WORKNUM" width="100"  >办公电话</th>
					            <th field="TELPHONE" width="100" >手机</th>
					            <th field="HOMENUM" width="100" >住址电话</th>
					            <th field="FAX" width="100" >传真</th>
					            <th field="OPTION" formatter="option" width="200">操作</th> 
					        </tr> 
					    </thead> 
		</table>
	</div>
</div>	
	
	 
	
