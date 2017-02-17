/**
 * SMsg_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.apps.massms.service;

public interface SMsg_PortType extends java.rmi.Remote {
    public void main(java.lang.String[] args) throws java.rmi.RemoteException;
    public java.lang.Object invoke(java.lang.String shell) throws java.rmi.RemoteException;
    public int init(java.lang.String dbIp, java.lang.String dbName, java.lang.String dbPort, java.lang.String user, java.lang.String pwd) throws java.rmi.RemoteException;
    public int release() throws java.rmi.RemoteException;
    public boolean flushHost() throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, long smID) throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, long smID, long srcID) throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, long smID, java.lang.String url) throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, long smID, long srcID, java.lang.String url) throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, java.lang.String sendTime, long smID, long srcID) throws java.rmi.RemoteException;
    public int sendSM(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, java.lang.String content, long smID, long srcID, java.lang.String url, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String recvRPT(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd) throws java.rmi.RemoteException;
    public int sendPDU(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, byte[] content, long smID, int msgFmt, int tpPID, int tpUdhi, java.lang.String feeTerminalID, java.lang.String feeType, java.lang.String feeCode, int feeUserType) throws java.rmi.RemoteException;
    public int sendPDU(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd, java.lang.String[] mobiles, byte[] content, long smID, long srcID, int msgFmt, int tpPID, int tpUdhi, java.lang.String feeTerminalID, java.lang.String feeType, java.lang.String feeCode, int feeUserType) throws java.rmi.RemoteException;
    public java.lang.String recvMo(java.lang.String apiCode, java.lang.String loginName, java.lang.String loginPwd) throws java.rmi.RemoteException;
    public boolean checkTime(java.lang.String sendTime) throws java.rmi.RemoteException;
}
