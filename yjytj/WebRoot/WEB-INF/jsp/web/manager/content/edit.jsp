<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	var basePath = '<%=basePath%>';
	$(function(){
		$("#contentpic").uploadify(param);
		KindEditor.options.imageTabIndex = 1;
		contenteditor = KindEditor.create('#content',{
			filePostName:'file',
			uploadJson: basePath+'Main/attachment/save/web--${loginModel.userId}',
			allowFileManager:true,
			items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
					'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', '|', 'image'],
			afterBlur: function(){ contenteditor.sync(); },
			afterCreate: function(){
				var self = this;
				KindEditor.ctrl(document, 13, function(){
					self.sync();
					k('form[name=form1]')[0].submit();
				});
				KindEditor.ctrl(self.edit.doc, 13, function(){
					self.sync();
					KindEditor('form[name=form1]')[0].submit();
				});
			}
		});
		$("#channeltype").combotree({
			url:'<%=basePath%>Main/channel/getChannelComboTree',
			onBeforeSelect: function(node){
				if(!$(this).tree('isLeaf', node.target)){
					return false;
				}
			},
			onClick: function(node){
				if(!$(this).tree('isLeaf', node.target)){
					$("#channeltype").combo('showPanel');
				}
			}

		});

	});


	
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/content/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">所属栏目</td>
			    	<td >
			    		<input type="hidden" name="c.contentid" value="${c.contentid}"/>
			    		<input type="text" id="channeltype" name="c.channelid" value="${c.channelid}" data-options="required:true,icons:iconClear,method:'get'" class="easyui-combotree" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">发布时间</td>
			    	<td >
			    		<input type="text" name="c.releasedate" value="${c.releasedate}" data-options="icons:iconClear,validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">标题</td>
			    	<td colspan="3">
			    		<input type="text"  name="c.caption" value="${c.caption}" data-options="required:true,icons:iconClear,validType:'length[0,256]'"  class="easyui-textbox" style="width: 545px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">来源</td>
			    	<td >
			    		<input type="text"  name="c.origin" value="${c.origin}" data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">url</td>
			    	<td >
			    		<input type="text"  name="c.originurl" value="${c.originurl}" data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr >
		    		<td class="sp-td1">类型</td>
		    		<td >
			    		<select id="contenttype" name="c.contenttype" data-options="required:true,value:'${c.contenttype}',panelHeight:'auto',icons:iconClear,editable:false,onSelect:selectType" class="easyui-combobox" style="width: 200px;">
			    			<option value="1">普通</option>
			    			<option value="2">图文</option>
			    		</select>
			    	</td>
			    		<td class="sp-td1">是否推荐</td>
			    	<td>
		    			<input type="checkbox" name="c.isrecommend" value="1" <c:if test="${c.isrecommend == '1'}">checked</c:if> />
		    		</td>
		    	</tr>
		    	<tr id="tr_pic" <c:if test="${c.contenttype =='1'}">style="display:none;" </c:if> >
		    		<td class="sp-td1">图片</td>
		    		<td>
		    			<div id="pic_div">
		    				<c:if test="${! empty c.fjurl}">
		    					<input type="hidden" id="imageid" value="o_${c.imageid}" />
			    				<input type="hidden" name="c.imageid" value="${c.imageid}" />
			    				<img src="<%=basePath%>${c.fjurl}" style="width:135px;height:85px;float:left;"/>
			    				<a href="javascript:delContentPic('o_${c.imageid}');"><img src="plugins/uploadify/cancel.png" height="13" align="middle"/></a>
			    			</c:if>
		    			</div>
		    		</td>
		    		<td colspan="2">
		    			<input type="file" name="file" id="contentpic"/>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">内容</td>
		    		<td colspan="3">
		    			<textarea  name="c.content" id="content" style="height:300px; width:99%">
		    				${c.content}
		    			</textarea>		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
