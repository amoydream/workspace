
-- ----------------------------
-- View structure for `v_call_history`
-- ----------------------------
DROP VIEW IF EXISTS `v_call_history`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_call_history` AS select '1' AS `vo_callerFlag`,`a`.`vo_id` AS `vo_id`,`a`.`vo_actAs` AS `vo_actAS`,`a`.`vo_callid` AS `vo_callid`,`a`.`vo_ccid` AS `vo_thatNo`,`a`.`vo_ceid` AS `vo_thisNo`,`a`.`vo_channelno` AS `vo_channelno`,`a`.`vo_outCallTime` AS `vo_outCallTime`,`a`.`vo_seadid` AS `vo_seadid`,`a`.`vo_state` AS `vo_state`,`a`.`vo_talkTime` AS `vo_talkTime`,`a`.`vo_time` AS `vo_time`,`a`.`vo_totalTime` AS `vo_totalTime`,`a`.`vo_voicepath` AS `vo_voicepath`,`a`.`vo_waitTime` AS `vo_waitTime`,`b`.`pe_id` AS `pe_id`,`c`.`ev_id` AS `ev_id` from ((`t_voice_record` `a` left join `c_address_book` `b` on((`a`.`vo_ccid` = `b`.`bo_number`))) left join `t_eventinfo` `c` on((`a`.`vo_ccid` = `c`.`ev_reportPhone`))) where (`a`.`vo_ccid` not in ('8825','88211')) union select '0' AS `vo_callerFlag`,`a`.`vo_id` AS `vo_id`,`a`.`vo_actAs` AS `vo_actAS`,`a`.`vo_callid` AS `vo_callid`,`a`.`vo_ceid` AS `vo_thatNo`,`a`.`vo_ccid` AS `vo_thisNo`,`a`.`vo_channelno` AS `vo_channelno`,`a`.`vo_outCallTime` AS `vo_outCallTime`,`a`.`vo_seadid` AS `vo_seadid`,`a`.`vo_state` AS `vo_state`,`a`.`vo_talkTime` AS `vo_talkTime`,`a`.`vo_time` AS `vo_time`,`a`.`vo_totalTime` AS `vo_totalTime`,`a`.`vo_voicepath` AS `vo_voicepath`,`a`.`vo_waitTime` AS `vo_waitTime`,`b`.`pe_id` AS `pe_id`,`c`.`ev_id` AS `ev_id` from ((`t_voice_record` `a` left join `c_address_book` `b` on((`a`.`vo_ceid` = `b`.`bo_number`))) left join `t_eventinfo` `c` on((`a`.`vo_ccid` = `c`.`ev_reportPhone`))) where (`a`.`vo_ceid` not in ('8825','88211')) ;

-- ----------------------------
-- View structure for `v_call_history_grp`
-- ----------------------------
DROP VIEW IF EXISTS `v_call_history_grp`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_call_history_grp` AS select `v_call_history`.`vo_id` AS `vo_id` from `v_call_history` group by `v_call_history`.`vo_thatNo` order by `v_call_history`.`vo_time` desc ;

