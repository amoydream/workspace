<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="eventinfo_editform" class="form-horizontal" role="form">
	<input type="hidden" name="ev_id" value="${eventInfo.ev_id }" />
	<input type="hidden" name="ev_status" value="${eventInfo.ev_status }" />
	<fieldset>
		<p>
		<div class="form-group">
			<label class="col-sm-1 control-label">事件名称</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_name" name="ev_name" value="${eventInfo.ev_name}"
						type="text" placeholder="输入事件名称" data-bv-trigger="keyup" required="required" />
				</div>
			</div>
			<label class="col-sm-1 control-label" for="eventTypeName">事件类型</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input type="hidden" id="eventTypeid" name="eventTypeId" value="${eventInfo.eventType.et_id }" />
					<input class="form-control" id="eventTypeName" name="eventTypeName"
						value="${eventInfo.eventType.et_name }" type="text" placeholder="输入事件类型"
						data-bv-trigger="keyup" required="required" onclick="select_eventType();" />
				</div>
			</div>
			<label class="col-sm-1 control-label" for="ev_level">事件级别</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<select class="form-control" id="ev_level" name="ev_level" value="${eventInfo.ev_level }"
						placeholder="输入事件级别">
						<option value="1" <c:if test="${eventInfo.ev_level=='1' }">selected="selected"</c:if>>Ⅰ级事件(特别重大)</option>
						<option value="2" <c:if test="${eventInfo.ev_level=='2' }">selected="selected"</c:if>>Ⅱ级事件(重大)</option>
						<option value="3" <c:if test="${eventInfo.ev_level=='3' }">selected="selected"</c:if>>Ⅲ级事件(较大)</option>
						<option value="4" <c:if test="${eventInfo.ev_level=='4' }">selected="selected"</c:if>>Ⅳ级事件(一般)</option>
						<option value="5" <c:if test="${eventInfo.ev_level=='5' }">selected="selected"</c:if>>Ⅳ级以下事件</option>
					</select>
				</div>
			</div>
		</div>
		</p>
		<p>
		<div class="form-group">
			<label class="col-sm-1 control-label" for="ev_affectedArea">受灾面积(㎡)</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_affectedArea"
						value="${eventInfo.ev_affectedArea }" />
				</div>
			</div>
			<label class="col-sm-1 control-label" for="ev_participationNumber">参与（受灾）人数</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_participationNumber" name="ev_participationNumber"
						value="${eventInfo.ev_participationNumber }" type="text" placeholder="输入事件级别" />
				</div>
			</div>
			<label class="col-sm-1 control-label" for="ev_injuredPeople">受伤人数</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_injuredPeople" name="ev_injuredPeople"
						value="${eventInfo.ev_injuredPeople }" type="text" placeholder="输入受伤人数" />
				</div>
			</div>
		</div>
		</p>
		<%-- <p>
		<div class="form-group">
			<label class="col-sm-1 control-label" for="ev_deathToll">死亡人数</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" type="text" name="ev_deathToll" value="${eventInfo.ev_deathToll }"
						placeholder="输入死亡人数" />
				</div>
			</div>
			<label class="col-sm-1 control-label" for="ev_economicLoss">经济损失(万元)</label>
			<div class="col-sm-3 input-message">
				<div class='input-group'>
					<input class="form-control" id="ev_economicLoss" name="ev_economicLoss"
						value="${eventInfo.ev_economicLoss }" type="text" placeholder="输入经济损失(万元)" />
				</div>
			</div>
		</div>
		</p> --%>
		<p>
		<div class="form-group">
			<div class="col-sm-12 input-message">
				<input type="radio" name="radio_level" value="">
				Ⅳ级：局部地区24小时降雨量超过100毫米，低于150毫米；江河水位超过警戒水位
				<br>
				<input type="radio" name="radio_level" value="">
				Ⅲ级：局部地区24小时降雨量超过150毫米，低于200毫米；或6小时内降雨量超过100毫米
				<br>
				<input type="radio" name="radio_level" value="">
				Ⅱ级：较大地区24小时降雨量超过200毫米，低于250毫米；或6小时内降雨量超过150毫米
				<br>
				<input type="radio" checked="checked" name="radio_level" value="">
				Ⅰ级：较大地区24小时降雨量超过250毫米；或6小时内降雨量超过200毫米
			</div>
		</div>
		</p>
	</fieldset>
</form>
<div style="margin-top: 15px;">
	<form id="planInfoSearchForm" class="form-inline"
		action="event/eventproc/searchplan/${eventInfo.ev_id}" method="post">
		<div class="form-group">
			<label for="pi_name">预案名称</label>
			<input type="text" id="pi_name" name="pi_name" class="form-control" placeholder="预案名称"
				value="${planInfoVo.pi_name}">
		</div>
		<div class="form-group">
			<label for="et_name">所属事件类型</label>
			<input type="tel" id="et_name" name="et_name" class="form-control" placeholder="所属事件类型" value="">
		</div>
		<input type="hidden" name="page" value="${planInfoVo.page}" />
		<button type="button" class="btn btn-success"
			onclick="this.form.page.value=1; this.form.submit();">搜索</button>
	</form>
</div>
<p>
<table class="table table-bordered">
	<tr>
		<th>名称</th>
		<th>类别</th>
		<th>发布日期</th>
		<th>操作</th>
	</tr>
	<tbody id="tel_history_data">
		<c:forEach var="planInfo" items="${pageView.records}">
			<tr>
				<td>${planInfo.pi_name}</td>
				<td>${planInfo.planType.pt_name}</td>
				<td>${planInfo.pi_createDate}</td>
				<td>
					<button type="button" class="btn btn-primary"
						onclick="promptViewForm('${planInfo.pi_id}', '${planInfo.pi_name}');">查看</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	<tr>
		<th scope="col" colspan="4"><jsp:include page="/include/fenye2.jsp" /></th>
	</tr>
</table>
</p>
<script type="text/javascript">
	function topage(page) {
	    var form = document.getElementById("planInfoSearchForm");
	    form.page.value = page;
	    form.submit();
    }

    function promptViewForm(pi_id, pi_name) {
	    parent.layer.open({
	        type : 2,
	        title : pi_name,
	        area : ['1080px', '640px'],
	        scrollbar : false,
	        content : ['jsp/emeplan/management/manage_list.jsp?piId=' + pi_id, 'yes'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }
</script>
