package com.lauvan.meip.service;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;

import com.lauvan.meip.service.db.service.DBService;
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

@WebService(endpointInterface = "com.lauvan.meip.service.MeipService", serviceName = "service")
public class MeipServiceImpl
	implements MeipService {

	@Autowired
	private DBService dbService;

	@Override
	public DfsdlResult send(DfsdlItem item) {
		return dbService.send(item);
	}

	@Override
	public DfsdlResult resend(Integer[] idArr) {
		return dbService.resend(idArr);
	}

	@Override
	public JsdlResult updateJsdlStatus(Integer id) {
		return dbService.updateJsdlStatus(id);
	}

	@Override
	public DfsdlResult getDfsdlById(Integer id) {
		return dbService.getDfsdlById(id);
	}

	@Override
	public YfsdlResult getYfsdlById(Integer id) {
		return dbService.getYfsdlById(id);
	}

	@Override
	public JsdlResult getLatestJsdl() {
		return dbService.getLatestJsdl();
	}

	@Override
	public JsdlResult getJsdlById(Integer id) {
		return dbService.getJsdlById(id);
	}

	@Override
	public Jsdl2Result getJsdl2ById(Integer id) {
		return dbService.getJsdl2ById(id);
	}

	@Override
	public MsgResult getMsgById(Integer id) {
		return dbService.getMsgById(id);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedById(Integer id) {
		return dbService.getReceiveFailedById(id);
	}

	@Override
	public StatuReportResult getStatuReportById(Integer id) {
		return dbService.getStatuReportById(id);
	}

	@Override
	public DfsdlResult getAllDfsdl() {
		return dbService.getAllDfsdl();
	}

	@Override
	public YfsdlResult getAllYfdl() {
		return dbService.getAllYfdl();
	}

	@Override
	public JsdlResult getAllJsdl() {
		return dbService.getAllJsdl();
	}

	@Override
	public Jsdl2Result getAllJsdl2() {
		return dbService.getAllJsdl2();
	}

	@Override
	public MsgResult getAllMsg() {
		return dbService.getAllMsg();
	}

	@Override
	public ReceiveFailedResult getAllReceiveFailed() {
		return dbService.getAllReceiveFailed();
	}

	@Override
	public StatuReportResult getAllStatuReport() {
		return dbService.getAllStatuReport();
	}

	@Override
	public DfsdlResult getDfsdlByItem(DfsdlItem item) {
		return dbService.getDfsdlByItem(item);
	}

	@Override
	public YfsdlResult getYfsdlByItem(YfsdlItem item) {
		return dbService.getYfsdlByItem(item);
	}

	@Override
	public JsdlResult getJsdlByItem(JsdlItem item) {
		return dbService.getJsdlByItem(item);
	}

	@Override
	public Jsdl2Result getJsdl2ByItem(Jsdl2Item item) {
		return dbService.getJsdl2ByItem(item);
	}

	@Override
	public MsgResult getMsgByItem(MsgItem item) {
		return dbService.getMsgByItem(item);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedByItem(ReceiveFailedItem item) {
		return dbService.getReceiveFailedByItem(item);
	}

	@Override
	public StatuReportResult getStatuReportByItem(StatuReportItem item) {
		return dbService.getStatuReportByItem(item);
	}

	@Override
	public DfsdlResult getDfsdlPage(DfsdlItem item) {
		return dbService.getDfsdlPage(item);
	}

	@Override
	public YfsdlResult getYfsdlPage(YfsdlItem item) {
		return dbService.getYfsdlPage(item);
	}

	@Override
	public JsdlResult getJsdlPage(JsdlItem item) {
		return dbService.getJsdlPage(item);
	}

	@Override
	public Jsdl2Result getJsdl2Page(Jsdl2Item item) {
		return dbService.getJsdl2Page(item);
	}

	@Override
	public MsgResult getMsgPage(MsgItem item) {
		return dbService.getMsgPage(item);
	}

	@Override
	public MsgResult getMsgGroupPage(MsgItem item) {
		return dbService.getMsgGroupPage(item);
	}

	@Override
	public ReceiveFailedResult getReceiveFailedPage(ReceiveFailedItem item) {
		return dbService.getReceiveFailedPage(item);
	}

	@Override
	public StatuReportResult getStatuReportPage(StatuReportItem item) {
		return dbService.getStatuReportPage(item);
	}

	@Override
	public DfsdlResult deleteDfsdl(Integer[] idArr) {
		return dbService.deleteDfsdl(idArr);
	}

	@Override
	public YfsdlResult deleteYfsdl(Integer[] idArr) {
		return dbService.deleteYfsdl(idArr);
	}

	@Override
	public JsdlResult deleteJsdl(Integer[] idArr) {
		return dbService.deleteJsdl(idArr);
	}

	@Override
	public Jsdl2Result deleteJsdl2(Integer[] idArr) {
		return dbService.deleteJsdl2(idArr);
	}

	@Override
	public MsgResult deleteMsg(String[] idArr) {
		return dbService.deleteMsg(idArr);
	}

	@Override
	public ReceiveFailedResult deleteReceiveFailed(Integer[] idArr) {
		return dbService.deleteReceiveFailed(idArr);
	}

	@Override
	public StatuReportResult deleteStatuReport(Integer[] idArr) {
		return dbService.deleteStatuReport(idArr);
	}

	@Override
	public DfsdlResult physicalDeleteDfsdl(Integer[] idArr) {
		return dbService.physicalDeleteDfsdl(idArr);
	}

	@Override
	public YfsdlResult physicalDeleteYfsdl(Integer[] idArr) {
		return dbService.physicalDeleteYfsdl(idArr);
	}

	@Override
	public JsdlResult physicalDeleteJsdl(Integer[] idArr) {
		return dbService.physicalDeleteJsdl(idArr);
	}

	@Override
	public Jsdl2Result physicalDeleteJsdl2(Integer[] idArr) {
		return dbService.physicalDeleteJsdl2(idArr);
	}

	@Override
	public MsgResult physicalDeleteMsg(String[] idArr) {
		return dbService.physicalDeleteMsg(idArr);
	}

	@Override
	public ReceiveFailedResult physicalDeleteReceiveFailed(Integer[] idArr) {
		return dbService.physicalDeleteReceiveFailed(idArr);
	}

	@Override
	public StatuReportResult physicalDeleteStatuReport(Integer[] idArr) {
		return dbService.physicalDeleteStatuReport(idArr);
	}
}
