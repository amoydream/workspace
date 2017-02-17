<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form id="eventProcessForm" action="event/eventproc/notify" method="post">
	<input type="hidden" name="ev_id" value="${eventInfoVo.ev_id}">
	<label for="rp_content">汇报内容</label>
	<p>
		<textarea rows="6" id="rp_content" name="rp_content" class="form-control" placeholder="汇报内容">
事件名称：${eventInfoVo.ev_name}
事发时间：${eventInfoVo.ev_date}
事发地点：${eventInfoVo.ev_address}
事件类型：${eventInfoVo.et_name}
事件内容：${eventInfoVo.ev_name}
		</textarea>
	</p>
	<label for="pr_content">处置反馈</label>
	<p>
		<textarea rows="6" id="pr_content" name="pr_content" class="form-control" placeholder="处置反馈"></textarea>
	</p>
</form>