-- ----------------------------
-- View structure for `v_contact`
-- ----------------------------
DROP VIEW IF EXISTS `v_contact`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_contact` AS select `cp`.`pe_id` AS `pe_id`,`cp`.`pe_name` AS `pe_name`,`cp`.`pe_jobs` AS `pe_jobs`,`cb1`.`bo_number` AS `office_phone`,`cb2`.`bo_number` AS `mobile_phone`,`cb5`.`bo_number` AS `home_phone`,`cb4`.`bo_number` AS `email`,`co`.`or_id` AS `or_id`,`co`.`or_name` AS `or_name`,`ep`.`eop_id` AS `eop_id`,`eo`.`eo_id` AS `eo_id`,`eo`.`eo_name` AS `eo_name` from (((((((`c_organ_person` `cp` left join `c_address_book` `cb1` on(((`cp`.`pe_id` = `cb1`.`pe_id`) and (`cb1`.`bo_type` = '1')))) left join `c_address_book` `cb2` on(((`cp`.`pe_id` = `cb2`.`pe_id`) and (`cb2`.`bo_type` = '2')))) left join `c_address_book` `cb5` on(((`cp`.`pe_id` = `cb5`.`pe_id`) and (`cb5`.`bo_type` = '5')))) left join `c_address_book` `cb4` on(((`cp`.`pe_id` = `cb4`.`pe_id`) and (`cb4`.`bo_type` = '4')))) left join `c_organ` `co` on((`cp`.`or_id` = `co`.`or_id`))) left join `e_emeorgan_person` `ep` on((`cp`.`pe_id` = `ep`.`pe_id`))) left join `e_emeorgan` `eo` on((`ep`.`eo_id` = `eo`.`eo_id`))) ;

-- ----------------------------
-- View structure for `v_sms_history`
-- ----------------------------
DROP VIEW IF EXISTS `v_sms_history`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sms_history` AS select '1' AS `sender_flag`,`a`.`snd_id` AS `sms_id`,`a`.`phone_no` AS `phone_no`,`a`.`send_date` AS `sms_date`,`b`.`content` AS `msg`,`d`.`pe_id` AS `pe_id`,`d`.`pe_name` AS `pe_name`,`e`.`ev_id` AS `ev_id`,`e`.`ev_name` AS `ev_name` from ((((`sms_send` `a` left join `sms_message` `b` on((`a`.`msg_id` = `b`.`msg_id`))) left join `c_address_book` `c` on(((`a`.`phone_no` = `c`.`bo_number`) and (`c`.`bo_type` = '2')))) left join `c_organ_person` `d` on((`d`.`pe_id` = `c`.`pe_id`))) left join `t_eventinfo` `e` on((`a`.`ev_id` = `e`.`ev_id`))) union select '0' AS `sender_flag`,`a`.`rec_id` AS `sms_id`,`a`.`phone_no` AS `phone_no`,`a`.`rec_date` AS `sms_date`,`a`.`msg` AS `msg`,`c`.`pe_id` AS `pe_id`,`c`.`pe_name` AS `pe_name`,`d`.`ev_id` AS `ev_id`,`d`.`ev_name` AS `ev_name` from (((`sms_receive` `a` left join `c_address_book` `b` on(((`a`.`phone_no` = `b`.`bo_number`) and (`b`.`bo_type` = '2')))) left join `c_organ_person` `c` on((`c`.`pe_id` = `b`.`pe_id`))) left join `t_eventinfo` `d` on((`a`.`ev_id` = `d`.`ev_id`))) ;

-- ----------------------------
-- View structure for `v_sms_personal`
-- ----------------------------
DROP VIEW IF EXISTS `v_sms_personal`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sms_personal` AS select `a`.`sms_send_id` AS `sms_id`,'S' AS `disp_flag`,`a`.`send_status` AS `send_status`,`b`.`sms_prop_id` AS `sms_prop_id`,`b`.`send_content` AS `sms_content`,`b`.`send_date` AS `sms_date`,`b`.`sms_type` AS `sms_type`,'Y' AS `read_status`,`c`.`pe_id` AS `pe_id`,`c`.`pe_name` AS `pe_name`,`c`.`pe_mobilephone` AS `pe_mobilephone`,`d`.`or_id` AS `or_id`,`d`.`or_name` AS `or_name`,`e`.`ev_id` AS `ev_id`,`e`.`ev_name` AS `ev_name` from ((((`t_sms_send` `a` join `t_sms_prop` `b` on(((`a`.`sms_prop_id` = `b`.`sms_prop_id`) and (`b`.`group_flag` = 'N')))) left join `c_organ_person` `c` on((`a`.`pe_id` = `c`.`pe_id`))) left join `c_organ` `d` on((`c`.`or_id` = `d`.`or_id`))) join `t_eventinfo` `e` on((`b`.`ev_id` = `e`.`ev_id`))) union select `f`.`sms_rec_id` AS `sms_id`,'R' AS `disp_flag`,'Y' AS `send_status`,'0' AS `sms_prop_id`,`f`.`rec_content` AS `sms_content`,`f`.`rec_date` AS `sms_date`,'C' AS `sms_type`,`f`.`read_status` AS `read_status`,`g`.`pe_id` AS `pe_id`,`g`.`pe_name` AS `pe_name`,`g`.`pe_mobilephone` AS `pe_mobilephone`,`h`.`or_id` AS `or_id`,`h`.`or_name` AS `or_name`,0 AS `ev_id`,'' AS `ev_name` from ((`t_sms_receive` `f` join `c_organ_person` `g` on((`f`.`pe_id` = `g`.`pe_id`))) left join `c_organ` `h` on((`g`.`or_id` = `h`.`or_id`))) group by `g`.`pe_id` order by `sms_date` desc ;

-- ----------------------------
-- View structure for `v_sms_receive`
-- ----------------------------
DROP VIEW IF EXISTS `v_sms_receive`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sms_receive` AS select `a`.`rec_id` AS `rec_id`,`c`.`pe_id` AS `pe_id` from ((`sms_receive` `a` left join `c_address_book` `b` on(((`a`.`phone_no` = `b`.`bo_number`) and (`b`.`bo_type` = '2')))) left join `c_organ_person` `c` on((`c`.`pe_id` = `b`.`pe_id`))) ;

