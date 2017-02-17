/**
 * Result.java
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.lauvan.meip.client;

@SuppressWarnings({"rawtypes", "unused"})
public class Result implements java.io.Serializable {
	private static final long	serialVersionUID	= 548196260208636886L;

	private java.lang.String	msg;

	private boolean				success;

	private java.lang.Integer	total;

	public Result() {
	}

	public Result(java.lang.String msg, boolean success, java.lang.Integer total) {
		this.msg = msg;
		this.success = success;
		this.total = total;
	}

	public java.lang.String getMsg() {
		return msg;
	}

	public void setMsg(java.lang.String msg) {
		this.msg = msg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public java.lang.Integer getTotal() {
		return total;
	}

	public void setTotal(java.lang.Integer total) {
		this.total = total;
	}

	private java.lang.Object __equalsCalc = null;

	@Override
	public synchronized boolean equals(java.lang.Object obj) {
		if(!(obj instanceof Result)) {
			return false;
		}
		Result other = (Result)obj;
		if(obj == null) {
			return false;
		}
		if(this == obj) {
			return true;
		}
		if(__equalsCalc != null) {
			return __equalsCalc == obj;
		}
		__equalsCalc = obj;
		boolean _equals;
		_equals = true && (msg == null && other.getMsg() == null || msg != null && msg.equals(other.getMsg())) && success == other.isSuccess() && (total == null && other.getTotal() == null || total != null && total.equals(other.getTotal()));
		__equalsCalc = null;
		return _equals;
	}

	private boolean __hashCodeCalc = false;

	@Override
	public synchronized int hashCode() {
		if(__hashCodeCalc) {
			return 0;
		}
		__hashCodeCalc = true;
		int _hashCode = 1;
		if(getMsg() != null) {
			_hashCode += getMsg().hashCode();
		}
		_hashCode += (isSuccess() ? Boolean.TRUE : Boolean.FALSE).hashCode();
		if(getTotal() != null) {
			_hashCode += getTotal().hashCode();
		}
		__hashCodeCalc = false;
		return _hashCode;
	}

	private static org.apache.axis.description.TypeDesc typeDesc = new org.apache.axis.description.TypeDesc(Result.class, true);

	static {
		typeDesc.setXmlType(new javax.xml.namespace.QName("http://service.meip.lauvan.com/", "result"));
		org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("msg");
		elemField.setXmlName(new javax.xml.namespace.QName("", "msg"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("success");
		elemField.setXmlName(new javax.xml.namespace.QName("", "success"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
		elemField = new org.apache.axis.description.ElementDesc();
		elemField.setFieldName("total");
		elemField.setXmlName(new javax.xml.namespace.QName("", "total"));
		elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
		elemField.setMinOccurs(0);
		elemField.setNillable(false);
		typeDesc.addFieldDesc(elemField);
	}

	public static org.apache.axis.description.TypeDesc getTypeDesc() {
		return typeDesc;
	}

	public static org.apache.axis.encoding.Serializer getSerializer(java.lang.String mechType, java.lang.Class _javaType, javax.xml.namespace.QName _xmlType) {
		return new org.apache.axis.encoding.ser.BeanSerializer(_javaType, _xmlType, typeDesc);
	}

	public static org.apache.axis.encoding.Deserializer getDeserializer(java.lang.String mechType, java.lang.Class _javaType, javax.xml.namespace.QName _xmlType) {
		return new org.apache.axis.encoding.ser.BeanDeserializer(_javaType, _xmlType, typeDesc);
	}

}
