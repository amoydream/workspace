/**
 * MeipService.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

public interface MeipService extends java.rmi.Remote {
	public com.lauvan.meip.client.DfsdlResult getDfsdlPage(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result getJsdl2ById(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult getStatuReportByItem(com.lauvan.meip.client.StatuReportItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult send(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult getAllReceiveFailed() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult deleteReceiveFailed(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult getMsgByItem(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult getYfsdlByItem(com.lauvan.meip.client.YfsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult deleteStatuReport(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result getJsdl2Page(com.lauvan.meip.client.Jsdl2Item arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult physicalDeleteMsg(java.lang.String[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult getDfsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult getAllJsdl() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult resend(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result getAllJsdl2() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult physicalDeleteDfsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult deleteJsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult getStatuReportById(java.lang.Integer arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult getYfsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedById(java.lang.Integer arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result deleteJsdl2(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult getAllStatuReport() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result physicalDeleteJsdl2(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedPage(com.lauvan.meip.client.ReceiveFailedItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult getMsgById(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult updateJsdlStatus(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult getYfsdlPage(com.lauvan.meip.client.YfsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult physicalDeleteYfsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult deleteYfsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult getStatuReportPage(com.lauvan.meip.client.StatuReportItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult getLatestJsdl() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult getJsdlByItem(com.lauvan.meip.client.JsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult getMsgPage(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult physicalDeleteReceiveFailed(int[] arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult physicalDeleteJsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.YfsdlResult getAllYfdl() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult deleteDfsdl(int[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.Jsdl2Result getJsdl2ByItem(com.lauvan.meip.client.Jsdl2Item arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult getAllMsg() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult deleteMsg(java.lang.String[] arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult getAllDfsdl() throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult getJsdlPage(com.lauvan.meip.client.JsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.MsgResult getMsgGroupPage(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.DfsdlResult getDfsdlByItem(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.JsdlResult getJsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException;

	public com.lauvan.meip.client.StatuReportResult physicalDeleteStatuReport(int[] arg0)
		throws java.rmi.RemoteException;

	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedByItem(com.lauvan.meip.client.ReceiveFailedItem arg0)
		throws java.rmi.RemoteException;
}
