<%@ include file="/include/inc.jsp"%>
<c:if test="${CCMSRole}">
	<script src="plugins/ccms/ccms.js" type="text/javascript"></script>
	<script src="plugins/ccms/ccms_console.js" type="text/javascript"></script>
	<script src="plugins/ccms/lauvan_ccms.js" type="text/javascript"></script>
	<script src="plugins/ccms/lauvan_call.js" type="text/javascript"></script>
	<script src="plugins/ccms/lauvan_fax.js" type="text/javascript"></script>
	<!-- <script>
		$.extend(true, {
	        ccms : {
	            ws_location : '${CCMSET.WS_LOCATION}',
	            tel_number : '${CCMSET.TEL_NUMBER}',
	            fax_number : '${CCMSET.FAX_NUMBER}',
	            userID : 'syjb',
	            userName : '\u5e02\u5e94\u6025\u529e',
	            seatID : '8801',
	            seatIDs : '8801,8802,8804',
	            ugrpNO : '2',
	            callLevel : '5',
	            opLevel : '5'
	        }
        });
	</script> -->
	<script>
		$.extend(true, {
	        ccms : {
	            ws_location : '${CCMSET.WS_LOCATION}',
	            tel_number : '${CCMSET.TEL_NUMBER}',
	            fax_number : '${CCMSET.FAX_NUMBER}',
	            userID : '${loginModel.userAccount}',
	            userName : '${loginModel.userName}',
	            seatID : '${loginModel.seatID}',
	            seatIDs : '${loginModel.seatID}',
	            ugrpNO : '${loginModel.ugrpNO}',
	            callLevel : '${loginModel.callLevel}',
	            opLevel : '${loginModel.opLevel}'
	        }
        });
	</script>
</c:if>