<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>岗位分类</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<div class="col-sm-3">
		<div id="organ_treeview">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		<div id="page-wrapper" class="col-sm-9" style="padding-left: 0px;">
		<input type="hidden" id="pid" value="${pid}"/>
		<input type="hidden" id="poid" name="poid">
		<table class="table table-bordered"> 
			<tr id="trid">
				<th>岗位名称</th>
				<th>操作</th>
			</tr>
			<tbody id="position_data">
			
			</tbody>
		</table>
		</div>
</div>
</div>
<script type="text/javascript">
var i=1;
do
{
	var checkid = parent.window.frames[i].positionids;
	var checkname = parent.window.frames[i].ponames;
	i++;
	}
while (checkid==undefined);

var setting = {
		data: {
			simpleData: {
				enable: true // 使用simpleData
			}
		},
		callback: {
			onClick: zTreeOnClick//回调函数
		}
};

$(function(){
	$.post('work/positionclassification/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
	});
});


function zTreeOnClick(event, treeId, treeNode, clickFlag) {
	$("#pid").val(treeNode.id);
	$.post('work/position/list', {id:treeNode.id}, function(j) {
		datas2(j);
	});
	
}

function datas2(j){
	//console.info(parent.window.frames[1].poids);
	$("#position_data").empty();
	var str = '';
	for(var i=0;i<j.length;i++){
		str +="<tr>";
		str +="<td>"+j[i].p_name+"</td>";
		str +="<td ><input class='cb' id='"+j[i].p_id+"' type='checkbox' name='selectPositions' value='"+j[i].p_name+"' onclick='tocheck(this)'/></td>";
		str +="</tr>";
	}
	$("#position_data").append(str);
	updatecheckbox();
}

function tocheck(cb){
	for(var i = 0; i<=checkid.length; i++){
		if(checkid[i]==$(cb).attr('id')){
			if(!$(cb).is(':checked')){
				checkid.splice(i,1);
				checkname.splice(i,1);
				break;
			}
		}else{
			if($(cb).is(':checked')){
				checkid.push($(cb).attr('id'));
				checkname.push(cb.value);
				break;
			}
		}
	}
}

function updatecheckbox(){
	for(var y = 0;y < checkid.length; y++) {
		$.each($('.cb'), function(i, c) {
			if(checkid[y]==$(c).attr('id')){
				$(c).prop('checked', true);
			}
		})
	}
}

function select_position(index, window){
	window.$("#po_id").val(checkid.join(','));
	window.$("#po_name").val(checkname.join(','));
	var person_addform = window.$('#person_addform');
	var person_editform = window.$('#person_editform');
	/* if(person_addform.length> 0){
		window.$('#person_addform').data('bootstrapValidator').updateStatus('po_name', 'NOT_VALIDATED', null);
	}
	if(person_editform.length> 0){
		window.$('#person_editform').data('bootstrapValidator').updateStatus('po_name', 'NOT_VALIDATED', null);
	}	 */
	parent.layer.close(index);
}
/**
 * 数组去重
 */
function unique(arr) {
    var result = [], hash = {};
    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
        if (!hash[elem]) {
            result.push(elem);
            hash[elem] = true;
        }
    }
    return result;
}
</script>
</body>
</html>