<%@ include file="../top.jsp"%>  
<%@ include file="../top_menu.jsp"%> 
<%@ include file="../common/taglibs.jsp"%> 
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td width="196" align="center" valign="top">
    <%@ include file="../left.jsp"%></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table style="float:right;position:relative;overflow:auto;" width="796px;" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#91b7e6">
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
            <td height="487" valign="top" bgcolor="#FFFFFF">
            <form id="mainForm" action="<%=basePath %>${c.channelpath}" method="post">
            <input type="hidden" name="pageNumber" value=""/>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="20" valign="top">&nbsp;</td>
	              </tr>
	              <tr>
	                <td valign="top"><table width="700" border="0" align="left" cellpadding="0" cellspacing="0">
	                	<c:set var="page" value="${webFn:contents(15,pageNo,c.channelpath,'')}" scope="page" />           
	                  <c:forEach items="${page.getList()}" var="c" varStatus="status">
	                  <tr>
	                    <td width="25" align="left" class="smallblue">&nbsp;</td>
	                    <td width="400" height="27" align="left" class="smallblue"><a href="<%=basePath%>${c.channelpath}/${c.contentid}" target="_blank" class="hei">
	                    ${status.index + 1}. 
	                    <c:choose>
										<c:when test="${fn:length(c.caption) > 30}">
											${fn:substring(c.caption, 0, 30)}...
										</c:when>
										<c:otherwise>
											  ${c.caption}
										</c:otherwise>
									</c:choose>
	                    </a></td>
						<td align="right" class="hei">${c.releasedate }</td>
	                  </tr>                                   
					</c:forEach>
	                </table></td>
	              </tr>
	              <tr>
	                <td height="40" align="left" style="font-size: 12px;padding-left: 65px;">
	                	<%@ include file="../common/pager.jsp"%> 
					</td>
	              </tr>
	            </table>
            </form>
            </td>
          </tr>
        </table></td>
      </tr>
      
    </table></td>
  </tr>
</table>
<%@ include file="../bottom.jsp"%> 