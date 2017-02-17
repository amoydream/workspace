<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ include file="/include/inc.jsp"%>
  <script>

  </script>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">运输工具型号</td>
			    	<td colspan="3">
			    		${transtype.transtype}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">生产企业</td>
			    	<td colspan="3">
			    		${transtype.producevender}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">载重</td>
			    	<td colspan="3">
			    		${transtype.transload}
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">使用燃料</td>
			    	<td colspan="3">
			    		${transtype.usefuel}
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">运输方式</td>
			    	<td >
			    		${str:translate(transtype.transwaycode, 'YSFS')}
			    	</td>
		    		<td class="sp-td1">数据来源单位</td>
			    	<td >
			    		${str:translate(transtype.sourcedeptcode, 'ZDFHSJLYDW')}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最新更新时间</td>
			    	<td colspan="3">
			    		${transtype.updatetime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="3">
			    		${transtype.notes}
			    	</td>
		    	</tr>
	    </table>
    </form>
