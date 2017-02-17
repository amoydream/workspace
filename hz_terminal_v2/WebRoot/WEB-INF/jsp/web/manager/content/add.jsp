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
		contenteditor= KindEditor.create('#content',{
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
	 
	 <form id="form1" name="form1" method="post" action="<%=basePath%>Main/content/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">所属栏目</td>
			    	<td >
			    		<input type="text" id="channeltype" name="c.channelid"  data-options="value:'${channelid}',required:true,icons:iconClear,method:'get'" class="easyui-combotree" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">发布时间</td>
			    	<td >
			    		<input type="text" name="c.releasedate" data-options="icons:iconClear,validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">标题</td>
			    	<td colspan="3">
			    		<input type="text"  name="c.caption"  data-options="required:true,icons:iconClear,validType:'length[0,256]'"  class="easyui-textbox" style="width: 545px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">来源</td>
			    	<td >
			    		<input type="text"  name="c.origin"  data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">url</td>
			    	<td >
			    		<input type="text"  name="c.originurl"  data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr >
		    		<td class="sp-td1">类型</td>
		    		<td >
			    		<select id="contenttype" name="c.contenttype" data-options="required:true,panelHeight:'auto',icons:iconClear,editable:false,onSelect:selectType" class="easyui-combobox" style="width: 200px;">
			    			<option value="1">普通</option>
			    			<option value="2">图文</option>
			    		</select>
			    	</td>
			    		<td class="sp-td1">是否推荐</td>
			    	<td>
		    			<input type="checkbox" name="c.isrecommend" value="1" />
		    		</td>
		    	</tr>
		    	<tr id="tr_pic" style="display:none;">
		    		<td class="sp-td1">图片</td>
		    		<td>
		    			<div id="pic_div"></div>
		    		</td>
		    		<td colspan="2">
		    			<input type="file" name="file" id="contentpic"/>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">内容</td>
		    		<td colspan="3">
		    			<textarea  name="c.content" id="content" style="height:300px; width:99%">
		    			</textarea>		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
