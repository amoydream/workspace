<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/work/person/person_multiselect.jsp" />
<script type="text/javascript">
	function returnPersons(index, window) {
	    window.$("#person_data").html('');
	    $.each($("[name='tr_peinfo']"), function(i, tr) {
		    var pe_name = $($(tr).children("[name='pe_name']").first()).html();
		    var pe_jobs = $($(tr).children("[name='pe_jobs']").first()).html();
		    var pe_mobilephone = $($(tr).children("[name='pe_mobilephone']").first()).html();
		    var cb = $($($(tr).children("[name='select']").first()).children("[type='checkbox']").first());
		    if(cb.is(":checked")) {
			    window.$("#person_data").append("<tr><td>" + pe_name + "</td><td>" + pe_jobs + "</td><td>"
			                                    + pe_mobilephone
			                                    + "</td><td><input type='button' class='btn btn-primary' value='拨号'>"
			                                    + "<input type='hidden' name='pe_id_arr' value='" + cb.attr('id')
			                                    + "'></td>");
		    }
	    });
	    
	    parent.layer.close(index);
    }
</script>