<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>查看事件处置信息</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<form id="eventinfo_editform" class="form-horizontal" role="form">
				<fieldset>
					<div class="form-group">
						<label class="col-sm-1 control-label">处置人</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="us_Name" name="us_Name"
									value="${eventProcess.t_user_info.us_Name}" type="text" placeholder="处置人名称"
									data-bv-trigger="keyup" required="required" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="eventTypeName">处置时间</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="pr_date" name="pr_date" value="${eventProcess.pr_date }"
									type="text" placeholder="输入事件类型" data-bv-trigger="keyup" required="required" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="ev_level">处置信息类型</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<select class="form-control" id="ev_level" name="ev_level" value="1"
									placeholder="输入事件级别">
									<option value="1" selected="selected">反馈</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label" for="us_Name">报告人</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" type="text" name="us_Name"
									value="${eventProcess.t_user_info.us_Name}" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="pr_date">报告时间</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="pr_date" name="pr_date" value="${eventProcess.pr_date}"
									type="text" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="us_Mophone">报告人电话</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="us_Mophone" name="us_Mophone"
									value="${eventProcess.t_user_info.us_Mophone }" type="text" placeholder="报告人电话" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label" for="ev_deathToll">报告人单位</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" type="text" name="ev_deathToll" value="" placeholder="报告人单位" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="ev_economicLoss">记录人</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="ev_economicLoss" name="ev_economicLoss"
									value="${eventProcess.t_user_info.us_Name }" type="text" placeholder="记录人姓名" />
							</div>
						</div>
						<label class="col-sm-1 control-label" for="ev_economicLoss">创建时间</label>
						<div class="col-sm-3 input-message">
							<div class='input-group'>
								<input class="form-control" id="ev_economicLoss" name="ev_economicLoss"
									value="${eventProcess.pr_date }" type="text" placeholder="创建时间" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label" for="pr_content">处置内容</label>
						<div class="col-sm-9 input-message">
							<textarea class="form-control" name="pr_content" rows="6">${eventProcess.pr_content }</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label" for="remarks">备注</label>
						<div class="col-sm-9 input-message">
							<textarea class="form-control" name="remarks" rows="6"></textarea>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>