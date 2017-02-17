/**
 * Service.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

public interface Service extends javax.xml.rpc.Service {
	public java.lang.String getMeipServiceImplPortAddress();

	public com.lauvan.meip.client.MeipService getMeipServiceImplPort() throws javax.xml.rpc.ServiceException;

	public com.lauvan.meip.client.MeipService getMeipServiceImplPort(java.net.URL portAddress)
		throws javax.xml.rpc.ServiceException;
}
