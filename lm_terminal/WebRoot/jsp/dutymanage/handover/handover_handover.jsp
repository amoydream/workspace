<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-bordered">
	<tr>
		<th>交班人</th>
		<th>接班人</th>
		<th>交班时间</th>
		<th>接班时间</th>
		<th>备注</th>
		<th>操作</th>
	</tr>
	<tbody id="handover_data"></tbody>
</table>
<script>
$(function() {
	$.post('dutymanage/handover/list',{},function(j){
		datas(j);
	})
})

function datas(j){
		var str= '';
		for(var i=0;i<j.length;i++){
			str += "<tr>";
			str += "<td style='text-align:center'>"+j[i].ha_Handman.pe_name+"</td>";
			str += "<td style='text-align:center'>"+j[i].ha_Takeman.pe_name+"</td>";
			str += "<td style='text-align:center'>"+j[i].ha_Handdate+"</td>";
			str += "<td style='text-align:center'>"+j[i].ha_Takedate+"</td>";
			str += "<td style='text-align:center'>"+j[i].ha_Remark+"</td>";
			str += "<td style='text-align:center'>"
			str += "<a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='detailEdit("+j[i].id+")'>编辑</a>"
			str += "<a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='detailDelete("+j[i].id.st_Id.st_Id+","+j[i].id.di_Id.di_Id+","+j[i].dsCount+")'>删除</a>"
			str += "</td>"
			str += "</tr>";
		}
		$("#handover_data").append(str);
	}
</script>