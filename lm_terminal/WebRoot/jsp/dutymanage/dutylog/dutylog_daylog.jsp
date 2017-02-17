<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="margin-bottom: 15px;">
	<form class="form-inline" action="dutymanage/dutylog/daylog" method="post">
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
		<div class="form-group">
			<label for="duty_date">值班日期</label>
			<input type="text" id="duty_date" name="duty_date" class="form-control" placeholder="值班日期"
				value="${dutyLogVo.duty_date_str}">
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
		<th>值班日期</th>
		<th>事件</th>
		<th>操作</th>
	</tr>
	<tbody id="sms_data">
		<c:forEach var="vo" items="${pageView.records}">
			<tr>
				<td>${vo.pe_name}</td>
				<td>${vo.or_name}</td>
				<td>${vo.pe_mobilephone}</td>
				<td>${vo.duty_date_str}</td>
				<td>${vo.ev_name}</td>
				<td>
					<button type="button" class="btn btn-primary"
						onclick="promptCallView('${vo.pe_id}', '${vo.ev_id}', '${vo.duty_date_str}');">通话记录</button>
					<button type="button" class="btn btn-primary"
						onclick="promptSmsView('${vo.pe_id}', '${vo.ev_id}', '${vo.duty_date_str}');">短信记录</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	<tr>
		<th scope="col" colspan="6"><jsp:include page="/include/fenye2.jsp" /></th>
	</tr>
</table>
<script type="text/javascript">
	$(function() {
	    $('#duty_date').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        startView : 2,
	        minView : 2,
	        autoclose : true
	    });
    });
    
    function promptCallView(pe_id, ev_id, call_date_str) {
	    parent.layer.open({
	        type : 2,
	        title : '通话记录',
	        area : ['800px', '640px'],
	        scrollbar : false,
	        content : ['dutymanage/dutylog/callview/' + pe_id + '/' + ev_id + '/' + call_date_str + '/-1', 'no'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }

    function promptSmsView(pe_id, ev_id, sms_date_str) {
	    parent.layer.open({
	        type : 2,
	        title : '通话记录',
	        area : ['800px', '640px'],
	        scrollbar : false,
	        content : ['dutymanage/dutylog/smsview/' + pe_id + '/' + ev_id + '/' + sms_date_str + '/-1', 'no'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }
</script>