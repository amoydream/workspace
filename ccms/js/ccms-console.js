$(function() {
	$('#btn_debugMode').click(function() {
		if($(this).hasClass('button-down')) {
			$(this).removeClass('button-down').addClass('button');
			$.ccms.conf.debugMode = false;
		} else if($(this).hasClass('button')) {
			$(this).removeClass('button').addClass('button-down');
			$.ccms.conf.debugMode = true;
		}
	});

	$('#btn_confirmMode').click(function() {
		if($(this).hasClass('button-down')) {
			$(this).removeClass('button-down').addClass('button');
			$.ccms.conf.confirmMode = false;
		} else if($(this).hasClass('button')) {
			$(this).removeClass('button').addClass('button-down');
			$.ccms.conf.confirmMode = true;
		}
	});

	$('#btn_silentMode').click(function() {
		if($(this).hasClass('button-down')) {
			$(this).removeClass('button-down').addClass('button');
			$.ccms.conf.silentMode = false;
		} else if($(this).hasClass('button')) {
			$(this).removeClass('button').addClass('button-down');
			$.ccms.conf.silentMode = true;
		}
	});

	$('#btn_keepLogin').click(function() {
		if($(this).hasClass('button-down')) {
			$(this).removeClass('button-down').addClass('button');
			$.ccms.conf.keepLogin = false;
		} else if($(this).hasClass('button')) {
			$(this).removeClass('button').addClass('button-down');
			$.ccms.conf.keepLogin = true;
		}
	});

	$('#sel_ugrpNO').change(function() {
		$.ccms.user.ugrpNO = $('#sel_ugrpNO').val();
	});

	$('#sel_opLevel').change(function() {
		$.ccms.user.opLevel = $('#sel_opLevel').val();
	});

	$('#sel_callLevel').change(function() {
		$.ccms.user.callLevel = $('#sel_callLevel').val();
	});

	$('#btn_open').click(function() {
		var conf = {
		    host : $('#host').nval(),
		    port : $('#port').nval(),
		    seatID : $('#seatID').nval(),
		    debugMode : $('#btn_debugMode').hasClass('button-down'),
		    confirmMode : $('#btn_confirmMode').hasClass('button-down'),
		    silentMode : $('#btn_silentMode').hasClass('button-down'),
		    keepLogin : $('#btn_keepLogin').hasClass('button-down')
		};

		$.ccms.open(conf);
	});

	$('#btn_close').click(function() {
		$.ccms.close();
	});

	$('#btn_login').click(function() {
		var user = {
		    userID : $('#userID').nval(),
		    userName : $('#userName').nval(),
		    ugrpNO : $('#ugrpNO').nval(),
		    callLevel : $('#callLevel').nval(),
		    opLevel : $('#opLevel').nval()
		};

		$.ccms.login(user);
	});

	$('#btn_logout').click(function() {
		$.ccms.logout();
	});

	$('#btn_call').click(function() {
		var tel_number = $('#tel_number').nval();
		$.ccms.call(tel_number);
	});

	$('#btn_hangUp').click(function() {
		$.ccms.CtiSeatHangUP();
	});

	$('#btn_sendFAX').click(function() {

	});
});