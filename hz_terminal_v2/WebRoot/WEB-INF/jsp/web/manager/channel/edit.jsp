<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  var editor;
  	$(function(){
		KindEditor.options.imageTabIndex = 1;
		channeleditor= KindEditor.create('#content',{
			filePostName:'file',
			uploadJson: '<%=basePath%>Main/attachment/save/webphoto--${loginModel.userId}',
			allowFileManager:true,
			items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
					'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', '|', 'image'],
			afterBlur: function(){ channeleditor.sync(); },
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
  	  });
  	channeleditor.focus();
	$("#issingle").click(function(){
		$("#tr_content").css("display", this.checked? "": "none");
		$("#issinglepage").val(this.checked);
	});
	  
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/channel/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">上级栏目</td>
			    	<td >
			    		<input type="hidden" name="c.parentid" value="${c.parentid}" />
			    		<input type="hidden" name="c.channelid" id="channelid" value="${c.channelid}"/>
			    		<c:choose>
			    		<c:when test="${empty pchannel}">顶级栏目</c:when>
			    		<c:otherwise>
			    			${pchannel.channelname}
			    		</c:otherwise>
			    		</c:choose>
			    	</td>
			    	<td class="sp-td1">是否单页</td>
			    	<td >
			    		<input type="checkbox" name="c.issinglepage" id="issingle" value="1" <c:if test="${c.issinglepage == '1' }">checked</c:if> />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">栏目名称</td>
			    	<td >
			    		<input type="text"  name="c.channelname" value="${c.channelname}" data-options="icons:iconClear,validType:'length[0,128]',required:true"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    			<td class="sp-td1">访问路径</td>
			    	<td >
			    		<input type="text"  name="c.channelpath" invalidMessage="访问路径已经存在"  value="${c.channelpath}" data-options="icons:iconClear,validType:['length[0,128]','checkCode[\'<%=basePath%>Main/channel/ifExistChannel\', \'channelpath\', \'channelid\',\'#channelid\']'],required:true"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">meta标题</td>
			    	<td >
			    		<input type="text"  name="c.metatitle" value="${c.metatitle}" data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">meta关键字</td>
			    	<td >
			    		<input type="text"  name="c.metakeywords" value="${c.metakeywords}" data-options="icons:iconClear,validType:'length[0,128]'"  class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">meta描述</td>
		    		<td colspan="3">
			    		<input type="text"  name="c.metadesc" value="${c.metadesc}" data-options="icons:iconClear,validType:'length[0,512]'" class="easyui-textbox" style="width: 560px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">栏目模板</td>
		    		<td>
		    			<input type="text"  name="c.channeltpl" value="${c.channeltpl}" data-options="icons:iconClear,required:true"  class="easyui-textbox" style="width: 200px;"/>
		    		</td>
		    		<td class="sp-td1">是否显示</td>
		    		<td>
		    			<input type="checkbox" name="c.isdisplay" value="1" <c:if test="${c.isdisplay == '1' }">checked </c:if>/>
		    		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">外部链接</td>
		    		<td>
		    			<input type="text"  name="c.outlink" value="${c.outlink}" data-options="icons:iconClear"  class="easyui-textbox" style="width: 200px;"/>
		    		</td>
		    		<td class="sp-td1">排列顺序</td>
		    		<td>
		    			<input type="text"  name="c.priority" value="${c.priority}"  data-options="icons:iconClear,validType:'length[0,2]',prompt:'请输入整数'"  class="easyui-numberbox" style="width: 200px;"/>
		    		</td>
		    	</tr>
		    	<tr id="tr_content" <c:if test="${c.issinglepage=='0' }">style="display:none;" </c:if>>
		    		<td class="sp-td1">内容</td>
		    		<td colspan="3">
		    			<textarea  name="c.content" id="content" style="height:300px; width:99%">
		    				${c.content}
		    			</textarea>		    		
		    		</td>
		    	</tr>
	    </table>
    </form>
