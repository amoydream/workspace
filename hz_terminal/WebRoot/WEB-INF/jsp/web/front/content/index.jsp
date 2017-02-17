<%@ include file="../top.jsp"%>  
<%@ include file="../top_menu.jsp"%> 
<%@ include file="../common/taglibs.jsp"%> 
<style type="text/css">
.specil_712 p{width:90%;margin:0 auto;line-height:24px;font-size:12px; text-indent:24px;}
</style>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
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
            <td height="525" valign="top" bgcolor="#FFFFFF" class="specil_712">
            	<h3 style="width:90%; margin:15px auto;border-bottom:1px solid #dfdfdf;padding:0 0px 10px 0px;" align="center">${con.caption}</h3>
            	<c:if test="${! empty con.fjurl}">
            		<p align="center" style="margin-bottom:10px;"><img src="<%=basePath%>${con.fjurl}" style="width:450px;height:300px;"/></p>
            	</c:if>
		            ${con.content }
            </td>
          </tr>
        </table></td>
      </tr>
      
    </table></td>
  </tr>
</table>
<%@ include file="../bottom.jsp"%> 