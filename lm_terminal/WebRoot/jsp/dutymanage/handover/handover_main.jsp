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
<title>短信调度</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript">
	$(function() {
	    $('#menu_treeview').treeview({
	        data : [{
	            text : "交接班管理",
	            href : "/dutymanage/handover/takeover",
	            nodes : [{
	            	text : "交班管理",
	                href : "/dutymanage/handover/handover"
	            }, {
	            	text : "接班管理",
	                href : "/dutymanage/handover/takeover"
	            }]
	        }],
	        multiSelect : false,
	        onNodeSelected : function(event, node) {
		         if(node.href) {
			        window.location.href = '<%=request.getContextPath() %>' + node.href + '';
		        } 
	        }
	    });
    });
    
    $(function() {
	    $('#ho_date_start').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        minView : 'month',
	        autoclose : true
	    });
	    
	    $('#ho_date_end').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        minView : 'month',
	        autoclose : true
	    });
    });
    
    function promptViewForm() {
	    parent.layer.open({
	        type : 2,
	        title : '查看值班信息',
	        area : ['800px', '640px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/handover/handover_view.jsp', 'no'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }

    function promptAddForm() {
	    parent.layer.open({
	        type : 2,
	        title : '新增交班',
	        area : ['800px', '560px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/handover/handover_add.jsp', 'no'],
	        btn : ['保存', '取消'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 25px;">
			<div class="col-md-3">
				<div id="menu_treeview"></div>
			</div>
			<div class="col-md-9">
				<div style="margin-bottom: 15px;">
					<form id="phonedispForm" class="form-inline" action="" method="post">
						<div class="form-group">
							<label for="ho_name">交班人</label>
							<input type="text" id="ho_name" name="ho_name" class="form-control" placeholder="交班人姓名"
								value="">
						</div>
						<div class="form-group">
							<label for="to_name">接班人</label>
							<input type="tel" id="to_name" name="to_name" class="form-control" placeholder="接班人姓名"
								value="">
						</div>
						<div class="form-group">
							<label for="ho_date_start">交班日期</label>
							<input type="text" id="ho_date_start" name="ho_date_start" class="form-control"
								placeholder="开始日期" value="">
							-
							<input type="text" id="ho_date_end" name="ho_date_end" class="form-control"
								placeholder="结束日期" value="">
						</div>
						<button type="button" class="btn btn-success"
							onclick="this.form.page.value=1; this.form.submit();">搜索</button>
						<c:if test="${requestScope.dispatch eq 'handover' }">
						&nbsp;<button type="button" class="btn btn-primary" onclick="promptAddForm();">新增</button>
						</c:if>
					</form>
				</div>
				<p>
					<jsp:include page="handover_${requestScope.dispatch}.jsp" />
				</p>
			</div>
		</div>
	</div>
</body>
</html>