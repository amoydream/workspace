
<%@ include file="/include/inc.jsp"%>
<!-- css -->

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

<link href="<%=basePath%>plugins/gooflow/codebase/GooFlow.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=basePath%>plugins/uploadify/css/uploadify.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=basePath%>plugins/tagger/tagger.css" rel="stylesheet" type="text/css" media="screen" />
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
<script src="<%=basePath %>js/html5shiv.min.js"></script>
<%-- <script src="<%=basePath %>js/rightClick.js"></script> --%>
<!-- mail -->
<script src="<%=basePath%>js/mail.js"></script>

<!-- GooFlow js -->
<script src="<%=basePath%>plugins/gooflow/codebase/GooFlow.js" type="text/javascript"></script>
<script src="<%=basePath%>plugins/gooflow/GooFunc.js" type="text/javascript"></script>
<!-- uploadify -->
<script src="<%=basePath %>plugins/uploadify/scripts/jquery.uploadify.v2.1.0.js"></script>
<script src="<%=basePath %>plugins/uploadify/scripts/swfobject.js"></script>

<!-- jqueryui -->
<link href="<%=basePath%>plugins/jqueryui/jquery-ui.custom.min.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>plugins/jqueryui/jquery-ui.custom.min.js"></script>

<!-- fullcalendar -->
<link href="<%=basePath%>plugins/jqueryui/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>plugins/jqueryui/fullcalendar/fullcalendar.min.js"></script>

<!-- datepicker -->
<link href="<%=basePath%>plugins/jqueryui/datepicker/jquery.ui.datepicker.min.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>plugins/jqueryui/datepicker/jquery.ui.datepicker-zh-CN.min.js"></script>
<script src="<%=basePath%>plugins/jqueryui/datepicker/jquery.ui.datepicker.min.js"></script>

<c:if test="${not empty map && map.onlinemap=='0'}">
<script  src="${map.apiurl }/init.js"></script>
<script>$.basePath="<%=basePath%>";</script>
</c:if>
<c:if test="${not empty map && map.onlinemap!='0'}">
<script src="<%=basePath %>plugins/gis/core/baidu.js"></script>
<script>$.basePath="<%=basePath%>";</script>
</c:if>


<!-- kindeditor编辑器 -->
<link rel="stylesheet" href="<%=basePath%>plugins/kindeditor/themes/default/default.css"/>
<script type="text/javascript" src="<%=basePath%>plugins/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/kindeditor/lang/zh_CN.js"></script>

<!-- jquery tags input -->
<script type="text/javascript" src="<%=basePath%>plugins/tagger/tagger.js"></script>

<!-- yearmonth -->
<link href="<%=basePath%>css/mytable.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath%>js/yearmonth.js"></script>

<!-- Messenger -->
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/messenger/messenger-theme-ice.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/messenger/messenger.css"  />
<script type="text/javascript" src="<%=basePath%>plugins/messenger/underscore-min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/messenger/backbone-min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/messenger/messenger.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/messenger/messenger-extends.js"></script>
