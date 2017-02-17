<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
    
  	function onSubmit($dialog){
  		$('#form1').form('submit',{
  			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(data){
			 var result=$.parseJSON(data);
				if(result.success){
					var treeObj = $.fn.zTree.getZTreeObj("customTree");
					var childZNode = new ZtreeNode(result.e_id, zTreeEmergency.getSelectedNodes()[0].id, result.e_name); //构造子节点  
				    var parentZNode = treeObj.getNodeByParam("id",zTreeEmergency.getSelectedNodes()[0].id, null);
					//添加到新节点到父节点
					treeObj.addNodes(parentZNode, childZNode, true);
					treeObj.updateNode(parentZNode);
					$("#addGroupDialog").dialog('close');
					refreshEmergencyGrid();
				}
			}
		});
  	}
    
  	function ZtreeNode(id, pId, name) {//定义ztree的节点类  
	      this.id = id;
	      this.pId = pId;
	      this.name = name;
	  }
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath %>Main/emergencycontact/save" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Bus_EmergencyContact.e_pid" value="${pid }"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">分组名称</td>
		    	<td >
		    	<input type="text" name="t_Bus_EmergencyContact.e_name" data-options="prompt:'请输入分组名称',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/></td>
		    	</tr>	
	    </table>
    </form>
