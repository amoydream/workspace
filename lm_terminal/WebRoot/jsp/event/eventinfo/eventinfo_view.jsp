<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid" style="margin-top: 25px;">
	<div class="row-fluid">
			<div class="form-group">
				<div style="text-align: center; margin-bottom: 10px;">
					<button type="button" class="btn btn-primary" onclick="eventinfo_report(${eventInfo.ev_id});">信息专报</button>
					<a href="javascript:void(0);" class="btn btn-primary" tab_id="eventinfoDisposal" 
url="jsp/event/disposal/disposal_main.jsp?evId=${eventInfo.ev_id}&eventTypeId=${eventInfo.eventType.et_id}&ev_level=${eventInfo.ev_level}" onclick="eventInfo_disposalUI(this);" title="处置过程" class='thumbnail'>处置过程</a>
					<button type="button" class="btn btn-primary" onclick="eventinfo_procInfo(${eventInfo.ev_id});">过程信息</button>
					<button type="button" class="btn btn-primary" onclick="eventinfo_doc(${eventInfo.ev_id});">相关附件</button>
					<button type="button" class="btn btn-primary" onclick="eventinfo_finishUI(${eventInfo.ev_id});">办结</button>
				</div>
			</div>
		</div>
		 
		<div class="row-fluid">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th>事件名称</th>
						<td>${eventInfo.ev_name }</td>
						<th>事发地点</th>
						<td>${eventInfo.ev_address }</td>
						<th>事发时间</th>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${eventInfo.ev_date }" /></td>
					</tr>
					<tr>
						<th>接报时间</th>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${eventInfo.ev_reportDate }" /></td>
						<th>事件类型</th>
						<td>${eventInfo.eventType.et_name }</td>
						<th>事发单位</th>
						<td>${eventInfo.organ.or_name }</td>
					</tr>
					<tr>
						<th>事件级别</th>
						<td>
						<c:if test="${eventInfo.ev_level=='1' }">Ⅰ级事件(特别重大)</c:if>
						<c:if test="${eventInfo.ev_level=='2' }">Ⅱ级事件(重大)</c:if>
						<c:if test="${eventInfo.ev_level=='3' }">Ⅲ级事件(较大)</c:if>
						<c:if test="${eventInfo.ev_level=='4' }">Ⅳ级事件(一般)</c:if>
						<c:if test="${eventInfo.ev_level=='5' }">Ⅳ级以下事件</c:if>
						</td>
						<th>接报方式</th>
						<td>
						<c:if test="${eventInfo.ev_reportMode=='1' }">电话</c:if>
						<c:if test="${eventInfo.ev_reportMode=='2' }">传真</c:if>
						<c:if test="${eventInfo.ev_reportMode=='3' }">邮件</c:if>
						<c:if test="${eventInfo.ev_reportMode=='4' }">网络</c:if>
						<c:if test="${eventInfo.ev_reportMode=='5' }">视频</c:if>
						<c:if test="${eventInfo.ev_reportMode=='6' }">其他</c:if>
						</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>受灾面积(㎡)</th>
						<td>${eventInfo.ev_affectedArea }</td>
						<th>参与（受灾）人数</th>
						<td>${eventInfo.ev_participationNumber }</td>
						<th>受伤人数</th>
						<td>${eventInfo.ev_injuredPeople }</td>
					</tr>
					<tr>
						<th>死亡人数</th>
						<td>${eventInfo.ev_deathToll }</td>
						<th>经济损失(万元)</th>
						<td>${eventInfo.ev_economicLoss }</td>
						<th>报告人姓名</th>
						<td>${eventInfo.ev_reportName }</td>
					</tr>
					<tr>
						<th>报告人职务</th>
						<td>${eventInfo.ev_reportPost }</td>
						<th>经度</th>
						<td>${eventInfo.ev_longitude }</td>
						<th>纬度</th>
						<td>${eventInfo.ev_latitude }</td>
					</tr>
					<tr>
						<th>报告人单位</th>
						<td>${eventInfo.ev_reportUnit }</td>
						<th>报告人电话</th>
						<td>${eventInfo.ev_reportPhone }</td>
						<th>报告人地址</th>
						<td>${eventInfo.ev_reportAddress }</td>
					</tr>
					<tr>
						<th>相关人员</th>
						<td>${eventInfo.ev_relatedPersonnel }</td>
						<th>结束时间</th>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${eventInfo.ev_endDate }" /></td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>事件起因、性质</th>
						<td colspan="5">${eventInfo.ev_cause }</td>
					</tr>
					<tr>
						<th>影响范围、发展趋势</th>
						<td colspan="5">${eventInfo.ev_influenceScope }</td>
					</tr>
					<tr>
						<th>先期处置情况</th>
						<td colspan="5">${eventInfo.ev_advancedDisposal }</td>
					</tr>
					<tr>
						<th>事件基本情况</th>
						<td colspan="5">${eventInfo.ev_basicSituation }</td>
					</tr>
					<tr>
						<th>拟采取的措施和<br>下一步工作建议</th>
						<td colspan="5">${eventInfo.ev_nextStep }</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
	<script type="text/javascript">
        function eventInfo_disposalUI(the){
        	parent.tabs_open(the);
        }

        function eventinfo_procInfo(ev_id) {
	        parent.layer.open({
	            type : 2,
	            title : '备忘录',
	            area : ['800px', '600px'],
	            scrollbar : false,
	            content : 'event/eventNote/list?ev_id=' + ev_id,
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.selectType(index, window);
	            }
	        });
        }

        function eventinfo_doc(ev_id) {
	        parent.layer.open({
	            type : 2,
	            title : '相关附件',
	            area : ['800px', '640px'],
	            scrollbar : false,
	            content : ['event/eventdoc/list?evId='+ev_id, 'yes'],
	            btn : ['确认', '取消','上传附件'],
	            yes : function(index, layero) {
		            layero.find('iframe')[0].contentWindow.selectType(index, window);
	            },cancel: function(index){
	            },btn3: function(index, layero){
	            	eventdoc_upload(ev_id);
	            }
	        });
        }
        
        function eventdoc_upload(ev_id) {
	        parent.layer.open({
	            type : 2,
	            title : '事件附件上传',
	            area : ['550px', '400px'],
	            scrollbar : false,
	            content : ['jsp/event/eventdoc/eventdoc_upload.jsp?evid='+ev_id, 'no']
	        });
        }
        
        function eventinfo_report(id) {
	        parent.layer.open({
	            type : 2,
	            title : '信息专报',
	            area : ['1000px', '600px'],
	            scrollbar : false,
	            content : ['event/eventReport/list?evId='+id, 'yes']
	        });
        }
        function eventinfo_finishUI(id) {
    		parent.layer.confirm('您确定处理完该事件了么？', function(index) {
    			$.post('event/eventinfo/finish', {
    				id : id
    			}, function(j) {
    				if (j.success) {
    					parent.closeTab("tab_eventinfoView");
    					parent.layer.close(index);
    				} else {
    					parent.layer.msg(j.msg, {
    					    offset: 0,
    					    shift: 6
    					});
    				}
    			}, 'json');
    		});
    	}
	</script>
</body>
</html>