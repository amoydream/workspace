<%@ include file="../top.jsp"%>  
<%@ include file="../top_menu.jsp"%> 
<%@ include file="../common/taglibs.jsp"%> 
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td width="196" align="center" valign="top">
    <%@ include file="../left.jsp"%></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#91b7e6">
          <tr>
            <td height="28" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=basePath %>images/web/title_bg.jpg">
                <tr>
                  <td width="28"><img src="<%=basePath %>images/web/title_icon2.jpg" width="28" height="28" /></td>
                  <td align="left" class="smallbai">&nbsp;&nbsp;
                  	<b>当前位置：<a href="./">首页</a>
                  		<c:forEach items="${chaNodeList}" var="node">
                  			>><a href="${node.channelpath}">${node.channelname}</a>
                  		</c:forEach>
                  	</b>
                  </td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td height="525" valign="top" bgcolor="#FFFFFF">
            ${c.content }
            </td>
          </tr>
        </table></td>
      </tr>
      
    </table></td>
  </tr>
</table>
<%@ include file="../bottom.jsp"%> 