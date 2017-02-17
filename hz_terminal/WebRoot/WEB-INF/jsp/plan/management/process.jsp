<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
	var zTree_preschPro;
	var setting_preschPro = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschPro
		},
		async: {
			enable: true,
			url: "Main/planMg/getProcessTreeData?preid=${preschid}",
			autoParam:["id","level"],
			dataFilter: function(treeId, parentNode, responseData){
				var tdata =[];
			   	if (responseData) {
			   		var tlist = responseData;
			   	    for(var i =0; i < tlist.length; i++) {
			   	    	var data={};
			   	        data.id = tlist[i]['ID'];
			   	        data.pid = tlist[i]['PID'];
			   	        data.name = tlist[i]['PROCESSNAME'];
			   	        data.isParent=tlist[i]['ISLEAF']==0?false:true;
			   	        tdata.push(data);
			   	     }
			   	 }
			   	 return tdata;
			}
		}
	};
	
	var zNodes_preschPro =[
	     		{ id:"0", pId:"0", name:"应急处置",open:true}
	     		<c:forEach items="${plist}" var="phase" >
	     		,{ id:"p_${phase.phaseid}", pid:"${empty phase.pid||phase.fatherid==0?0:phase.pid}", name:"${phase.phasename}"}
	     		</c:forEach>
	     		<c:forEach items="${alist}" var="alist" >
	     		,{ id:"${alist.actid}", pid:"${alist.pid}", name:"${alist.actname}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschPro(event, treeId, treeNode) {
		if(treeNode.id!=0 && treeNode.id.indexOf("p_")<0){
			$('#preschProGrid').datagrid("showColumn",'ACTLINKERMAN');
			$('#preschProGrid').datagrid("showColumn",'ACTLINKERTEL');
			$('#preschProGrid').datagrid("hideColumn",'SEQ');
		}else{
			$('#preschProGrid').datagrid("hideColumn",'ACTLINKERMAN');
			$('#preschProGrid').datagrid("hideColumn",'ACTLINKERTEL');
			$('#preschProGrid').datagrid("showColumn",'SEQ');
		}
		$('#_preschProcessid').val(treeNode.id);
		$('#_preschProcesspid').val(treeNode.pid);
		$('#preschProGrid').datagrid({url:'<%=basePath%>Main/planMg/getProcessData/${preschid}-'+treeNode.id+'-'+treeNode.level});
	};
	$(document).ready(function(){
		var attrArray={
				<c:if test="${empty flag&&xgflag}">
				toolbar: [
		                  { text: '添加',title:'添加应急处置信息', iconCls: 'icon-add',
		                	  handler: function(){
	                	  		var pid = $("#_preschProcesspid").val();
	                	  		var id = $("#_preschProcessid").val();
	                	  		if(id==""){
	            					$.messager.alert('错误','请先选择节点！','error');
	            	                return false;	
	            				}
	                	  		var title = "添加应急处置阶段信息";
	                	  		var flag = 0;
	                	  		if(pid==0 && id!=0){
	                	  			title = "添加应急处置流程信息";
	                	  			flag = 1;
	                	  		}else if(id.indexOf("p_")>=0){
	                	  			title = "添加应急处置行动信息";
	                	  			flag = 2;
	                	  		}else if(id.indexOf("p_")<0 && pid.indexOf("p_")>=0){
	                	  			title = "添加应急处置执行部门信息";
	                	  			flag = 3;
	                	  		}
	                	  		var dialogDef={
	                	  				title:title,
										width:700,
										height:400,
										href: '<%=basePath%>Main/planMg/add/pprocess-'+id+"-${preschid}-"+flag
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
	                  		}}, '-', 
		                  { text: '修改',title:'编辑应急处置信息',iconCls: 'icon-pageedit',
	                  			handler: function(){
	                	  		var row=$("#preschProGrid").datagrid("getSelected");
	            				if(!row){
	            					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
	            					return;
	            				}
	            				var title = "编辑应急处置阶段信息";
	            				var flag = 0;
	                	  		if(row.PROCESSTYPE==1){
	                	  			title = "编辑应急处置流程信息";
	                	  			flag = 1;
	                	  		}else if(row.PROCESSTYPE==2){
	                	  			title = "编辑应急处置行动信息";
	                	  			flag = 2;
	                	  		}else if(row.PROCESSTYPE==3){
	                	  			title = "编辑应急处置执行部门信息";
	                	  			flag = 3;
	                	  		}
	                	  		var dialogDef={
	                	  				title:title,
										width:700,
										height:400,
										href: '<%=basePath%>Main/planMg/edit/pprocess-'+row.ID+"-"+flag
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
	                  		}}, '-',
		                  { text: '删除',iconCls: 'icon-delete',
	                  			handler: function(){
		                  		var rows=$("#preschProGrid").datagrid('getChecked');
		                  		if(rows.length==0){
		            				$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
		            				return;
		            			}
	                  			$.messager.confirm('删除',"您确定删除该信息？",function(r){
		                  			if(r){
		                  				var ids=[];
		                  				var flag =0;
		                  				var pid = 0;
		            			        for(var i=0;i<rows.length;i++){
		            						ids[i]=rows[i].ID;
		            						flag = rows[i].PROCESSTYPE;
		            						pid = rows[i].PID;
		            					}
		                  				$.ajax({
		            		            	url:'<%=basePath%>Main/planMg/delete/pprocess',
		            		            	type:'post',
		            		            	dataType:'json',
		            		            	traditional:true,
		            		            	data:{'preid':'${preschid}','groupid':pid,'ids':ids,'flag':flag},
		            		            	success:function(data){
		            		            		if(data.success){
		            		            			$.lauvan.MsgShow({msg:'数据删除成功'});
		            		            			$("#preschProGrid").datagrid('clearSelections');
		            		            			$("#preschProGrid").datagrid('clearChecked');
		            		            			$("#preschProGrid").datagrid('reload');
		            		            			//刷新树
		    		            					var treeObj =  $.fn.zTree.getZTreeObj("preschProTree");
		    		            					if(data.reloadid!=null && ""!=data.reloadid && "null"!=obj.reloadid){
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
	                  	}}
		                 ],
		                 </c:if>
				fitColumns : true,
				idField:'ID',
				fit:true,
				onLoadSuccess:function(data){
				$("#preschProGrid").datagrid('clearSelections');
				$("#preschProGrid").datagrid('clearChecked');
			}
	    };
		$.lauvan.dataGrid("preschProGrid",attrArray);
		$.fn.zTree.init($("#preschProTree"), setting_preschPro, zNodes_preschPro);
		zTree_preschPro = $.fn.zTree.getZTreeObj('preschProTree');
	});
	function phaseTypeFN(value,row,index){
		if(value=='0'){
			return '行动阶段';
		}else if(value=='1'){
			return '行动流程';
		}else if(value=='2'){
			return '行动';
		}else if(value=='3'){
			return '执行部门';
		}else{
			return value;
		}
	}
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 200px;">
		<ul id="preschProTree" class="ztree"></ul>
	</div>
	<input type="hidden" id="_preschProcessid"/>
	<input type="hidden" id="_preschProcesspid"/>
	<div data-options="region:'center',border:false">
		<table id="preschProGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					        	<th field="PROCESSTYPE" width="100" formatter="phaseTypeFN">类型</th>
					            <th field="PROCESSNAME" width="100">名称</th>
					            <th field="ACTLINKERMAN" width="100"  hidden="true">联系人</th>
					            <th field="ACTLINKERTEL" width="100"  hidden="true">联系电话</th> 
					            <th field="PCONTENT" width="150"  >说明</th>
					            <th field="SEQ" width="80"  >执行顺序</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
</div>	
	
	 
	
