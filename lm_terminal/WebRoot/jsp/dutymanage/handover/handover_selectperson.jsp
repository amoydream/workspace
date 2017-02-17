<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/work/person/person_select.jsp" />
<script type="text/javascript">
	function returnPerson(selectedPerson) {
	    win.$("#pe_name").val(selectedPerson.pe_name);
	    parent.layer.close(index);
    }
</script>