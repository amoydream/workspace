<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<div id="toolbar">
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-accept',plain:true,onClick:checkAll" >全选</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-anchor',plain:true,onClick:checkAllNo" >反选</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:checkRowAll">单行全选</a>
</div>
<table id="treegrid" class="easyui-treegrid" style="width:100%;"
			data-options="
				url:'<%=basePath %>Main/department/getComboTree',
				method:'get',
				rownumbers: true,
				idField: 'id',
				treeField: 'text',
				toolbar:'#toolbar',
				nowrap:false,
				onLoadSuccess:loadSuccess
			">
		<thead>
			<tr>
				<th data-options="field:'text'" width="40%">组织机构</th>
				<th data-options="field:'id',formatter:formatUser" width="58%" >用户</th>
			</tr>
		</thead>
	</table>
<script>

var userList=${userList};

var colCount=9;

function formatUser(value,row,field){
	var s="";
	if (value) {
		var list=[];

		for(var i in userList){
			if(value==userList[i].DEPT_ID)
				list.push(userList[i]);
			}
		/*var table=$('<table></table>');
		var row=Math.ceil(list.length/colCount);

		for(var i=0;i<row;i++){
			var tr=$("<tr>");
			for(var j=0;j<colCount;j++){
				var data=list[i*colCount+j];
				var td=$('<td style="border:none;"></td>');
				if(data){
					td.html('<label style="font-size:12px"><input type="checkbox" id="'+ data.USER_ID +'" value="' + data.USER_NAME + '" name="userBox" deptId="'+value+'" >' + data.USER_NAME + '</label>&nbsp;&nbsp;&nbsp;');
				}
				tr.append(td);
			}
		}
		table.append(tr);
		return table[0].outerHTML;*/
		for (i = 0; i < list.length; i++) {
            if(i==10 && list.length>10){
            	s +="</br>";
            }
            var data=list[i];
            s += '<label style="font-size:12px"><input type="checkbox" id="'+ data.USER_ID +'" value="' + data.USER_NAME + '" name="userBox" deptId="'+value+'" >' + data.USER_NAME + '</label>&nbsp;&nbsp;&nbsp;';
        }
    }
    return s;
}

function loadSuccess(){
	var userIdsList="${userIds}".split(',');
	for(var i in userIdsList){
		$("#"+userIdsList[i]).attr("checked",true);
	}
}


function checkAll(){
	$("input:checkbox[name='userBox']").each(function(){
		this.checked=true;
	});
}

function checkAllNo(){
	$("input:checkbox[name='userBox']").each(function(){
		this.checked=!this.checked;
	});
}

function checkRowAll(){
	var list=$("#treegrid").treegrid("getSelections");
	if(list.length>0){
		$("input:checkbox[deptId='"+list[0].id+"']").each(function(){
			this.checked=true;
		});
	}
}

function onSubmit($dialog){

	var userIdList=[];
	$("input:checkbox[name='userBox']:checked").each(function(){
		userIdList.push(this.id);
	});
	
	 $.ajax({
     	url:'<%=basePath%>Main/role/userAssignSave',
     	type:'post',
     	dataType:'json',
     	traditional:true,
     	data:{'roleId':'${role.role_id }','idList': userIdList},
     	success:function(data){
     		if(data.success){
     			$.messager.show({title:'提示',msg:'保存成功！',timeout:1000,showType:'fade',style:{right:'',bottom:''}});
    			$dialog.dialog('close');
     		}
     		else{
     			$.messager.alert('提示', data.msg, 'error');
     		}
     	}
     });
}
</script>
	