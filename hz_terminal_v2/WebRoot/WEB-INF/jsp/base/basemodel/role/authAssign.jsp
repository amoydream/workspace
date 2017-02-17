<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<div id="toolbar">
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-accept',plain:true,onClick:checkAll" >全选</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-anchor',plain:true,onClick:checkAllNo" >反选</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:checkKey,value:'增加'">选择所有增加</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:checkKey,value:'修改'" >选择所有修改</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true,onClick:checkKey,value:'删除'">选择所有删除</a>
</div>
<table id="treegrid" class="easyui-treegrid" style="width:100%;"
			data-options="
				url:'<%=basePath %>Main/role/getTreeGridData',
				method:'get',
				rownumbers: true,
				idField: 'id',
				treeField: 'name',
				toolbar:'#toolbar',
				onLoadSuccess:loadSuccess
			">
		<thead>
			<tr>
				<th data-options="field:'name'" width="40%">菜单</th>
				<th data-options="field:'funName',formatter:formatFun" width="58%" >功能</th>
			</tr>
		</thead>
	</table>
<script>

//alert(Math.ceil(17/9));

function formatFun(value,row,field){
	if (value) {
        var names = value.split(",");
        var ids = row['funId'].split(",");
        var s = "";
        for (i = 0; i < names.length; i++) {
            if(i==10 && names.length>10){
            	s +="</br>";
            }
            s += '<label><input type="checkbox" id="'+ ids[i] +'" value="' + ids[i] + '" name="funBtn" parentId="'+row['id']+'" fun="'+ names[i] +'">' + names[i] + '</label>&nbsp;&nbsp;&nbsp;';
        }
    }
    return s;
}

function loadSuccess(){
	var menuId="${role.OPT_PERMISSIONS}".split(',');
	var excludeFunId="${role.NO_PERMISSIONS}".split(',');
	
	for(var index in menuId){
		var list=$("input:checkbox[parentId='"+menuId[index]+"']");
		for(var l in list){
			var flag=false;
			for(var i in excludeFunId){
				if(list[l].id==excludeFunId[i]){
					flag=true;
					break;
				}
			}	
			if(!flag)
				list[l].checked=true;
		}
	}
}

function checkAll(){
	$("input:checkbox[name='funBtn']").each(function(){
		this.checked=true;
	});
}

function checkAllNo(){
	$("input:checkbox[name='funBtn']").each(function(){
		this.checked=!this.checked;
	});
}

function checkKey(){
	var options=$(this).linkbutton("options");
	var key=options.value;
	var text=options.text;
	var chooseWord="选择";
	var cancelWord="取消";
	var resultWord=text;
	if(key=='增加'){
		$("input:checkbox[fun*='新增']").each(function(){
			if(text.indexOf(chooseWord)!=-1){
				this.checked=true;
				resultWord=resultWord.replace(chooseWord,cancelWord);
			}
			else{
				this.checked=false;
				resultWord=resultWord.replace(cancelWord,chooseWord);
			}
		});
		$("input:checkbox[fun*='增加']").each(function(){
			if(text.indexOf(chooseWord)!=-1){
				this.checked=true;
				resultWord=resultWord.replace(chooseWord,cancelWord);
			}
			else{
				this.checked=false;
				resultWord=resultWord.replace(cancelWord,chooseWord);
			}
		});
		$("input:checkbox[fun*='添加']").each(function(){
			if(text.indexOf(chooseWord)!=-1){
				this.checked=true;
				resultWord=resultWord.replace(chooseWord,cancelWord);
			}
			else{
				this.checked=false;
				resultWord=resultWord.replace(cancelWord,chooseWord);
			}
		});
	}else{
		$("input:checkbox[fun*='"+key+"']").each(function(){
			if(text.indexOf(chooseWord)!=-1){
				this.checked=true;
				resultWord=resultWord.replace(chooseWord,cancelWord);
			}
			else{
				this.checked=false;
				resultWord=resultWord.replace(cancelWord,chooseWord);
			}
		});
	}
	$(this).linkbutton({text:resultWord});
}

function onSubmit($dialog){

	var menuId=[];
	var excludeFunId=[];
	$("input[name='funBtn']:checked").each(function(){
		var parentId=$(this).attr("parentId");
		var parentNode=$("#treegrid").treegrid('find',parentId);
		while(parentNode)
		{
			parentId=parentNode.id;
			if(menuId.indexOf(parentId)==-1){
				menuId.push(parentId);
			}
			parentNode=$("#treegrid").treegrid('getParent',parentId);
		}
	});
	
	for(var index in menuId){
		$("input:checkbox[parentId='"+menuId[index]+"']").each(function(){
			if(!this.checked)
				excludeFunId.push(this.id);
		});
	}
	
	var url = "<%=basePath%>Main/role/authoritySave";
	var o ={'roleId':'${role.role_id }','menuId': menuId.join(','),'excludeFunId':excludeFunId.join(',')};
	$.post(url, o, function(result) {
		if (result.success) {
			$.messager.show({title:'提示',msg:'保存成功！',timeout:1000,showType:'fade',style:{right:'',bottom:''}});
			$dialog.dialog('close');
		} else {
			$.messager.alert('提示', result.msg, 'error');
		}
	}, 'json');
}
</script>
	