package com.lauvan.meip.service;

import javax.jws.WebService;

import com.lauvan.meip.service.item.DfsdlItem;
import com.lauvan.meip.service.item.DfsdlResult;
import com.lauvan.meip.service.item.Jsdl2Item;
import com.lauvan.meip.service.item.Jsdl2Result;
import com.lauvan.meip.service.item.JsdlItem;
import com.lauvan.meip.service.item.JsdlResult;
import com.lauvan.meip.service.item.MsgItem;
import com.lauvan.meip.service.item.MsgResult;
import com.lauvan.meip.service.item.ReceiveFailedItem;
import com.lauvan.meip.service.item.ReceiveFailedResult;
import com.lauvan.meip.service.item.StatuReportItem;
import com.lauvan.meip.service.item.StatuReportResult;
import com.lauvan.meip.service.item.YfsdlItem;
import com.lauvan.meip.service.item.YfsdlResult;

@WebService
public interface MeipService {
	DfsdlResult send(DfsdlItem item);

	DfsdlResult resend(Integer[] idArr);

	JsdlResult updateJsdlStatus(Integer id);

	DfsdlResult getDfsdlById(Integer id);

	YfsdlResult getYfsdlById(Integer id);

	JsdlResult getJsdlById(Integer id);

	JsdlResult getLatestJsdl();

	Jsdl2Result getJsdl2ById(Integer id);

	MsgResult getMsgById(Integer id);

	ReceiveFailedResult getReceiveFailedById(Integer id);

	StatuReportResult getStatuReportById(Integer id);

	DfsdlResult getAllDfsdl();

	YfsdlResult getAllYfdl();

	JsdlResult getAllJsdl();

	Jsdl2Result getAllJsdl2();

	MsgResult getAllMsg();

	ReceiveFailedResult getAllReceiveFailed();

	StatuReportResult getAllStatuReport();

	DfsdlResult getDfsdlByItem(DfsdlItem item);

	YfsdlResult getYfsdlByItem(YfsdlItem paramYfsdlItem);

	JsdlResult getJsdlByItem(JsdlItem paramJsdlItem);

	Jsdl2Result getJsdl2ByItem(Jsdl2Item paramJsdl2Item);

	MsgResult getMsgByItem(MsgItem paramMsgItem);

	ReceiveFailedResult getReceiveFailedByItem(ReceiveFailedItem item);

	StatuReportResult getStatuReportByItem(StatuReportItem item);

	DfsdlResult getDfsdlPage(DfsdlItem item);

	YfsdlResult getYfsdlPage(YfsdlItem paramYfsdlItem);

	JsdlResult getJsdlPage(JsdlItem paramJsdlItem);

	Jsdl2Result getJsdl2Page(Jsdl2Item paramJsdl2Item);

	MsgResult getMsgPage(MsgItem paramMsgItem);

	MsgResult getMsgGroupPage(MsgItem paramMsgItem);

	ReceiveFailedResult getReceiveFailedPage(ReceiveFailedItem item);

	StatuReportResult getStatuReportPage(StatuReportItem item);

	DfsdlResult deleteDfsdl(Integer[] idArr);

	YfsdlResult deleteYfsdl(Integer[] idArr);

	JsdlResult deleteJsdl(Integer[] idArr);

	Jsdl2Result deleteJsdl2(Integer[] idArr);

	MsgResult deleteMsg(String[] paramArrayOfString);

	ReceiveFailedResult deleteReceiveFailed(Integer[] idArr);

	StatuReportResult deleteStatuReport(Integer[] idArr);

	DfsdlResult physicalDeleteDfsdl(Integer[] idArr);

	YfsdlResult physicalDeleteYfsdl(Integer[] idArr);

	JsdlResult physicalDeleteJsdl(Integer[] idArr);

	Jsdl2Result physicalDeleteJsdl2(Integer[] idArr);

	MsgResult physicalDeleteMsg(String[] paramArrayOfString);

	ReceiveFailedResult physicalDeleteReceiveFailed(Integer[] idArr);

	StatuReportResult physicalDeleteStatuReport(Integer[] idArr);
}