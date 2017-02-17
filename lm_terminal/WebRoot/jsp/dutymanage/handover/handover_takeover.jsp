<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-bordered">
	<tr>
		<th>交班人</th>
		<th>接班人</th>
		<th>交班时间</th>
		<th>接班时间</th>
		<th>备注</th>
		<th>操作</th>
	</tr>
	<tbody id="handover_data">
		<tr>
			<td>交班人</td>
			<td>接班人</td>
			<td>2015-12-16</td>
			<td>2015-12-16</td>
			<td>&nbsp;</td>
			<td>
				<button type="button" class="btn btn-primary" onclick="promptViewForm();">查看</button>
				<button type="button" class="btn btn-success" onclick="">接班</button>
				<button type="button" class="btn btn-danger" onclick="">删除</button>
			</td>
		</tr>
		<tr>
			<td>交班人</td>
			<td>接班人</td>
			<td>2015-12-17</td>
			<td>2015-12-17</td>
			<td>&nbsp;</td>
			<td>
				<button type="button" class="btn btn-primary" onclick="promptViewForm();">查看</button>
				<button type="button" class="btn btn-success" onclick="">接班</button>
				<button type="button" class="btn btn-danger" onclick="">删除</button>
			</td>
		</tr>
		<tr>
			<td>交班人</td>
			<td>接班人</td>
			<td>2015-12-17</td>
			<td>2015-12-17</td>
			<td>&nbsp;</td>
			<td>
				<button type="button" class="btn btn-primary" onclick="promptViewForm();">查看</button>
				<button type="button" class="btn btn-success" onclick="">接班</button>
				<button type="button" class="btn btn-danger" onclick="">删除</button>
			</td>
		</tr>
	</tbody>
</table>