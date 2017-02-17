<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
	$(function(){
		KindEditor.options.imageTabIndex = 1;
		chemdistinfoEditor = KindEditor.create('#distway',{
			items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
					'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist'],
			afterBlur: function(){ chemdistinfoEditor.sync(); },
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
		chemdistinfoEditor.focus();
	});

	function findchemid(){
		var param = {
			title: '选择危化品',
			width:430,
			height:450,
			href:'<%=basePath%>Main/chemdistinfo/getChemList',
			buttons:[
				{text:'确定',
				iconCls: 'icon-save',
				handler: function(){
					var row = $("#chemdistGird").datagrid("getSelected");
					$("#chemid").val(row.CHEMID);
					$("#chemname").textbox('setValue', row.CHEMNAME);
					$("#chemDialog").dialog('close');
				}},
				{
					text: '关闭',
					iconCls: 'icon-no',
					handler: function(){
						$("#chemDialog").dialog('close');
					}
				}
			]
		};

		$.lauvan.openCustomDialog("chemDialog",  param, null, null);
	}
	
  </script>

<form id="form1" method="post"
	action="<%=basePath%>Main/chemdistinfo/save" style="width: 100%;">
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">
				危化品名称
			</td>
			<td colspan="3">
				<input type="hidden" name="t_Bus_Chemdistinfo.id" value="${info.id}"/>
				<input type="hidden" id="chemid" name="t_Bus_Chemdistinfo.chemid" value="${info.chemid}" />
				<input id="chemname" readonly="true" data-options="required:true"
					class="easyui-textbox" style="width: 475px;" value="${info.chemname}"/>
				<a onclick="findchemid()" class="easyui-linkbutton"
					data-options="iconCls:'icon-search'"></a>
			</td>
		</tr>
		<tr>
			<td class="sp-td1">
				应急处置方式
			</td>
			<td colspan="3">
				<textarea name="t_Bus_Chemdistinfo.distway" id="distway"
					style="height: 430px; width: 98%;">
			    			${info.distway}
			    		</textarea>
			</td>
		</tr>

	</table>
</form>
