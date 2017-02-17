<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>处置过程</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript">
	$(function() {
	    $("#btn-${requestScope.dispatch}").attr('class', 'btn btn-primary');
    });
    
    function save(index, window) {
	    $.post('event/eventproc/save', $('#eventProcessForm').serialize(), function(result) {
		    if(result.success) {
			    parent.layer.close(index);
		    } else {
			    parent.layer.tips(result.msg, '.layui-layer-btn0', {
				    tips : 1
			    });
		    }
	    });
    }

    function promptSMSForm(pe_id) {
	    $("#pe_id").val(pe_id);
	    $
	        .post('event/eventproc/smsform', $('#organPersonForm').serialize() + '&'
	                                         + $('#eventProcessForm').serialize(), function(result) {
		        if(result.success) {
			        parent.layer.open({
			            type : 2,
			            title : '发送短信',
			            area : ['600px', '480px'],
			            scrollbar : false,
			            content : ['jsp/event/eventproc/eventproc_smsform.jsp', 'no'],
			            btn : ['发送', '取消'],
			            yes : function(index, layero) {
				            //layero.find('iframe')[0].contentWindow.reply(index, window);
			            }
			        });
		        } else {
			        parent.layer.tips(result.msg, '.layui-layer-btn0', {
				        tips : 1
			        });
		        }
	        });
    }
    
    function forwardTo(url) {
    	url = "<%=request.getContextPath()%>" + "/" + url;
	    window.location.href = url;
    }
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<div>
				<button id="btn-needrptto" class="btn btn-defalut"
					onclick="forwardTo('event/eventproc/needrptto/${eventInfoVo.ev_id}');">1、需报对象</button>
				&nbsp;→&nbsp;
				<button id="btn-advise" class="btn btn-defalut"
					onclick="forwardTo('event/eventproc/advise/${eventInfoVo.ev_id}');">2、通知对象</button>
				&nbsp;→&nbsp;
				<button id="btn-notify" class="btn btn-defalut"
					onclick="forwardTo('event/eventproc/notify/${eventInfoVo.ev_id}');">3、通报对象</button>
				&nbsp;→&nbsp;
				<button id="btn-preplan" class="btn btn-defalut"
					onclick="forwardTo('event/eventproc/preplan/${eventInfoVo.ev_id}');">4、选择预案</button>
			</div>
			<p>
				<c:if test="${requestScope.dispatch ne 'needrptto' && requestScope.dispatch ne 'preplan'}">
					<jsp:include page="/jsp/work/person/person_contacts.jsp">
						<jsp:param value="/jsp/event/eventproc/eventproc_${requestScope.dispatch}.jsp"
							name="includePage" />
					</jsp:include>
				</c:if>
				<c:if test="${requestScope.dispatch eq 'needrptto'}">
					<jsp:include page="/jsp/event/eventproc/eventproc_${requestScope.dispatch}.jsp" />
				</c:if>
				<c:if test="${requestScope.dispatch eq 'preplan'}">
					<jsp:include page="/jsp/event/eventproc/eventproc_${requestScope.dispatch}.jsp" />
				</c:if>
			</p>
		</div>
	</div>
</body>
</html>