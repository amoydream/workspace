<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div style="font-size: 24px;font-weight: bold;width: 100%;text-align: center;">${eyear}年${emon}月份各县（区）有关单位报告突发事件信息采用情况</div>
<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		  <td class="sp-td1" rowspan="2" style="text-align: center;">单位</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 220px;">题目</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 40px;">报送</br>时效</td>
		  <td class="sp-td1" colspan="5" style="text-align: center;">使用情况</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 50px;">国家领导</br>批示</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 50px;">省领导</br>批示</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 50px;">市领导</br>批示</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 40px;">现场</br>图片</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 40px;">得分</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 40px;">本月</br>得分</td>
		  <td class="sp-td1" rowspan="2" style="text-align: center;width: 40px;">累计</br>得分</td>
	</tr>
	<tr>
		  <td class="sp-td1" style="text-align: center;width: 40px;">专报</td>
		  <td class="sp-td1" style="text-align: center;width: 40px;">传阅</td>
		  <td class="sp-td1" style="text-align: center;width: 40px;">综合</td>
		  <td class="sp-td1" style="text-align: center;width: 40px;">备查</td>
		  <td class="sp-td1" style="text-align: center;width: 40px;">约稿</td>
	</tr>
	<c:if test="${!empty elist}">
		<c:forEach items="${elist}" var="elist">
			<tr>
				<c:if test="${!empty elist.clospan}">
				<td style="text-align: center;" rowspan="${elist.clospan}" >${elist.organname}</td>
				</c:if>
				<td>${elist.title}</td>
				<td style="text-align: center;">${elist.bssx}</td>
				<td style="text-align: center;"><c:if test="${elist.zb==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.cy==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.zh==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.bc==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.yg==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.guops==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.shengps==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.ships==1}">●</c:if></td>
				<td style="text-align: center;"><c:if test="${elist.evimg==1}">●</c:if></td>
				<td style="text-align: center;">${elist.df}</td>
				<c:if test="${!empty elist.clospan}">
				<td style="text-align: center;" rowspan="${elist.clospan}" >${elist.bydf}</td>
				</c:if>
				<c:if test="${!empty elist.clospan}">
				<td style="text-align: center;" rowspan="${elist.clospan}" >${elist.ljdf}</td>
				</c:if>
			</tr>
		</c:forEach>
	</c:if>
</table>
