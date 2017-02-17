<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
.rtable td{border:solid 3px #63B8FF;width:100px;height:30px;}
.select_li{background-color:#00BFFF}
.item_ul li{
	line-height:25px;
	padding-left:5px;
}
.item_tab{
	padding-left:10px;background-color:#A4D3EE;font-size:15px;
}
.item_div{
	border:5px solid #A4D3EE;border-radius:10px;
}
.select_ul{
	 border:3px solid #00BFFF;
	 width:120px;
	 height:80px;
}
</style>
	<script>
	var xval=yval=dlval=xtext=ytext=dltext= null;
	$(function(){
		$('.item').dragable({
			proxy: 'clone',
			revert: true
		});

		$('.drop').droppable({
			onDrop:function(e,source){
				var $ul = $(this).find('ul:eq(0)');
				//ul去掉选中样式
				$ul.removeClass("select_ul");
				if(($(this).hasClass('wd') && $(source).hasClass('wd')) ||
						($(this).hasClass('dl') && $(source).hasClass('dl'))){
					//更新table中值
					var text = $(source).find('span:eq(0)').text();
					var val  = $(source).find("input:eq(0)").val(); //获取第一个input
					var flag = null;
					if($(this).hasClass('x')){ //设置选中的项目值
						$("#s_x").text(text);
						xval = val;
						flag = 'x';
					}else if($(this).hasClass('y')){
						$("#s_y").text(text);
						yval = val;
						flag = 'y';
					}else{
						$("#s_dl").text(text);
						dlval = val;
						flag = 'dl';
					}
					$ul.empty();
					var count = 1;
					$(source).find('div').children('p').each(function(){
						var html_li = "";
						var val = $(this).find("input:eq(0)").val();
						if(count == 1){
							html_li = "<li id='"+flag+"_"+val+"' class='select_li' onclick=\"setVal('"+flag+"','"+val+"')\">"+$(this).text() +"</li>";
							if(flag == 'x'){
								xtext = $(this).text();
							}
							if(flag == 'y'){
								ytext = $(this).text();
							}
							if(flag == 'dl'){
								dltext = $(this).text();
							}
						
						}else{
							html_li = "<li id='"+flag+"_"+val+"' onclick=\"setVal('"+flag+"','"+val+"')\">"+$(this).text() +"</li>";
						}
						$ul.append(html_li);
						count ++;
						
					});
					
				}
				//去掉其他项的选择状态，并且将拖拉的项更改颜色为选中
				$(source).parent("li").siblings("li").removeClass("select_li");
				$(source).parent().addClass("select_li");
				
				$(source).dragable('options').cursor= 'move';
			}
			,
			onDragLeave:function(e,source){
				$(source).dragable('options').cursor='move';
				//ul去掉选择样式
				var $ul = $(this).find('ul:eq(0)');
				$ul.removeClass("select_ul");
			}
			,
			onDragEnter:function(e,source){
				if(!($(this).hasClass('wd') && $(source).hasClass('wd')) &&
						!($(this).hasClass('dl') && $(source).hasClass('dl'))){
					$(source).dragable('options').cursor= 'not-allowed';
				}
				//ul添加选择样式
				var $ul = $(this).find('ul:eq(0)');
				$ul.addClass("select_ul");
			}
		});

		
	});

	
	function setVal(flag, val){
		var $li = $("#"+flag+"_"+val);
		$li.siblings("li").removeClass("select_li"); //取消其他维度/度量的选择状态
		$li.addClass("select_li");
		if(flag == 'x'){
			xval = val;
			xtext = $li.text();
		}else if(flag == 'y'){
			yval = val;
			ytext = $li.text();
		}else{
			dlval = val;
			dltext = $li.text();
		}
		
	}
	function eventStatsSrh(){
		var sdate = $("#startdate").datebox('getValue');
		var edate = $("#enddate").datebox('getValue');
		if(xval == null || yval == null || dlval == null){
			$.lauvan.MsgShow({msg: '请先选择X维度，Y维度和度量维度再查询！'});
			return;
		}
		$("#eventstats_box").load("<%=basePath%>Main/eventStats/statsResult", 
				{"xval":xval, "yval":yval, "dlval":dlval, "sdate":sdate, "edate":edate,"xtext":xtext,"ytext":ytext,"dltext":dltext});
	}
	</script>
	
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
			<span>起始时间：</span>
			<input type="text" name="startdate" id="startdate" value="${sdate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<span>结束时间：</span>
			<input type="text" name="enddate" id="enddate" value="${edate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventStatsSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
			<div data-options="region:'west', split:true" style="width:300px;overflow-x:hidden;" >
			<table cellpadding="2" cellspacing="0" style="width:250px;margin:0 auto;">
				<tr>
					<td rowspan="2">
					<div style="width:125px;height:240px;" class="item_div">
						<div class="item_tab">维度</div>
						<ul class="item_ul">
							<li >
								<a class="item wd">
									<span>时间维</span>
									<div style="display:none;">
										<p>年<input type="hidden" value="year"/></p>
										<p>季度<input type="hidden" value="quarter"/></p>
										<p>月<input type="hidden" value="month"/></p>
									</div>
								</a>
							</li>
							<li>
								<a class="item wd">
									<span>区域维</span>
									<div style="display:none;">
										<p>街镇 <input type="hidden" value="occurarea"/></p>
										<p>村<input type="hidden" value="ev_address"/></p>
									</div>
								</a>
							</li>
							<li>
								<a class="item wd">
									<span>类型维</span>
									<div style="display:none;">
										<p>类型<input type="hidden" value="ev_type"/></p>
										<p>级别<input type="hidden" value="ev_level"/></p>
									</div>
								</a>
							
							</li>
							<li>
								<a class="item wd">
									<span>报告维</span>
									<div style="display:none;">
										<p>报告单位<input type="hidden" value="ev_reportunit"/></p>
										<p>报告人<input type="hidden" value="ev_reporter"/></p>
									</div>
								</a>
							</li>
							<li>
								<a class="item wd">
									<span>事件来源维</span>
									<div style="display:none;">
										<p>事件来源<input type="hidden" value="ev_reportmode"/></p>
									</div>
								</a>
							</li>
						</ul>
					</div>
					</td>
					<td>
					<div class="drop wd x item_div" style="width:125px;height:110px;">
						<div class="item_tab">已选择X维度</div>
						<ul class="item_ul">
						
						</ul>
					</div>
					</td>
				</tr>
				<tr>
					<td>
					<div class="drop wd y item_div" style="width:125px;height:110px;">
						<div class="item_tab">已选择Y维度</div>
						<ul class="item_ul">
						
						</ul>
					</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width:125px;height:180px;" class="item_div">
							<div class="item_tab">可用度量</div>
							<ul class="item_ul">
							<li >
								<a class="item dl">
									<span>次数</span>
									<div style="display:none;">
										<p>次数<input type="hidden" value="count"/></p>
									</div>
								</a>
							</li>
							<li >
								<a class="item dl">
									<span>经济损失</span>
									<div style="display:none;">
										<p>经济损失（万元）<input type="hidden" value="ev_economicloss"/></p>
									</div>
								</a>
							</li>
							<li >
								<a class="item dl">
									<span>死亡人数</span>
									<div style="display:none;">
										<p>死亡人数（人）<input type="hidden" value="ev_deathtoll"/></p>
									</div>
								</a>
							</li>
							<li >
								<a class="item dl">
									<span>受灾人数</span>
									<div style="display:none;">
										<p>受灾人数（人）<input type="hidden" value="ev_participationnumber"/></p>
									</div>
								</a>
							</li>
							<li >
								<a class="item dl">
									<span>受伤人数</span>
									<div style="display:none;">
										<p>受伤人数（人）<input type="hidden" value="ev_injuredpeople"/></p>
									</div>
								</a>
							</li>
							<li >
								<a class="item dl">
									<span>受灾面积</span>
									<div style="display:none;">
										<p>受灾面积（万亩）<input type="hidden" value="ev_affectedarea"/></p>
									</div>
								</a>
							</li>
							</ul>
						</div>
					</td>
					<td>
						<div class="drop dl item_div" style="width:125px;height:180px;">
							<div class="item_tab">已选择度量</div>
							<ul class="item_ul">
								
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table class="rtable" width="100%">
						<tr>
							<td rowspan="2"><span id="s_y"></span></td>
							<td><span id="s_x"></span></td>
						</tr>
						<tr>
							<td><span id="s_dl"></span></td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
			</div>
			<div data-options="region:'center', border:false">
				<div id="eventstats_box">
				
				</div>
			</div>
	</div>

		