-- ----------------------------
-- View structure for `v_sms_send`
-- ----------------------------
DROP VIEW IF EXISTS `v_sms_send`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sms_send` AS select `a`.`snd_id` AS `snd_id`,`c`.`pe_id` AS `pe_id` from ((`sms_send` `a` left join `c_address_book` `b` on(((`a`.`phone_no` = `b`.`bo_number`) and (`b`.`bo_type` = '2')))) left join `c_organ_person` `c` on((`c`.`pe_id` = `b`.`pe_id`))) ;

-- ----------------------------
-- View structure for `v_voice_record`
-- ----------------------------
DROP VIEW IF EXISTS `v_voice_record`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_voice_record` AS select `vr`.`vo_id` AS `vo_id`,`vr`.`vo_actAs` AS `vo_actAs`,`vr`.`vo_callid` AS `vo_callid`,`vr`.`vo_ccid` AS `vo_ccid`,`vr`.`vo_ceid` AS `vo_ceid`,`vr`.`vo_channelno` AS `vo_channelno`,`vr`.`vo_outCallTime` AS `vo_outCallTime`,`vr`.`vo_seadid` AS `vo_seadid`,`vr`.`vo_state` AS `vo_state`,`vr`.`vo_talkTime` AS `vo_talkTime`,`vr`.`vo_time` AS `vo_time`,`vr`.`vo_totalTime` AS `vo_totalTime`,`vr`.`vo_voicepath` AS `vo_voicepath`,`vr`.`vo_waitTime` AS `vo_waitTime`,`b`.`bo_number` AS `bo_number`,`p`.`pe_name` AS `pe_name`,`o`.`or_name` AS `or_name`,`be`.`be_id` AS `be_id`,`be`.`be_name` AS `be_name`,`ev`.`ev_id` AS `ev_id`,`ev`.`ev_name` AS `ev_name` from (((((`t_voice_record` `vr` left join `c_address_book` `b` on(((`vr`.`vo_ccid` = `b`.`bo_number`) or (`vr`.`vo_ceid` = `b`.`bo_number`)))) left join `c_organ_person` `p` on((`b`.`pe_id` = `p`.`pe_id`))) left join `c_organ` `o` on(((`b`.`or_id` = `o`.`or_id`) or (`p`.`or_id` = `o`.`or_id`)))) left join `t_baseevent` `be` on(((`vr`.`vo_ccid` = `be`.`be_reportPhone`) or (`vr`.`vo_ceid` = `be`.`be_reportPhone`)))) left join `t_eventinfo` `ev` on(((`vr`.`vo_ccid` = `ev`.`ev_reportPhone`) or (`vr`.`vo_ceid` = `ev`.`ev_reportPhone`)))) ;
