<%@ include file="/include/inc.jsp"%>
<!--16-3-18-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>plugins/jquery-1.7.2.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>plugins/jquery.cookie.js"></script>
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>plugins/changeEasyuiTheme.js"></script>



<link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
<link href="<%=basePath%>plugins/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" media="screen" />

<!--  <link rel="stylesheet" type="text/css" href="<%=basePath %>css/table.css" />-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/buttoncss.css" />

<!-- script -->
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/easyui/jquery.easyui.min.js"></script>
<script src="<%=basePath %>js/extendUI.js"></script>
<script src="<%=basePath %>plugins/easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=basePath %>plugins/easyui/validatebox.extend.js"></script>
<script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script src="<%=basePath %>js/main.js"></script>
<script src="<%=basePath %>js/datagrid-detailview.js"></script>
<script src="<%=basePath %>js/datagrid-groupview.js"></script>
<script src="<%=basePath %>js/jsloader.js"></script>
<script src="<%=basePath %>js/session.js"></script>
<!-- fullcalendar -->
<link href="<%=basePath%>plugins/jqueryui/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>plugins/jqueryui/fullcalendar/fullcalendar.min.js"></script>

<!-- datepicker -->
<link href="<%=basePath%>plugins/jqueryui/datepicker/jquery.ui.datepicker.min.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>plugins/jqueryui/datepicker/jquery.ui.datepicker-zh-CN.min.js"></script>
<script src="<%=basePath%>plugins/jqueryui/datepicker/jquery.ui.datepicker.min.js"></script>
<c:if test="${CCMSRole}">
	<script src="plugins/ccms/ccms.js" type="text/javascript"></script>
	<script src="plugins/ccms/lauvan_ccms.js" type="text/javascript"></script>
	<script src="plugins/ccms/lauvan_call.js" type="text/javascript"></script>
	<!-- <script>
		$.extend(true, {
	        ccms : {
	            ws_location : '${CCMSET.WS_LOCATION}',
	            tel_number : '${CCMSET.TEL_NUMBER}',
	            fax_number : '${CCMSET.FAX_NUMBER}',
	            userID : 'syjb',
	            userName : '\u5e02\u5e94\u6025\u529e',
	            seatID : '8801',
	            seatIDs : '8801,8802,8804',
	            ugrpNO : '2',
	            callLevel : '5',
	            opLevel : '5'
	        }
        });
	</script> -->
	<script>
		$.extend(true, {
	        ccms : {
	            ws_location : '${CCMSET.WS_LOCATION}',
	            tel_number : '${CCMSET.TEL_NUMBER}',
	            fax_number : '${CCMSET.FAX_NUMBER}',
	            userID : '${loginModel.userAccount}',
	            userName : '${loginModel.userName}',
	            seatID : '${loginModel.seatID}',
	            seatIDs : '${loginModel.seatID}',
	            ugrpNO : '${loginModel.ugrpNO}',
	            callLevel : '${loginModel.callLevel}',
	            opLevel : '${loginModel.opLevel}'
	        }
        });
	</script>
</c:if>


