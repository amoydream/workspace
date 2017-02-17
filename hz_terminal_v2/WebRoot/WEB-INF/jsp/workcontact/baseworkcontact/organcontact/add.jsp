<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
  function onSubmit(){
		$('#form1').form('submit',{
  			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			success:function(data){
			 var result=$.parseJSON(data);
				if(result.success){
					var treeObj = $.fn.zTree.getZTreeObj("organcontactTree");
					var childZNode = new ZtreeNode(result.or_id, zTree_Organ.getSelectedNodes()[0].id, result.or_name); //构造子节点  
				    var parentZNode = treeObj.getNodeByParam("id",zTree_Organ.getSelectedNodes()[0].id, null);
					//添加到新节点到父节点
					treeObj.addNodes(parentZNode, childZNode, true);
					$("#addDialog").dialog('close');
					refreshGrid();
				}
			}
		});
	}
     
	  function ZtreeNode(id, pId, name) {//定义ztree的节点类  
	      this.id = id;
	      this.pId = pId;
	      this.name = name;
	  }
  
	$(function() {
        var html = '<option id="0" value="0">---选择排序---</option>';
        for(var i = 1; i < 101; i++) {
	        html += '<option id="' + i + '" value="' + i + '">' + i + '</option>';
        }
        document.getElementById('or_sort').innerHTML = html;
    });  
  
</script>
  
	 <div class="easyui-layout"  data-options="fit:true">
	 <form id="form1" method="post" action="<%=basePath %>Main/organcontact/save" style="width:100%;margin: 0 auto;padding: 0;">
	 
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Bus_Organ.or_pid" value="${pid }"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">机构名称</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_name" 
		    	data-options="prompt:'请输入机构名称',required:true,icons:iconClear" class="easyui-textbox"
		    	style="width: 260px;"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">办公电话</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_worknumber" 
		    	data-options="prompt:'请输入办公电话',icons:iconClear" class="easyui-textbox"
		    	style="width: 260px;"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">传真</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_fax" 
		    	data-options="prompt:'请输入传真号',icons:iconClear" class="easyui-textbox"
		    	style="width: 260px;"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">Email</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_email" 
		    	data-options="prompt:'请输入邮箱',icons:iconClear" class="easyui-textbox"
		    	style="width: 260px;"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">地址</td>
		    	<td >
		    	<input type="text" name="t_Bus_Organ.or_address" 
		    	data-options="prompt:'请输入地址',icons:iconClear" class="easyui-textbox"
		    	style="width: 260px;"/></td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">排序</td>
		    	<td>
		    	    <select class="easyui-combobox" id="or_sort" name="t_Bus_Organ.or_sort" data-options="value:'${organ.or_sort }'" style="width: 260px;">					
					</select>
		    	</td>
		    	</tr>				   		 
	    </table>
	   
    </form>
</div>