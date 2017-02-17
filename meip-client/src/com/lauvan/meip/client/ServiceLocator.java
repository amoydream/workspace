/**
 * ServiceLocator.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unchecked"})
public class ServiceLocator extends org.apache.axis.client.Service implements com.lauvan.meip.client.Service {
	private static final long	serialVersionUID			= -1410639828654719811L;

	private java.lang.String	MeipServiceImplPort_address	= "";

	public ServiceLocator() {
	}

	public ServiceLocator(String serviceUrl) {
		MeipServiceImplPort_address = serviceUrl;
	}

	public ServiceLocator(org.apache.axis.EngineConfiguration config) {
		super(config);
	}

	public ServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName)
		throws javax.xml.rpc.ServiceException {
		super(wsdlLoc, sName);
	}

	@Override
	public java.lang.String getMeipServiceImplPortAddress() {
		return MeipServiceImplPort_address;
	}

	private java.lang.String MeipServiceImplPortWSDDServiceName = "MeipServiceImplPort";

	public java.lang.String getMeipServiceImplPortWSDDServiceName() {
		return MeipServiceImplPortWSDDServiceName;
	}

	public void setMeipServiceImplPortWSDDServiceName(java.lang.String name) {
		MeipServiceImplPortWSDDServiceName = name;
	}

	@Override
	public com.lauvan.meip.client.MeipService getMeipServiceImplPort() throws javax.xml.rpc.ServiceException {
		java.net.URL endpoint;
		try {
			endpoint = new java.net.URL(MeipServiceImplPort_address);
		} catch(java.net.MalformedURLException e) {
			throw new javax.xml.rpc.ServiceException(e);
		}
		return getMeipServiceImplPort(endpoint);
	}

	@Override
	public com.lauvan.meip.client.MeipService getMeipServiceImplPort(java.net.URL portAddress)
		throws javax.xml.rpc.ServiceException {
		try {
			com.lauvan.meip.client.ServiceSoapBindingStub _stub = new com.lauvan.meip.client.ServiceSoapBindingStub(portAddress, this);
			_stub.setPortName(getMeipServiceImplPortWSDDServiceName());
			return _stub;
		} catch(org.apache.axis.AxisFault e) {
			return null;
		}
	}

	public void setMeipServiceImplPortEndpointAddress(java.lang.String address) {
		MeipServiceImplPort_address = address;
	}

	@Override
	public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
		try {
			if(com.lauvan.meip.client.MeipService.class.isAssignableFrom(serviceEndpointInterface)) {
				com.lauvan.meip.client.ServiceSoapBindingStub _stub = new com.lauvan.meip.client.ServiceSoapBindingStub(new java.net.URL(MeipServiceImplPort_address), this);
				_stub.setPortName(getMeipServiceImplPortWSDDServiceName());
				return _stub;
			}
		} catch(java.lang.Throwable t) {
			throw new javax.xml.rpc.ServiceException(t);
		}
		throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
	}

	@Override
	public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface)
		throws javax.xml.rpc.ServiceException {
		if(portName == null) {
			return getPort(serviceEndpointInterface);
		}
		java.lang.String inputPortName = portName.getLocalPart();
		if("MeipServiceImplPort".equals(inputPortName)) {
			return getMeipServiceImplPort();
		} else {
			java.rmi.Remote _stub = getPort(serviceEndpointInterface);
			((org.apache.axis.client.Stub)_stub).setPortName(portName);
			return _stub;
		}
	}

	@Override
	public javax.xml.namespace.QName getServiceName() {
		return new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "service");
	}

	private java.util.HashSet ports = null;

	@Override
	public java.util.Iterator getPorts() {
		if(ports == null) {
			ports = new java.util.HashSet();
			ports.add(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "MeipServiceImplPort"));
		}
		return ports.iterator();
	}

	public void setEndpointAddress(java.lang.String portName, java.lang.String address)
		throws javax.xml.rpc.ServiceException {

		if("MeipServiceImplPort".equals(portName)) {
			setMeipServiceImplPortEndpointAddress(address);
		} else { // Unknown Port Name
			throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
		}
	}

	public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address)
		throws javax.xml.rpc.ServiceException {
		setEndpointAddress(portName.getLocalPart(), address);
	}

}
