<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="margin-bottom: 15px;">
	<form class="form-inline" action="dutymanage/dutylog/curmatter" method="post">
		<div class="form-group">
			<label for="pe_name">值班人员</label>
			<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="值班人名称"
				value="${dutyLogVo.pe_name}">
		</div>
		<div class="form-group">
			<label for="ev_name">事件名称</label>
			<input type="text" id="ev_name" name="ev_name" class="form-control" placeholder="事件名称"
				value="${dutyLogVo.ev_name}">
		</div>
		<input type="hidden" name="page" value="${dutyLogVo.page}" />
		<button type="button" class="btn btn-success"
			onclick="this.form.page.value=1; this.form.submit();">搜索</button>
	</form>
</div>
<table class="table table-bordered">
	<tr>
		<th>姓名</th>
		<th>部门</th>
		<th>电话号码</th>
		<th>待办事宜</th>
		<th>操作</th>
	</tr>
	<tbody id="sms_data">
		<c:forEach var="vo" items="${pageView.records}">
			<tr>
				<td>${vo.pe_name}</td>
				<td>${vo.or_name}</td>
				<td>${vo.pe_mobilephone}</td>
				<td>${vo.ev_name}</td>
				<td>
					<button type="button" class="btn btn-primary" onclick="promptViewForm('${vo.duty_sch_id}');">查看</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	<tr>
		<th scope="col" colspan="5"><jsp:include page="/include/fenye2.jsp" /></th>
	</tr>
</table>
<script type="text/javascript">
	function promptViewForm(duty_sch_id) {
	    parent.layer.open({
	        type : 2,
	        title : '查看短信',
	        area : ['600px', '480px'],
	        scrollbar : false,
	        content : ['dutymanage/smsdisp/viewform/' + duty_sch_id, 'no'],
	        btn : ['回复', '取消'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.reply(index, window);
	        }
	    });
    }
</script>