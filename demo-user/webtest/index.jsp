<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- <%@ include file="/common/include/common.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
<script type="text/javascript">
	
</script>
</head>
<body>
   <form action="">
      <input id="btnGetTm" type="button" value="What Time is it?"
         onclick="getTime();" />
   </form>
   <input id="btnShow" type="button" value="show" />
   <input id="btnHide" type="button" value="hide" />
   <div id="divBlock"
      style="width: 200px; height: 200px; background-color: red;"></div>
</body>
</html>