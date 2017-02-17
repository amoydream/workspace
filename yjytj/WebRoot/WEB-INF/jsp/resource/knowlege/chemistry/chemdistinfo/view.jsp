<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ include file="/include/inc.jsp"%>
<style>
.chemdistdiv ol li{
	list-style-type: decimal;
}
</style>
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">
				危化品名称
			</td>
			<td colspan="3">
			${info.chemname}
			</td>
		</tr>
		<tr>
			<td class="sp-td1">
				应急处置方式
			</td>
			<td colspan="3">
			<div class="chemdistdiv" style="height:380px;overflow:auto;">
			   ${info.distway}
			 </div>
			</td>
		</tr>

	</table>
</form>
