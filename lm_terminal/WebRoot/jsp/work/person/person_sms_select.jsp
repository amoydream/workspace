<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>机构人员管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="person_treeview" style="overflow:scroll; height:390px; OVERFLOW-X:hidden;">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		<input type="hidden" id="or_id"/>
		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>手机</th>
				<th>操作<input type="checkbox" id="checkAll" title="全选或全部取消" onclick="checkAll(this);"/></th>
				
			</tr>
			<tbody id="person_data">
			
			</tbody>
		</table>
		</div>
</div></div>
<script type="text/javascript">

function checkAll(obj){
    $("#person_data input[type='checkbox']").prop('checked', $(obj).prop('checked'));
}

var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
};

$(function(){
	$.post('work/organ/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getNodes();
        treeObj.expandNode(nodes[0], true);
	});
	
});

function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('work/person/list', {orId:treeNode.id}, function(j) {
		datas(j);
	});
}

function datas(j){
	$("#person_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr>";
		str +="<td>"+j[i].pe_name+"</td>";
		if(j[i].mobilephone==undefined){
			str +="<td></td>";
		}else{
			str +="<td>"+j[i].mobilephone+"</td>";
		}
		str +="<td><input type='checkbox' name='selectPersons' value='"+j[i].pe_name+","+j[i].mobilephone+"'/></td>";
		str +="</tr>";
	}
	$("#person_data").append(str);
}
function postChild(id){
	$.post('system/personinfo/list', {id:id}, function(j) {
		datas(j);
	});
}

function select_person(index,window){
	var spps = $("input[name='selectPersons']:checked");
	for(var i=0,h=spps.length;i<h;i++){
		var vv = spps[i].value;
		var vs = vv.split(",");
		
		window.$('#tagsinput').tagsinput('add', {
	        value : vs[1],
	        text : vs[0]
	    });
	}
	parent.parent.parent.layer.close(index);
	/* var str = '',su_Ids=[],flag = false,m=0;
	for(var i=0,h=spps.length;i<h;i++){
		var vv = spps[i].value;
		var vs = vv.split(",");
		
		for(var j=0,h1=ids.length;j<h1;j++){
			if(vs[0] == ids[j].value){
				flag = true;
				break;
			}
		}
		if(flag){
			flag = false;
			continue;
		}
		
		str += "<tr>";
		str += "<td>"+vs[1]+"</td>";
		if(vs[2]!='undefined'){
			str += "<td>"+vs[2]+"</td>";
		}else{
			str += "<td></td>";
		}
		
		str +="<td><button type='button' class='btn btn-danger btn-sm' onclick='person_delete("+vs[0]+");'>删除</button></td>";
		
		str += "</tr>";
		su_Ids[m]=vs[0];
		m++;
	}
	if(su_Ids.length>0){
		$.post('emeplan/planOrgan/addPerson', {pi_id:pi_id,pe_Ids:su_Ids.join(','),pid:pid}, function(j) {
			if(j.success){
				window.$("#organPerson_data").append(str);
				window.postChild(pid);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.parent.parent.layer.close(index1);
			parent.parent.parent.layer.close(index);
		});
	}else{
		parent.parent.parent.layer.close(index1);
		parent.parent.parent.layer.close(index);
	} */
}
</script>
</body>
</html>