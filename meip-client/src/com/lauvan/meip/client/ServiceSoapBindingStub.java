/**
 * ServiceSoapBindingStub.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unchecked"})
public class ServiceSoapBindingStub extends org.apache.axis.client.Stub implements com.lauvan.meip.client.MeipService {
	private java.util.Vector							cachedSerClasses		= new java.util.Vector();
	private java.util.Vector							cachedSerQNames			= new java.util.Vector();
	private java.util.Vector							cachedSerFactories		= new java.util.Vector();
	private java.util.Vector							cachedDeserFactories	= new java.util.Vector();

	static org.apache.axis.description.OperationDesc[]	_operations;

	static {
		_operations = new org.apache.axis.description.OperationDesc[47];
		_initOperationDesc1();
		_initOperationDesc2();
		_initOperationDesc3();
		_initOperationDesc4();
		_initOperationDesc5();
	}

	private static void _initOperationDesc1() {
		org.apache.axis.description.OperationDesc oper;
		org.apache.axis.description.ParameterDesc param;
		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getDfsdlPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem"), com.lauvan.meip.client.DfsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[0] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdl2ById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[1] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getStatuReportByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportItem"), com.lauvan.meip.client.StatuReportItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[2] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("send");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem"), com.lauvan.meip.client.DfsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[3] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllReceiveFailed");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[4] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteReceiveFailed");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[5] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getMsgByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgItem"), com.lauvan.meip.client.MsgItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[6] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getYfsdlByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlItem"), com.lauvan.meip.client.YfsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[7] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteStatuReport");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[8] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdl2Page");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Item"), com.lauvan.meip.client.Jsdl2Item.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[9] = oper;

	}

	private static void _initOperationDesc2() {
		org.apache.axis.description.OperationDesc oper;
		org.apache.axis.description.ParameterDesc param;
		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteMsg");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[10] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getDfsdlById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[11] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllJsdl");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[12] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("resend");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[13] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllJsdl2");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[14] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteDfsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[15] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteJsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[16] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getStatuReportById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[17] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getYfsdlById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[18] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getReceiveFailedById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[19] = oper;

	}

	private static void _initOperationDesc3() {
		org.apache.axis.description.OperationDesc oper;
		org.apache.axis.description.ParameterDesc param;
		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteJsdl2");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[20] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllStatuReport");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[21] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteJsdl2");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[22] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getReceiveFailedPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedItem"), com.lauvan.meip.client.ReceiveFailedItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[23] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getMsgById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[24] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("updateJsdlStatus");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[25] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getYfsdlPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlItem"), com.lauvan.meip.client.YfsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[26] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteYfsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[27] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteYfsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[28] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getStatuReportPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportItem"), com.lauvan.meip.client.StatuReportItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[29] = oper;

	}

	private static void _initOperationDesc4() {
		org.apache.axis.description.OperationDesc oper;
		org.apache.axis.description.ParameterDesc param;
		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getLatestJsdl");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[30] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdlByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlItem"), com.lauvan.meip.client.JsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[31] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getMsgPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgItem"), com.lauvan.meip.client.MsgItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[32] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteReceiveFailed");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[33] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteJsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[34] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllYfdl");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.YfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[35] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteDfsdl");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[36] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdl2ByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Item"), com.lauvan.meip.client.Jsdl2Item.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result"));
		oper.setReturnClass(com.lauvan.meip.client.Jsdl2Result.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[37] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllMsg");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[38] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("deleteMsg");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[39] = oper;

	}

	private static void _initOperationDesc5() {
		org.apache.axis.description.OperationDesc oper;
		org.apache.axis.description.ParameterDesc param;
		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getAllDfsdl");
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[40] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdlPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlItem"), com.lauvan.meip.client.JsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[41] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getMsgGroupPage");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgItem"), com.lauvan.meip.client.MsgItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult"));
		oper.setReturnClass(com.lauvan.meip.client.MsgResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[42] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getDfsdlByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem"), com.lauvan.meip.client.DfsdlItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.DfsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[43] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getJsdlById");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), java.lang.Integer.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult"));
		oper.setReturnClass(com.lauvan.meip.client.JsdlResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[44] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("physicalDeleteStatuReport");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int[].class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult"));
		oper.setReturnClass(com.lauvan.meip.client.StatuReportResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[45] = oper;

		oper = new org.apache.axis.description.OperationDesc();
		oper.setName("getReceiveFailedByItem");
		param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedItem"), com.lauvan.meip.client.ReceiveFailedItem.class, false, false);
		param.setOmittable(true);
		oper.addParameter(param);
		oper.setReturnType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult"));
		oper.setReturnClass(com.lauvan.meip.client.ReceiveFailedResult.class);
		oper.setReturnQName(new javax.xml.namespace.QName("", "return"));
		oper.setStyle(org.apache.axis.constants.Style.WRAPPED);
		oper.setUse(org.apache.axis.constants.Use.LITERAL);
		_operations[46] = oper;

	}

	public ServiceSoapBindingStub() throws org.apache.axis.AxisFault {
		this(null);
	}

	public ServiceSoapBindingStub(java.net.URL endpointURL, javax.xml.rpc.Service service)
		throws org.apache.axis.AxisFault {
		this(service);
		super.cachedEndpoint = endpointURL;
	}

	public ServiceSoapBindingStub(javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
		if(service == null) {
			super.service = new org.apache.axis.client.Service();
		} else {
			super.service = service;
		}
		((org.apache.axis.client.Service)super.service).setTypeMappingVersion("1.2");
		java.lang.Class cls;
		javax.xml.namespace.QName qName;
		java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
		java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.DfsdlItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "dfsdlResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.DfsdlResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "item");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.Item.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Item");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.Jsdl2Item.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdl2Result");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.Jsdl2Result.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.JsdlItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "jsdlResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.JsdlResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.MsgItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "msgResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.MsgResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.ReceiveFailedItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "receiveFailedResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.ReceiveFailedResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "result");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.Result.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.StatuReportItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "statuReportResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.StatuReportResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlItem");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.YfsdlItem.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

		qName = new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "yfsdlResult");
		cachedSerQNames.add(qName);
		cls = com.lauvan.meip.client.YfsdlResult.class;
		cachedSerClasses.add(cls);
		cachedSerFactories.add(beansf);
		cachedDeserFactories.add(beandf);

	}

	protected org.apache.axis.client.Call createCall() throws java.rmi.RemoteException {
		try {
			org.apache.axis.client.Call _call = super._createCall();
			if(super.maintainSessionSet) {
				_call.setMaintainSession(super.maintainSession);
			}
			if(super.cachedUsername != null) {
				_call.setUsername(super.cachedUsername);
			}
			if(super.cachedPassword != null) {
				_call.setPassword(super.cachedPassword);
			}
			if(super.cachedEndpoint != null) {
				_call.setTargetEndpointAddress(super.cachedEndpoint);
			}
			if(super.cachedTimeout != null) {
				_call.setTimeout(super.cachedTimeout);
			}
			if(super.cachedPortName != null) {
				_call.setPortName(super.cachedPortName);
			}
			java.util.Enumeration keys = super.cachedProperties.keys();
			while(keys.hasMoreElements()) {
				java.lang.String key = (java.lang.String)keys.nextElement();
				_call.setProperty(key, super.cachedProperties.get(key));
			}

			synchronized(this) {
				if(firstCall()) {

					_call.setEncodingStyle(null);
					for(int i = 0; i < cachedSerFactories.size(); ++i) {
						java.lang.Class cls = (java.lang.Class)cachedSerClasses.get(i);
						javax.xml.namespace.QName qName = (javax.xml.namespace.QName)cachedSerQNames.get(i);
						java.lang.Object x = cachedSerFactories.get(i);
						if(x instanceof Class) {
							java.lang.Class sf = (java.lang.Class)cachedSerFactories.get(i);
							java.lang.Class df = (java.lang.Class)cachedDeserFactories.get(i);
							_call.registerTypeMapping(cls, qName, sf, df, false);
						} else if(x instanceof javax.xml.rpc.encoding.SerializerFactory) {
							org.apache.axis.encoding.SerializerFactory sf = (org.apache.axis.encoding.SerializerFactory)cachedSerFactories.get(i);
							org.apache.axis.encoding.DeserializerFactory df = (org.apache.axis.encoding.DeserializerFactory)cachedDeserFactories.get(i);
							_call.registerTypeMapping(cls, qName, sf, df, false);
						}
					}
				}
			}
			return _call;
		} catch(java.lang.Throwable _t) {
			throw new org.apache.axis.AxisFault("Failure trying to get the Call object", _t);
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult getDfsdlPage(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[0]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getDfsdlPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result getJsdl2ById(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[1]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdl2ById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult getStatuReportByItem(com.lauvan.meip.client.StatuReportItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[2]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getStatuReportByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult send(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[3]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "send"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult getAllReceiveFailed() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[4]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllReceiveFailed"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult deleteReceiveFailed(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[5]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteReceiveFailed"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult getMsgByItem(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[6]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getMsgByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult getYfsdlByItem(com.lauvan.meip.client.YfsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[7]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getYfsdlByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult deleteStatuReport(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[8]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteStatuReport"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result getJsdl2Page(com.lauvan.meip.client.Jsdl2Item arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[9]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdl2Page"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult physicalDeleteMsg(java.lang.String[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[10]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteMsg"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult getDfsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[11]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getDfsdlById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult getAllJsdl() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[12]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllJsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult resend(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[13]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "resend"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result getAllJsdl2() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[14]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllJsdl2"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult physicalDeleteDfsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[15]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteDfsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult deleteJsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[16]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteJsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult getStatuReportById(java.lang.Integer arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[17]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getStatuReportById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult getYfsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[18]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getYfsdlById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedById(java.lang.Integer arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[19]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getReceiveFailedById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result deleteJsdl2(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[20]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteJsdl2"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult getAllStatuReport() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[21]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllStatuReport"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result physicalDeleteJsdl2(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[22]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteJsdl2"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedPage(com.lauvan.meip.client.ReceiveFailedItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[23]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getReceiveFailedPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult getMsgById(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[24]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getMsgById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult updateJsdlStatus(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[25]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "updateJsdlStatus"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult getYfsdlPage(com.lauvan.meip.client.YfsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[26]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getYfsdlPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult physicalDeleteYfsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[27]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteYfsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult deleteYfsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[28]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteYfsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult getStatuReportPage(com.lauvan.meip.client.StatuReportItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[29]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getStatuReportPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult getLatestJsdl() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[30]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getLatestJsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult getJsdlByItem(com.lauvan.meip.client.JsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[31]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdlByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult getMsgPage(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[32]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getMsgPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult physicalDeleteReceiveFailed(int[] arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[33]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteReceiveFailed"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult physicalDeleteJsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[34]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteJsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.YfsdlResult getAllYfdl() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[35]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllYfdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.YfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.YfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.YfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult deleteDfsdl(int[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[36]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteDfsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.Jsdl2Result getJsdl2ByItem(com.lauvan.meip.client.Jsdl2Item arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[37]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdl2ByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.Jsdl2Result)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.Jsdl2Result)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.Jsdl2Result.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult getAllMsg() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[38]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllMsg"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult deleteMsg(java.lang.String[] arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[39]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "deleteMsg"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult getAllDfsdl() throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[40]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getAllDfsdl"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult getJsdlPage(com.lauvan.meip.client.JsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[41]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdlPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.MsgResult getMsgGroupPage(com.lauvan.meip.client.MsgItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[42]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getMsgGroupPage"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.MsgResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.MsgResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.MsgResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.DfsdlResult getDfsdlByItem(com.lauvan.meip.client.DfsdlItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[43]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getDfsdlByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.DfsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.DfsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.DfsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.JsdlResult getJsdlById(java.lang.Integer arg0) throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[44]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getJsdlById"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.JsdlResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.JsdlResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.JsdlResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.StatuReportResult physicalDeleteStatuReport(int[] arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[45]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "physicalDeleteStatuReport"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.StatuReportResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.StatuReportResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.StatuReportResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

	@Override
	public com.lauvan.meip.client.ReceiveFailedResult getReceiveFailedByItem(com.lauvan.meip.client.ReceiveFailedItem arg0)
		throws java.rmi.RemoteException {
		if(super.cachedEndpoint == null) {
			throw new org.apache.axis.NoEndPointException();
		}
		org.apache.axis.client.Call _call = createCall();
		_call.setOperation(_operations[46]);
		_call.setUseSOAPAction(true);
		_call.setSOAPActionURI("");
		_call.setEncodingStyle(null);
		_call.setProperty(org.apache.axis.client.Call.SEND_TYPE_ATTR, Boolean.FALSE);
		_call.setProperty(org.apache.axis.AxisEngine.PROP_DOMULTIREFS, Boolean.FALSE);
		_call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
		_call.setOperationName(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "getReceiveFailedByItem"));

		setRequestHeaders(_call);
		setAttachments(_call);
		try {
			java.lang.Object _resp = _call.invoke(new java.lang.Object[]{arg0});

			if(_resp instanceof java.rmi.RemoteException) {
				throw (java.rmi.RemoteException)_resp;
			} else {
				extractAttachments(_call);
				try {
					return (com.lauvan.meip.client.ReceiveFailedResult)_resp;
				} catch(java.lang.Exception _exception) {
					return (com.lauvan.meip.client.ReceiveFailedResult)org.apache.axis.utils.JavaUtils.convert(_resp, com.lauvan.meip.client.ReceiveFailedResult.class);
				}
			}
		} catch(org.apache.axis.AxisFault axisFaultException) {
			throw axisFaultException;
		}
	}

}
