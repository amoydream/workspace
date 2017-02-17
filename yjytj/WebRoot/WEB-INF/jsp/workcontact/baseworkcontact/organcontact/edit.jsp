<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>   
  	function onSubmit(){
  		$('#form1').form('submit',{
  			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(data){
				var result=$.parseJSON(data);
				if(result.success){
					$('#editDialog').dialog('close');
					var treeObj = $.fn.zTree.getZTreeObj("organcontactTree");
					var node = treeObj.getNodeByParam("id", result.or_id, null);
					node.name = result.or_name;
					 // 更新根节点中第i个节点的名称	        
			        treeObj.updateNode(node);
					refreshGrid();
				}
			}
		});
  	}
  	
  	$(function() {
        var html = '<option id="0" value="0">---选择排序---</option>';
        for(var i = 1; i < 101; i++) {
	        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
        }
        document.getElementById('or_sort').innerHTML = html;
    }); 

  </script>
	 <form id="form1" method="post" action="<%=basePath %>Main/organcontact/save" style="width:100%;">
	    <input type="hidden" name="act" value="update"/>
	    <input type="hidden" name="t_Bus_Organ.or_id" value="${organ.or_id }"/>
	    <input type="hidden" name="t_Bus_Organ.or_pid" value="${organ.or_pid }"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">	          	
		    	<tr>
		    	<td class="sp-td1">机构名称</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_name"  data-options="prompt:'请输入机构名称',required:true,icons:iconClear"
		    	class="easyui-textbox" style="width:260px;" value="${organ.or_name }"/></td>
		    	</tr>	    
		    	<tr>
		  		<td class="sp-td1">办公电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_worknumber" id="or_worknumber" data-options="prompt:'请输入住宅电话号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${organ.or_worknumber }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">传真</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_fax" id="or_fax" data-options="prompt:'请输入传真号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${organ.or_fax }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">Email</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_email" id="or_email" data-options="prompt:'请输入邮箱号',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${organ.or_email }"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">地址</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_address" id="or_address" data-options="prompt:'请输入地址',icons:iconClear" 
		    	class="easyui-textbox" style="width:260px;" value="${organ.or_address }"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">排序</td>
		    	<td >
		    	    <select class="easyui-combobox" id="or_sort" name="t_Bus_Organ.or_sort" data-options="value:'${organ.or_sort }'" style="width: 260px;">					
					</select>
		    	</td>
		    	</tr>		    			 		    		 
	    </table>
    </form>
