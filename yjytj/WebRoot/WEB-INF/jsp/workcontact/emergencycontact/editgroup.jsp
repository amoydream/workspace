<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>

  var flagForDeptAdd=true;
	window.setTimeout(function(){
	  		$("#uaccount").next("span").children("input").eq(0).bind("blur",judgeAccount);
	  	},1000); 	
  
	function onSubmit(){
		$('#form1').form('submit',{
			onSubmit:function(){
				return $(this).form('enableValidation').form('validate') && flagForDeptAdd;
			},
			success:function(data){
				var result=$.parseJSON(data);
				if(result.success){
					$('#editGroupDialog').dialog('close');
					var treeObj = $.fn.zTree.getZTreeObj("customTree");
					var node = treeObj.getNodeByParam("id", result.e_id, null);
					node.name = result.e_name;
					 // 更新根节点中第i个节点的名称	        
			        treeObj.updateNode(node);
			        refreshEmergencyGrid();
				}
			}
		});
	}

  </script>
	 
	 <form id="form1" method="post" action="<%=basePath %>Main/emergencycontact/save" style="width:100%;">
	    <input type="hidden" name="act" value="update"/>
	    <input type="hidden" name="t_Bus_EmergencyContact.e_id" value="${e.e_id }"/>
	    <table  id="table"  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">分组名称</td>
		    	<td >
		    	<input type="text" name="t_Bus_EmergencyContact.e_name"  class="easyui-textbox" style="width:180px;" value="${e.e_name }"/></td>
		    	</tr>	    		 	    			 		    		 
	    </table>
    </form>
