<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	var basePath = '<%=basePath%>';
	var zTree;
	var settings = {
			data:{
		simpleData:{
			enable: true,
			idKey: "d_id",
			pIdKey: "d_pid"
		}
	},
	callback: { onClick: zTreeOnClick}
	};

	var zNodes = [
	              {d_id:"0", d_pid:"0", name:"网站栏目"}
	              <c:if test="${! empty channelList}">,</c:if>
	              <c:forEach items="${channelList}" var="channel" varStatus="vx">
	              	{d_id:"${channel.channelid}", d_pid:"${channel.parentid}", name:"${channel.channelname}"}
	              	<c:if test="${fn:length(channelList) != vx.index+1}">,</c:if>
	              </c:forEach>

	];

	function zTreeOnClick(event, treeId, treeNode){
		$("#content_data").datagrid({url: '<%=basePath%>Main/content/getGridData/' + treeNode.d_id});

	}
	$(function(){
		$.fn.zTree.init($("#channeltree2"), settings, zNodes);
		zTree = $.fn.zTree.getZTreeObj('channeltree2');
		zTree.expandAll(true);
		zTree.selectNode(zTree.getNodeByParam("d_id", 0, null));
		var attrArray={
				idField:'CONTENTID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加内容信息', iconCls: 'icon-add', handler:addcontent}, '-',
						  { text: '修改', title:'修改内容信息',iconCls: 'icon-pageedit',handler:editcontent}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/content/delete'}}
						],
				url:"<%=basePath%>Main/content/getGridData",
				
			};
		$.lauvan.dataGrid("content_data",attrArray);

	});
	
	var param = {
			uploader: 'plugins/uploadify/scripts/uploadify.swf',
			cancelImg: 'plugins/uploadify/cancel.png',
			buttonText: '上传',
			script:'Main/attachment/save/web--${loginModel.userId}',
			fileQueue: 'fileQueue',
			onComplete: onComplete,
			fileDataName: 'file',
			auto:true,
			fileExt:'*.jpg;*.png;',
			fileDesc:'*.jpg;*.png;'
		};
	
	function ctnSubmit(){
		$("#form1").form('submit', {
			onSubmit: function(){
				var fboolean = $(this).form('enableValidation').form('validate');
				if(!fboolean){
					$.messager.alert('警告', '请按要求填写信息！');
				}
				//判断内容类型，如果是图文，则判断是否上传有图片
				if($("#contenttype").combobox('getValue') == '2' &&
						$("#imageid").length==0
						&& fboolean){
					fboolean = false;
					$.messager.alert('警告', '请上传图片！');
				}
				return fboolean;
			},
			success: function(result){
				var obj = $.parseJSON(result);
				if(obj.tabid && obj.furl){
					$.lauvan.reflashTab(result);
				}else{
					$.lauvan.reflash(result);
				}
			}
		});

	}
	var contenteditor;
	function editcontent(){
		var options = $(this).linkbutton("options");
		var row = $("#content_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/content/edit/' + row.CONTENTID,
			width:700,
			height:560,
			onClose:function(){
				//if(contenteditor!=null && contenteditor!=undefined){
				//	contenteditor.blur();
				//	alert("edit blur");
				//}
				KindEditor.remove('textarea[name="c.content"]');
				$(this).dialog('destroy');
				$("#contentDialog").remove();
			}
		};
		$.lauvan.openCustomDialog("contentDialog", para, ctnSubmit, "form1");
	}
	function addcontent(){
		var options = $(this).linkbutton("options");
		var pid = zTree.getSelectedNodes()[0]?zTree.getSelectedNodes()[0].d_id:0;
		var para = {
			title: options.title,
			iconCls: options.iconCls,
			href:'<%=basePath%>Main/content/add/' + pid,
			width:700,
			height:560,
			onClose:function(){
				//if(contenteditor!=null && contenteditor!=undefined){
				//	contenteditor.blur();
				//	alert("add blur");
				//}
				KindEditor.remove('textarea[name="c.content"]');
				$(this).dialog('destroy');
				$("#contentDialog").remove();
			}
		};
		$.lauvan.openCustomDialog("contentDialog", para, ctnSubmit, "form1");
	}

	function selectType(record){
    	$("#tr_pic").css("display",record.value==1?"none":'');
    }

	function delContentPic(id){
		id += "";
		if(id.indexOf("o_")<0){
			//$("#pic_div").load(basePath + "Main/attachment/delete/" + id);
			$.post("<%=basePath%>Main/attachment/delete/" + id, null ,null);
		}
		$("#pic_div").empty();
	}

	function onComplete(event, queueId, fileObj, response, data){
		var obj = eval( "(" + response + ")" );
		if($("#imageid").length>0){
			delContentPic($("#imageid").val());
		}
		var html = "<input type='hidden' name='c.imageid' id='imageid' value='"+obj.id+"'/><img src='"+obj.url+"' style='width:135px;height:85px;float:left;' />";
		html += "<a href='javascript:delContentPic("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
		$("#pic_div").append(html);
	}
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
			  <div data-options="region:'west', split:true" style="width:200px;">
			 	<ul id="channeltree2" class="ztree"></ul>
			 </div>
			<div data-options="region:'center',border:false">
			<table id="content_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			           <th data-options="field:'CONTENTID',hidden:true">ID</th>
                    	<th data-options="field:'CHANNELNAME'" width="80px">所属栏目</th>
                        <th data-options="field:'CAPTION'" width="500px">标题</th>
                        <th data-options="field:'CONTENTTYPE',formatter:function(value,row,index){return value==1?'普通':'图文'}" width="100px">类型</th>
                        <th data-options="field:'ISRECOMMEND',formatter:function(value,row,index){return value==1?'是':'否'}" width="70px">是否推荐</th>
                        <th data-options="field:'USERNAME'" width="70px">发布者</th>
                        <th data-options="field:'RELEASEDATE'" width="150px">发布时间</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
